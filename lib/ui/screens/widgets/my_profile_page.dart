import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recreapp/constants.dart';
import 'package:recreapp/ui/screens/widgets/custom_textfield.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController cellphoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user.uid)
          .get();

      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      fullNameController.text = data['nombre'] ?? '';
      lastnameController.text = data['apellido'] ?? '';
      cellphoneController.text = data['telefono'] ?? '';
      addressController.text = data['direccion'] ?? '';

      // Load profile image if exists
      String? imageUrl = data['profileImageUrl'];
      if (imageUrl != null) {
        setState(() {
          _imageFile = File(imageUrl);
        });
      }
    }
  }

  Future<void> _updateUserData() async {
    if (cellphoneController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El número de teléfono debe contener 10 dígitos.'),
        ),
      );
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await _uploadProfileImage(_imageFile!);
      }

      await FirebaseFirestore.instance.collection('usuarios').doc(user.uid).update({
        'nombre': fullNameController.text,
        'apellido': lastnameController.text,
        'telefono': cellphoneController.text,
        'direccion': addressController.text,
        'profileImageUrl': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Datos actualizados exitosamente.'),
        ),
      );
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadProfileImage(File image) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("No user logged in");
    }
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('profile_images').child(user.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Editar información del perfil',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  Container(
                    width: 150,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : NetworkImage(
                          'https://example.com/path/to/your/profile/image.jpg'), // Reemplaza la URL con la ubicación de tu imagen por defecto
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Constants.primaryColor.withOpacity(.5),
                        width: 5.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 60, // Tamaño del círculo verde
                      height: 30, // Tamaño del círculo verde
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green[800],
                      ),
                      child: IconButton(
                        iconSize: 16, // Tamaño del ícono de edición dentro del círculo
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: fullNameController,
                obscureText: false,
                hintText: 'Ingrese nombre',
                icon: Icons.person,
              ),
              CustomTextfield(
                controller: lastnameController,
                obscureText: false,
                hintText: 'Ingrese apellido',
                icon: Icons.person,
              ),
              CustomTextfield(
                controller: cellphoneController,
                obscureText: false,
                hintText: 'Ingrese teléfono',
                icon: Icons.call,
              ),
              CustomTextfield(
                controller: addressController,
                obscureText: false,
                hintText: 'Ingrese dirección',
                icon: Icons.assignment,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _updateUserData,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Center(
                    child: Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

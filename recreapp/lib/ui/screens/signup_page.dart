import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recreapp/constants.dart';

import 'package:page_transition/page_transition.dart';
import 'package:recreapp/ui/screens/signin_page.dart';
import 'package:recreapp/ui/screens/widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController cellphoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    passwordController.dispose();
    lastnameController.dispose();
    cellphoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> signUpWithEmailAndPassword() async {
    // Validar campos
    if (emailController.text.isEmpty ||
        fullNameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        lastnameController.text.isEmpty ||
        cellphoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos.'),
        ),
      );
      return;
    }

    // Validar longitud del teléfono
    if (cellphoneController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El teléfono debe tener 10 dígitos.'),
        ),
      );
      return;
    }

    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Guarda el nombre completo del usuario en Firestore
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set({
        'nombre': fullNameController.text,
        'apellido': lastnameController.text,
        'telefono': cellphoneController.text,
        'direccion': addressController.text,
      });
      // Navega al siguiente paso después de registrar al usuario
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const SignIn(),
          type: PageTransitionType.bottomToTop,
        ),
      );
    } catch (e) {
      // Maneja errores de registro aquí
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error al registrar usuario: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/signup.png'),
              const Text(
                'Crear cuenta',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                controller: emailController,
                obscureText: false,
                hintText: 'Ingrese correo',
                icon: Icons.alternate_email,
              ),

              CustomTextfield(
                controller: passwordController,
                obscureText: true,
                hintText: 'Ingrese contraseña',
                icon: Icons.lock,
              ),
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
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: signUpWithEmailAndPassword,
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Center(
                    child: Text(
                      'Registrar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('O'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Constants.primaryColor),
                    borderRadius: BorderRadius.circular(10)),
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Image.asset('assets/images/google.png'),
                    ),
                    Text(
                      'Registrar con Google',
                      style: TextStyle(
                        color: Constants.blackColor,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const SignIn(),
                          type: PageTransitionType.bottomToTop));
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Tengo una cuenta? ',
                        style: TextStyle(
                          color: Constants.blackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Iniciar sesión',
                        style: TextStyle(
                          color: Constants.primaryColor,
                        ),
                      ),
                    ]),
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

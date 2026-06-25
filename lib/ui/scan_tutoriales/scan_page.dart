import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recreapp/constants.dart';
import 'package:recreapp/ui/scan_tutoriales/edit_info.dart';
import '../../service/firebase_service.dart';
import 'editar_proyecto.dart';

class ScanPage extends StatefulWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late File _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1), // Espacio arriba
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Logo1.png',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10), // Espacio entre la imagen y el texto
                Text(
                  'Mis proyectos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<String>(
              future: widget._firebaseService.getCurrentUserId(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  String userId = snapshot.data!;
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('usuarios')
                        .doc(userId)
                        .collection('projects')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        var projects = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: projects.length,
                          itemBuilder: (context, index) {
                            var project = projects[index].data() as Map<String, dynamic>;
                            return ProjectItem(
                              projectName: project['Titulo'],
                              imageUrl: project['ImagenUrl'],
                              onTap: () {},
                              onEdit: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProjectPage(
                                      projectId: projects[index].id,
                                      projectData: project,
                                    ),
                                  ),
                                );
                              },
                              onDelete: () {
                                widget._firebaseService.deleteUserProject(userId, projects[index].id);
                              },
                              onShare: () {
                                widget._firebaseService.shareProjectGlobally(projects[index].id, project); // Pasar el ID del proyecto y el mapa de datos del proyecto
                              },
                              project: project, // Pasar el proyecto al constructor
                            );
                          },
                        );
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showImageSourceDialog();
        },
        child: Icon(Icons.camera_alt),
        backgroundColor: Constants.primaryColor,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo),
                    SizedBox(width: 5.0),
                    Text('Seleccionar Galeria'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.camera);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 5.0),
                    Text('Seleccionar Cámara'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _navigateToEditImagePage();
    }
  }

  void _navigateToEditImagePage() {
    XFile xFile = XFile(_imageFile.path);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditImagePage(imageFile: xFile),
      ),
    );
  }
}

class ProjectItem extends StatelessWidget {
  final String projectName;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final Map<String, dynamic> project; // Nuevo parámetro

  const ProjectItem({
    required this.projectName,
    required this.imageUrl,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onShare,
    required this.project, // Agregar al constructor
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(projectName),
      leading: Image.network(
        imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      onTap: onTap,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: onShare,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

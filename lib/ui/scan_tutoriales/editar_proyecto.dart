import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProjectPage extends StatefulWidget {
  final String projectId;
  final Map<String, dynamic> projectData;

  const EditProjectPage({
    required this.projectId,
    required this.projectData,
  });

  @override
  _EditProjectPageState createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _projectNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagsController;
  late TextEditingController _materialsController;
  late TextEditingController _categoryController;
  late TextEditingController _difficultyController;
  late TextEditingController _instructionsController;
  late TextEditingController _videoTutorialController;

  @override
  void initState() {
    super.initState();
    _projectNameController =
        TextEditingController(text: widget.projectData['Titulo']);
    _descriptionController =
        TextEditingController(text: widget.projectData['Descripcion']);
    _tagsController =
        TextEditingController(text: widget.projectData['Etiquetas']);
    _materialsController =
        TextEditingController(text: widget.projectData['Materiales']);
    _categoryController =
        TextEditingController(text: widget.projectData['Categoria']);
    _difficultyController =
        TextEditingController(text: widget.projectData['Dificultad']);
    _instructionsController =
        TextEditingController(text: widget.projectData['Instrucciones']);
    _videoTutorialController =
        TextEditingController(text: widget.projectData['VideoTutorial']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Proyecto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_projectNameController, 'Titulo', Icons.title),
              _buildTextField(
                  _descriptionController, 'Descripcion', Icons.description),
              _buildTextField(_tagsController, 'Etiquetas', Icons.tag),
              _buildTextField(_materialsController, 'Materiales', Icons.build),
              _buildTextField(_categoryController, 'Categoria', Icons.category),
              _buildTextField(
                  _difficultyController, 'Dificultad', Icons.assessment),
              _buildTextField(
                  _instructionsController, 'Instrucciones', Icons.menu_book),
              _buildTextField(_videoTutorialController, 'Video Tutorial',
                  Icons.video_library),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProject,
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Este campo es obligatorio';
          }
          return null;
        },
      ),
    );
  }

  void _saveProject() {
    print('Guardando proyecto...');
    if (_formKey.currentState!.validate()) {
      print('Formulario válido, actualizando...');
      final updatedData = {
        'Titulo': _projectNameController.text,
        'Descripcion': _descriptionController.text,
        'Etiquetas': _tagsController.text,
        'Materiales': _materialsController.text,
        'Categoria': _categoryController.text,
        'Dificultad': _difficultyController.text,
        'Instrucciones': _instructionsController.text,
        'VideoTutorial': _videoTutorialController.text,
      };

      final String userId = FirebaseAuth.instance.currentUser!.uid;
      final projectRef = FirebaseFirestore.instance.collection('usuarios').doc(
          userId).collection('projects').doc(widget.projectId);

      // Actualizar el documento del proyecto en "usuarios"
      projectRef.update(updatedData).then((_) {
        print(
            'Proyecto actualizado exitosamente en la colección de proyectos.');

        // Después de actualizar el proyecto, actualizamos también la información en "tutoriales"
        FirebaseFirestore.instance.collection('tutoriales')
            .doc(widget.projectId)
            .update(updatedData)
            .then((_) {
          print('Información del tutorial actualizada exitosamente.');
          Navigator.pop(context);
        }).catchError((error) {
          print('Error al actualizar la información del tutorial: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al actualizar la información del tutorial'),
            ),
          );
        });
      }).catchError((error) {
        print('Error al actualizar el proyecto: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar el proyecto'),
          ),
        );
      });
    }
  }
}
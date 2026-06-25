import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recreapp/service/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditImagePage extends StatefulWidget {
  final XFile imageFile;

  const EditImagePage({Key? key, required this.imageFile}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  late File _image;
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _materialsController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _difficultyController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();
  final TextEditingController _videoTutorialController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _image = File(widget.imageFile.path);
    _checkAuth();
  }

  void _checkAuth() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      setState(() {
        _user = user;
        _authorController.text = user.displayName ?? 'Autor Anónimo';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: FileImage(_image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              'Project Information',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            _buildTextField(
              controller: _projectNameController,
              labelText: 'Project Name',
              icon: Icons.title,
            ),
            SizedBox(height: 10.0),
            _buildTextField(
              controller: _descriptionController,
              labelText: 'Description',
              icon: Icons.description,
              maxLines: 3,
            ),
            SizedBox(height: 10.0),
            _buildTextField(
              controller: _tagsController,
              labelText: 'Tags (comma separated)',
              icon: Icons.tag,
            ),
            SizedBox(height: 10.0),
            _buildTextField(
              controller: _materialsController,
              labelText: 'Materials Needed',
              icon: Icons.build,
            ),
            SizedBox(height: 10.0),
            _buildTextField(
              controller: _categoryController,
              labelText: 'Category',
              icon: Icons.category,
            ),
            SizedBox(height: 10.0),
            _buildTextField(
              controller: _difficultyController,
              labelText: 'Difficulty Level',
              icon: Icons.assessment,
            ),
            SizedBox(height: 10.0),
            _buildTextField(
              controller: _instructionsController,
              labelText: 'Instructions',
              icon: Icons.menu_book,
              maxLines: 5,
            ),
            SizedBox(height: 10.0),
            _buildTextField(
              controller: _videoTutorialController,
              labelText: 'Video Tutorial URL',
              icon: Icons.video_library,
            ),
            SizedBox(height: 10.0),
            _buildTextField(
              controller: _authorController,
              labelText: 'Author',
              icon: Icons.person,
              enabled: false,
            ),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isLoading ? null : _saveImage,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Guardar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('Cerrar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int? maxLines,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      maxLines: maxLines ?? 1,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        return null;
      },
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _saveImage() async {
    if (!_validateFields()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    String projectName = _projectNameController.text.trim();
    String description = _descriptionController.text.trim();
    String tags = _tagsController.text.trim();
    String materials = _materialsController.text.trim();
    String category = _categoryController.text.trim();
    String difficulty = _difficultyController.text.trim();
    String instructions = _instructionsController.text.trim();
    String videoTutorial = _videoTutorialController.text.trim();
    String author = await _firebaseService.getAuthorName();

    String date = '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}';

    String imageURL = await _firebaseService.uploadImage(_image);

    await _firebaseService.saveProjectInfo(
      projectName,
      description,
      tags,
      date,
      imageURL,
      materials,
      category,
      difficulty,
      instructions,
      videoTutorial,
      author,
    );

    setState(() {
      _isLoading = false;
    });

    _showSuccessDialog();
  }

  bool _validateFields() {
    if (_projectNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('El nombre del proyecto es obligatorio'),
      ));
      return false;
    }
    return true;
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Proyecto Cargado'),
        content: Text('El proyecto se ha cargado correctamente.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    _materialsController.dispose();
    _categoryController.dispose();
    _difficultyController.dispose();
    _instructionsController.dispose();
    _videoTutorialController.dispose();
    _authorController.dispose();
    super.dispose();
  }
}

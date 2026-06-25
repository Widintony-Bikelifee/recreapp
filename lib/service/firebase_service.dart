import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getCurrentUserId() async {
    final User? user = _auth.currentUser;
    return user?.uid ?? '';
  }

  Future<String> getAuthorName() async {
    try {
      final String uid = await getCurrentUserId();
      DocumentSnapshot userSnapshot = await _firestore.collection('usuarios').doc(uid).get();
      if (userSnapshot.exists) {
        return '${userSnapshot['nombre']} ${userSnapshot['apellido']}' ?? '';
      } else {
        return 'Nombre de usuario';
      }
    } catch (e) {
      print('Error al obtener el autor: $e');
      return 'Nombre de usuario';
    }
  }

  Future<String> uploadImage(File imageFile) async {
    try {
      Reference ref = _storage.ref().child('images_tutoriales/${DateTime.now().toString()}');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

      String imageURL = await snapshot.ref.getDownloadURL();
      return imageURL;
    } catch (e) {
      print('Error al subir la imagen: $e');
      return '';
    }
  }

  Future<void> saveProjectInfo(
      String projectName,
      String description,
      String tags,
      String date,
      String imageURL,
      String materials,
      String category,
      String difficulty,
      String instructions,
      String videoTutorial,
      String author,
      ) async {
    final String uid = await getCurrentUserId();

    DocumentReference globalRef = await _firestore.collection('usuarios').doc(uid).collection('projects').add({
      'Titulo': projectName,
      'Descripcion': description,
      'Etiquetas': tags,
      'Fecha': date,
      'ImagenUrl': imageURL,
      'Materiales': materials,
      'Categoria': category,
      'Dificultad': difficulty,
      'Instrucciones': instructions,
      'VideoTutorial': videoTutorial,
      'Autor': author,
    });
  }

  Future<void> deleteUserProject(String userId, String projectId) async {
    await FirebaseFirestore.instance.collection('tutoriales').doc(projectId).delete();
    // Eliminar el proyecto de la subcolección del usuario
    await FirebaseFirestore.instance.collection('usuarios').doc(userId).collection('projects').doc(projectId).delete();
  }

  Future<void> shareProjectGlobally(String projectId, Map<String, dynamic> project) async {
    try {
      await _firestore.collection('tutoriales').doc(projectId).set(project);
      print('Proyecto compartido globalmente');
    } catch (e) {
      print('Error al compartir el proyecto: $e');
    }
  }


  Future<void> updateProject(String projectId, Map<String, dynamic> newData) async {
    final String uid = await getCurrentUserId();
    try {
      await _firestore.collection('tutoriales').doc(projectId).update(newData);
      await _firestore.collection('usuarios').doc(uid).collection('projects').doc(projectId).update(newData);
      print('Proyecto actualizado correctamente');
    } catch (e) {
      print('Error al actualizar el proyecto: $e');
    }
  }
  Future<void> saveUserProjectInfo(
      String userId,
      String projectName,
      String description,
      String tags,
      String date,
      String imageURL,
      String materials,
      String category,
      String difficulty,
      String instructions,
      String videoTutorial,
      String author,
      ) async {
    try {
      // Construir la referencia al documento del usuario en Firestore
      DocumentReference userDocRef = _firestore.collection('users').doc(userId);

      // Obtener una referencia a la subcolección de proyectos del usuario
      CollectionReference projectsCollection = userDocRef.collection('projects');

      // Guardar los datos del proyecto en la subcolección de proyectos del usuario
      await projectsCollection.add({
        'projectName': projectName,
        'description': description,
        'tags': tags,
        'date': date,
        'imageURL': imageURL,
        'materials': materials,
        'category': category,
        'difficulty': difficulty,
        'instructions': instructions,
        'videoTutorial': videoTutorial,
        'author': author,
      });
    } catch (e) {
      print('Error al guardar proyecto: $e');
      throw e;
    }
  }

  Future<void> saveTutorialInfo(
      String projectName,
      String description,
      String tags,
      String date,
      String imageURL,
      String materials,
      String category,
      String difficulty,
      String instructions,
      String videoTutorial,
      String author,
      ) async {
    // Guardar los datos del proyecto en la colección "tutorials"
    await _firestore.collection('tutorials').add({
      'projectName': projectName,
      'description': description,
      'tags': tags,
      'date': date,
      'imageURL': imageURL,
      'materials': materials,
      'category': category,
      'difficulty': difficulty,
      'instructions': instructions,
      'videoTutorial': videoTutorial,
      'author': author,
    });
  }
}

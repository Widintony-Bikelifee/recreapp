import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recreapp/constants.dart';

class RewardsPage extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  RewardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtén el usuario actualmente autenticado
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Recompensas Disponibles',
            style: TextStyle(
                color: Colors.white), // Color blanco para el texto del título
          ),
          backgroundColor: Constants.primaryColor,
        ),
        body: const Center(child: Text('Usuario no autenticado')),
      );
    }

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Recompensas Disponibles',
            style: TextStyle(
                color: Colors.white), // Color blanco para el texto del título
          ),
          backgroundColor: Constants.primaryColor,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('usuarios')
              .doc(user.uid)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!userSnapshot.hasData || userSnapshot.data == null) {
              return const Center(
                  child: Text('No se encontraron datos del usuario.'));
            }

            // Obtén los puntos acumulados del usuario
            Map<String, dynamic> userData =
            userSnapshot.data!.data() as Map<String, dynamic>;
            int userPoints = userData['total_puntos'] ?? 0;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Puntos Acumulados:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '$userPoints',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('recompensas')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> rewardSnapshot) {
                      if (rewardSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!rewardSnapshot.hasData ||
                          rewardSnapshot.data!.docs.isEmpty) {
                        return const Center(
                            child: Text('No hay recompensas disponibles.'));
                      }

                      return ListView.builder(
                        itemCount: rewardSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot reward =
                          rewardSnapshot.data!.docs[index];
                          String rewardId = reward.id;
                          String description = reward['descripcion'];
                          int pointsRequired = reward['puntos_requeridos'];

                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              leading: Image.network(
                                reward[
                                'imagen_url'], // Obtén la URL de la imagen desde la base de datos
                                width: 45, // Ancho deseado de la imagen
                                height: 45, // Alto deseado de la imagen
                              ),
                              title: Text(description),
                              subtitle:
                              Text('Puntos requeridos: $pointsRequired'),
                              trailing: FutureBuilder<DocumentSnapshot>(
                                future: FirebaseFirestore.instance
                                    .collection('usuarios')
                                    .doc(user.uid)
                                    .collection('canjeos')
                                    .doc(rewardId)
                                    .get(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  bool canjeado =
                                      snapshot.data?.exists ?? false;

                                  return ElevatedButton(
                                    onPressed: !canjeado &&
                                        userPoints >= pointsRequired
                                        ? () async {
                                      bool canjeExitoso =
                                      await _canjearRecompensa(
                                          user.uid,
                                          rewardId,
                                          userPoints,
                                          pointsRequired);

                                      if (canjeExitoso) {
                                        // Mostrar diálogo de éxito
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  '¡Felicidades!'),
                                              content: const Text(
                                                  'Canjeo exitoso'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else {
                                        // Mostrar mensaje de error si el canjeo falla
                                        _scaffoldMessengerKey.currentState
                                            ?.showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: const [
                                                Icon(Icons.error,
                                                    color: Colors.white),
                                                SizedBox(width: 8),
                                                Text(
                                                    'Canjeo fallido. Inténtalo de nuevo.')
                                              ],
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: !canjeado &&
                                          userPoints >= pointsRequired
                                          ? Constants.primaryColor
                                          : Colors.grey,
                                    ),
                                    child: Text(
                                        canjeado ? 'Canjeado' : 'Canjear',
                                        style: TextStyle(color: Colors.white)),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Método para canjear la recompensa y restar los puntos del usuario
  Future<bool> _canjearRecompensa(String userId, String rewardId,
      int currentPoints, int pointsRequired) async {
    try {
      // Iniciar una transacción en Firestore
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('usuarios').doc(userId);
        DocumentSnapshot userDocSnapshot = await transaction.get(userDocRef);

        if (!userDocSnapshot.exists) {
          throw Exception("Usuario no encontrado");
        }

        int updatedPoints =
            (userDocSnapshot.data() as Map<String, dynamic>)['total_puntos'] -
                pointsRequired;

        if (updatedPoints < 0) {
          throw Exception("Puntos insuficientes");
        }

        // Actualizar los puntos del usuario
        transaction.update(userDocRef, {'total_puntos': updatedPoints});

        // Registrar el canje en la subcolección 'canjeos'
        DocumentReference canjeoDocRef =
        userDocRef.collection('canjeos').doc(rewardId);
        transaction.set(canjeoDocRef, {
          'descripcion': rewardId,
          'fecha': FieldValue.serverTimestamp(),
        });
      });

      return true; // Canjeo exitoso
    } catch (e) {
      print('Error al canjear la recompensa: $e');
      return false; // Canjeo fallido
    }
  }
}

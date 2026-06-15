import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recreapp/constants.dart';
import 'package:recreapp/ui/screens/rewards.dart';
import 'package:recreapp/ui/screens/signin_page.dart';
import 'package:recreapp/ui/screens/widgets/my_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available');
          }

          // Obtiene los datos del documento
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          String? apellido = data['apellido'];
          String? nombre = data['nombre'];

          // Obtén el usuario actualmente autenticado
          User? user = FirebaseAuth.instance.currentUser;

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              height: size.height,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    child: CircleAvatar(
                      radius: 60,
                      // Utiliza la imagen de perfil del usuario si está disponible
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : const ExactAssetImage(''),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Constants.primaryColor.withOpacity(.5),
                        width: 5.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Muestra el nombre del usuario si está disponible
                  Text(
                    '$nombre $apellido',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  // Muestra el correo electrónico del usuario si está disponible
                  Text(
                    user?.email ?? 'Correo Electrónico',
                    style: TextStyle(
                      color: Constants.blackColor.withOpacity(.3),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: size.height * .7,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileWidget(
                          icon: Icons.person,
                          title: 'Mi perfil',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyProfilePage()),
                            );
                          },
                        ),
                        ProfileWidget(
                          icon: Icons.settings,
                          title: 'Configuraciones',
                          onTap: () {},
                        ),
                        ProfileWidget(
                          icon: Icons.card_giftcard,
                          title: 'Recompensas',
                          onTap: () {
                            // Navegar a la página de recompensas
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RewardsPage()),
                            );
                          },
                        ),
                        ProfileWidget(
                          icon: Icons.chat,
                          title: 'Preguntas frecuentes',
                          onTap: () {},
                        ),
                        ProfileWidget(
                          icon: Icons.share,
                          title: 'Compartir',
                          onTap: () {},
                        ),
                        ProfileWidget(
                          icon: Icons.logout,
                          title: 'Salir',
                          onTap: () async {
                            await FirebaseAuth.instance
                                .signOut(); // Sign out the user
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SignIn()), // Navigate to SignIn screen
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Constants.primaryColor),
            const SizedBox(width: 20),
            Text(title, style: TextStyle(fontSize: 16)),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: Constants.primaryColor),
          ],
        ),
      ),
    );
  }
}

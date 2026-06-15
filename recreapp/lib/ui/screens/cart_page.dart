import 'package:flutter/material.dart';
import 'package:recreapp/constants.dart'; // Asegúrate de importar Constants
import 'package:recreapp/ui/screens/widgets/beneficios_page.dart';
import 'package:recreapp/ui/screens/widgets/horarios_page.dart';
import 'package:recreapp/ui/screens/widgets/materiales_page.dart';
import 'package:recreapp/ui/screens/widgets/plant_widget.dart';
import 'package:recreapp/ui/screens/widgets/puntosrecoleccion_page.dart';
import 'package:recreapp/ui/screens/widgets/separacion_page.dart';

import '../../models/plants.dart';

class CartPage extends StatefulWidget {
  final List<Plant> addedToCartPlants;
  const CartPage({Key? key, required this.addedToCartPlants}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Widget optionButton({
    required String title,
    required String imagePath,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(0.1), // Ajuste del color verde claro
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: widget.addedToCartPlants.isEmpty
            ? Column(
          children: [
            // Aquí agregamos la imagen grande antes de los botones
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: size.height * 0.3, // Ajusta la altura de la imagen según sea necesario
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/biblioteca.jpg'), // Ruta de la imagen grande
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Botones como antes
            optionButton(
              title: 'Horarios de recolección',
              imagePath: 'assets/images/camion.png',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HorariosPage(),
                  ),
                );
              },
            ),
            optionButton(
              title: 'Puntos de recolección',
              imagePath: 'assets/images/puntos.png',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PuntosRecoleccionPage(),
                  ),
                );
              },
            ),
            optionButton(
              title: 'Separación de residuos',
              imagePath: 'assets/images/separacion.png',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeparacionPage(),
                  ),
                );
              },
            ),
            optionButton(
              title: 'Beneficios del reciclaje',
              imagePath: 'assets/images/beneficios.png',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BeneficiosPage(),
                  ),
                );
              },
            ),
            optionButton(
              title: 'Materiales reciclables y no reciclables',
              imagePath: 'assets/images/materiales.png',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaterialesPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 16), // Espacio en blanco después del último botón
          ],
        )
            : Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.addedToCartPlants.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return PlantWidget(
                        index: index, plantList: widget.addedToCartPlants);
                  },
                ),
              ),
              Column(
                children: [
                  const Divider(thickness: 1.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Totals',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        r'$65',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Constants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recreapp/constants.dart'; // Asegúrate de importar Constants

class PuntosRecoleccionPage extends StatelessWidget {
  const PuntosRecoleccionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puntos de Recolección'),
        backgroundColor: Constants.lightGreenColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Puntos en la ciudad de Ipiales',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Constants.primaryColor,
              ),
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/images/points.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 16),
            // Añade el contenido de los puntos de recolección aquí
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Punto 1: Alcaldía Municipal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Constants.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Dirección: Carrera 6 # 8-75',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Horario: Lunes a Viernes, 8:00 AM - 6:00 PM',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Punto 2: Centro Comercial Gran Plaza',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Constants.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Dirección: Calle 25 #23 6B',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Horario: Lunes a Miércoles, 9:00 AM - 12:00 PM',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Punto 3: Recicladores Unidos de Ipiales',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Constants.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Dirección: Cra. 4 #19-84',
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Horario: Lunes a Viernes, 8:00 AM - 12:00 PM',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

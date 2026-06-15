import 'package:flutter/material.dart';
import 'package:recreapp/constants.dart';

class SeparacionPage extends StatelessWidget {
  const SeparacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Separación de Residuos'),
        backgroundColor: Constants.lightGreenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Las 3R del Reciclaje',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Constants.primaryColor,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset('assets/images/reduce.jpg', width: 100, height: 100),
                  SizedBox(width: 16),
                  Text(
                    'Reducir',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Disminuir la cantidad de residuos que generamos es esencial para minimizar nuestro impacto ambiental. Podemos reducir comprando productos con menos embalaje, evitando el uso de plásticos de un solo uso y eligiendo productos duraderos y de buena calidad.',
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset('assets/images/reutiliza.jpg', width: 100, height: 100),
                  SizedBox(width: 16),
                  Text(
                    'Reutilizar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Reutilizar objetos antes de desecharlos es una excelente manera de prolongar su vida útil. Podemos darle una segunda vida a los objetos donándolos, reparándolos o utilizándolos para otros fines.',
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset('assets/images/recicla.jpg', width: 100, height: 100),
                  SizedBox(width: 16),
                  Text(
                    'Reciclar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'El reciclaje es el proceso de convertir los residuos en nuevos productos. Es importante separar correctamente los materiales reciclables como el papel, el vidrio, el metal y los plásticos para que puedan ser procesados y reutilizados en la fabricación de nuevos productos.',
              ),
              SizedBox(height: 16),
              Text(
                'Cómo separar los residuos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Constants.primaryColor,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset('assets/images/organic.png', width: 100, height: 100),
                  SizedBox(width: 16),
                  Text(
                    'Residuos Orgánicos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Restos de comida, cáscaras de frutas y verduras, hojas, flores y otros residuos biodegradables. Se pueden compostar para crear abono natural.',
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset('assets/images/inorganic.jpg', width: 100, height: 100),
                  SizedBox(width: 16),
                  Text(
                    'Residuos Inorgánicos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Plásticos, metales, vidrios y papeles. Estos materiales deben ser separados y reciclados adecuadamente.',
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset('assets/images/peligrosos.jpg', width: 100, height: 100),
                  SizedBox(width: 16),
                  Text(
                    'Residuos Peligrosos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Pilas, baterías, productos químicos, medicamentos y otros materiales que requieren un manejo especial debido a su potencial de daño ambiental.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

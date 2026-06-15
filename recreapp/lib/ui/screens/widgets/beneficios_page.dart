import 'package:flutter/material.dart';
import 'package:recreapp/constants.dart';

class BeneficiosPage extends StatelessWidget {
  const BeneficiosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beneficios del Reciclaje'),
        backgroundColor: Constants.lightGreenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Beneficios del Reciclaje',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Constants.primaryColor,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset('assets/images/environment.png', width: 130, height: 130),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Beneficios Ambientales',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Constants.lightGreenColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'El reciclaje ayuda a reducir la cantidad de residuos que van a los vertederos y a disminuir la contaminación del aire y el agua. También conserva los recursos naturales, como los árboles, el agua y los minerales, al permitir la reutilización de materiales.',
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset('assets/images/economy.jpg', width: 130, height: 130),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Beneficios Económicos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Constants.lightGreenColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'El reciclaje puede generar ingresos y ahorrar dinero al reducir los costos de gestión de residuos y al generar ventas en la creación de manualidades.',
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Image.asset('assets/images/community.jpg', width: 130, height: 130),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Beneficios Comunitarios',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Constants.lightGreenColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'El reciclaje promueve la participación comunitaria y la conciencia ambiental. Puede unir a las comunidades a través de programas y eventos de reciclaje, y educar a las personas sobre la importancia de cuidar el medio ambiente.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

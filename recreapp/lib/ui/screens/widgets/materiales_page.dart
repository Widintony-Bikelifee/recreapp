import 'dart:math'; // Importa la librería Random

import 'package:flutter/material.dart';

import '../../../constants.dart';

class MaterialesPage extends StatefulWidget {
  @override
  _MaterialesPageState createState() => _MaterialesPageState();
}

class _MaterialesPageState extends State<MaterialesPage> {
  List<String> recyclableItems = [
    'assets/images/papel.png',
    'assets/images/plastico.png',
    'assets/images/libro.png',
    'assets/images/metal.png',
  ];
  List<String> nonRecyclableItems = [
    'assets/images/comida.png',
    'assets/images/bombilla.png',
    'assets/images/encendedor.png',
    'assets/images/ceramica.png',
    'assets/images/vidrio.png',
  ];

  List<String> recyclableContainer = [];
  List<String> nonRecyclableContainer = [];

  bool showError = false;
  bool showCongratulations = false;

  void checkCompletion() {
    if (recyclableItems.isEmpty && nonRecyclableItems.isEmpty) {
      setState(() {
        showCongratulations = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Genera índices aleatorios para los materiales reciclables y no reciclables
    Random random = Random();
    recyclableItems.shuffle(random);
    nonRecyclableItems.shuffle(random);

    return Scaffold(
      appBar: AppBar(
        title: Text('Aprende jugando'),
        backgroundColor: Constants.lightGreenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Materiales reciclables y no reciclables',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Constants.lightGreenColor,
              child: Row(
                children: [
                  Expanded(
                    child: DragTarget<String>(
                      builder: (context, candidateData, rejectedData) {
                        return Column(
                          children: [
                            Image.asset(
                              'assets/images/bote_basura.png', // Imagen del bote de reciclables
                              height: 150,
                            ),
                            Text(
                              'Reciclables',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                      onAccept: (data) {
                        setState(() {
                          recyclableContainer.add(data);
                          recyclableItems.remove(data);
                          showError = false;
                        });
                        checkCompletion();
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: DragTarget<String>(
                      builder: (context, candidateData, rejectedData) {
                        return Column(
                          children: [
                            Image.asset(
                              'assets/images/no_reciclable.png', // Imagen del bote de no reciclables
                              height: 150,
                            ),
                            Text(
                              'No Reciclables',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                      onAccept: (data) {
                        setState(() {
                          nonRecyclableContainer.add(data);
                          nonRecyclableItems.remove(data);
                          showError = false;
                        });
                        checkCompletion();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: recyclableItems.length + nonRecyclableItems.length,
                itemBuilder: (context, index) {
                  String item;
                  bool isRecyclable;
                  if (index < recyclableItems.length) {
                    item = recyclableItems[index];
                    isRecyclable = true;
                  } else {
                    item = nonRecyclableItems[index - recyclableItems.length];
                    isRecyclable = false;
                  }
                  return Draggable<String>(
                    data: item,
                    feedback: MaterialItem(item: item),
                    childWhenDragging: Container(),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showError = true;
                        });
                      },
                      child: MaterialItem(
                        item: item,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (showError)
              Text(
                '¡Error! Coloca el material en el lugar correcto.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            if (showCongratulations)
              Text(
                '¡Felicitaciones! Has colocado todos los materiales correctamente.',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class MaterialItem extends StatelessWidget {
  final String item;

  const MaterialItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      item,
      height: 50,
    );
  }
}

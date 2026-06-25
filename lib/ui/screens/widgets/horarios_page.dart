
import 'package:flutter/material.dart';
import '../../../constants.dart';

class HorariosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horarios de Recolección Ipiales'),
        backgroundColor: Constants.lightGreenColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/camion_basura2.png',
                  width: 400,
                  height: 400,
                ),
              ),
              Text(
                'División por áreas:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildSectionWithTitleAndImage(
                Text('Veredas:'),
                'assets/images/veredas.png',
                [
                  'Días Martes y Jueves: 10:00am - 12:00pm',
                  '• San Juan: Loma de Suras, San Juan, Los Camellones, Laguna de Bacca, Boquerón.',
                  '• Las Lajas: El Placer, Tola de Las Lajas, Cofradía, Centro poblado.',
                  '• Yaramal: Santafé, Puente Nuevo, Puente Viejo, El Rosario, Teques, Yaramal, La Floresta, Llano Grande, El Mirador.',
                  '• La Victoria: El Salado, El Cultún, San Antonio, Villamoreno, El Telíz, El Arrayán, Villaflor, San José Alto, La Victoria, Pénjamo, San José Bajo, Esfloria, El Azuay, San Jorge, La Estrella, y el bosque no intervenido.',
                  '• Las Cruces: La Soledad, Las Cruces, Guacuán, Chaguaipe, Chiranquer, Inagán, Loma de Chacuas, El Cangal, Yanalá Centro, Yanalá Alto, El Rosal, Saguarán, El Placer, Chacuas.',
                  '• Ipiales: Yapueta, Urambud, Tusandala, Las Animas, Los Marcos, Cutuaquer Alto, Cutuaquer Bajo, Rumichaca Alto, Santa Rosa.',
                  '• Jardines de Sucumbíos: Alto del Amarradero, Argentina, Brisas del Gavilán, Brisas del Rumiyaco, El Empalme, Fronteras del Amarradero, Jardines de Sucumbíos, La Playa, Libertad, Paraíso de Sapoyaco, Ranchería, San José de los Pinos, Santa Lucía, en el pie de monte amazónico.',
                ],
              ),
              SizedBox(height: 10),
              _buildSectionWithTitleAndImage(
                Text('Corregimientos:'),
                'assets/images/corregimientos.png',
                [
                  'Días Martes y Viernes: 2:00pm - 3:00pm',
                  '• La Victoria',
                  '• Las Lajas',
                  '• San Juan',
                  '• Yaramal',
                  '• Cofanía Jardines de Sucumbíos',
                ],
              ),
              SizedBox(height: 10),
              _buildSectionWithTitleAndImage(
                Text('Barrios de la ciudad:'),
                'assets/images/barrios.png',
                [
                  'Días Lunes, Miércoles y Viernes: 8:00am - 12:00pm',
                  '• Sector 1: Puenes, Las Américas, Balcones de la Frontera, San Carlos, Urbanización La Frontera, Limedec, Puenes Obando, El Progreso, Las Américas, Paseo Real, Nuevo Horizonte, Villanueva, El Centro, Vivienda Cristiana I y II, Kennedy, Porvenir, Villa Esperanza, Los Trigales.',
                  '• Sector 2: Asvide, Villalba, San Fernando, La Castellana, Miramontes, El Manzano, Portal de los Alcázares, Villa Jardín, San Luis, Las Acacias, Valles de Alejandría, Las Margaritas, Sena, Miramar, Los Fundadores, Santa Cecilia, Rincón de Santa Cecilia, Chambú, Mistares I y II, III y IV, La Alborada, Rincón de Mistares, Plaza Mistares, Urbanización Gualcalá.',
                  '• Sector 3: San Vicente, Panán, El Marquillo, El Lago, Los Álamos, Lirios Norte, Totoral, El Obrero, La Cruz, Bellavista.',
                  '• Sector 4: San Vicente II, El Marquillo, Santa Rosa, Álamos Norte, Santa Teresa, San José, Obrero Gremial, Calle 27, Puente del Negrito, y (sector indígena aledaño).',
                  '• Sector 5: Seminario, San Rafael, García Herreros, La Esmeralda, Asociación de Vivienda de los Educadores, Los Abedules, Villa Esperanza, Urbanización Colinas del Norte.',
                  '• Sector 6: La Laguna, La Libertad, La Escala, El Gólgota, Jesús Nazareno, Pinares de Santa Ana, Champagnat, Álamos Centro, Balcones de Madelena, La Floresta, Jaime Báteman, Centenario Urb. La Paz.',
                  '• Sector 7: Primero de Mayo I y II, La Merced, Avenida Panamericana hacia el norte, Heraldo Romero, Los Chilcos, Hospital Civil, Iservi, Simón Bolívar.',
                  '• Sector 8: Alfonso López, Antonio Nariño, La Dorada, Cementerio, Villa del Carmen, Yerbabuena, Palermo, La Florida, Cruz Verde, Fátima, José Antonio Galán, Jorge Eliécer Gaitán, Ángel Felipe Sarasti, Benjamín Herrera, La Frontera (vía Rumichaca).',
                  '• Sector 9: El Charco, Sagrado Corazón de Jesús, El Tejar, Puente Viejo, La Pradera, Rumichaca.',
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWithTitleAndImage(
      Widget title, String imagePath, List<String> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              imagePath,
              width: 150, // Ajusta el ancho de la imagen aquí
              height: 150, // Ajusta la altura de la imagen aquí
            ),
            SizedBox(width: 20),
            title,
          ],
        ),
        SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content.map((item) => Text(item)).toList(),
        ),
      ],
    );
  }
}
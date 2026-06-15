class Plant {
  final int plantId;
  final int price;
  final String size;
  final double rating;
  final int humidity;
  final String temperature;
  final String category;
  final String plantName;
  final String imageURL;
  bool isFavorated;
  final String decription;
  bool isSelected;
  final String youtubeLink;

  Plant(
      {required this.plantId,
      required this.price,
      required this.category,
      required this.plantName,
      required this.size,
      required this.rating,
      required this.humidity,
      required this.temperature,
      required this.imageURL,
      required this.isFavorated,
      required this.decription,
      required this.isSelected,
      required this.youtubeLink});

  //List of Plants data
  static List<Plant> plantList = [
    Plant(
        plantId: 0,
        price: 22,
        category: 'Tejido y bordado',
        plantName: 'LLavero',
        size: 'Small',
        rating: 4.5,
        humidity: 34,
        temperature: '23 - 34',
        imageURL: 'assets/images/plant-one.png',
        isFavorated: true,
        decription:
            'Llavero compuesto por un corazón amarillo tejido a crochet, que presenta un diseño tridimensional y está cuidadosamente trabajado con hilo de algodón.',
        isSelected: false,
        youtubeLink: 'https://www.youtube.com/watch?v=CVSutjpiD44'),
    Plant(
        plantId: 1,
        price: 11,
        category: 'Utilitarias',
        plantName: 'Manilla',
        size: 'Medium',
        rating: 4.8,
        humidity: 56,
        temperature: '19 - 22',
        imageURL: 'assets/images/plant-two.png',
        isFavorated: false,
        decription:
            'Pulsera tejida a mano con hilo de color lila. La pulsera cuenta con un diseño de macramé y un charm en forma de corazón adornado con pequeñas piedras brillantes.',
        isSelected: false,
        youtubeLink: 'https://www.youtube.com/watch?v=kX7F29eL-A0'),
    Plant(
        plantId: 2,
        price: 18,
        category: 'Decorativas',
        plantName: 'Maceta',
        size: 'Large',
        rating: 4.7,
        humidity: 34,
        temperature: '22 - 25',
        imageURL: 'assets/images/plant-three.png',
        isFavorated: false,
        decription:
            'Canasta decorativa hecha con tapas de botellas de plástico recicladas. La estructura de la canasta está formada por una base y paredes de tapas de colores dispuestas en un patrón circular y compacto.',
        isSelected: false,
        youtubeLink: 'https://www.youtube.com/watch?v=mv9-FovyamY'),
    Plant(
        plantId: 3,
        price: 30,
        category: 'Outdoor',
        plantName: 'Big Bluestem',
        size: 'Small',
        rating: 4.5,
        humidity: 35,
        temperature: '23 - 28',
        imageURL: 'assets/images/plant-one.png',
        isFavorated: false,
        decription:
            'This plant is one of the best plant. It grows in most of the regions in the world and can survive even the harshest weather condition.',
        isSelected: false,
        youtubeLink: 'https://www.youtube.com/watch?v=link4'),
    Plant(
        plantId: 4,
        price: 24,
        category: 'Decorativas',
        plantName: 'Rosa encantada',
        size: 'Large',
        rating: 4.1,
        humidity: 66,
        temperature: '12 - 16',
        imageURL: 'assets/images/plant-four.png',
        isFavorated: true,
        decription:
            'Consiste en una rosa realizada con foami colocada dentro de una botella de plástico transparente. La base de la campana está decorada con encaje blanco y pequeños detalles brillantes que simulan gotas de rocío.',
        isSelected: false,
        youtubeLink: 'https://www.youtube.com/watch?v=T-5Zi2WLRog'),
    Plant(
        plantId: 5,
        price: 24,
        category: 'Outdoor',
        plantName: 'Meadow Sage',
        size: 'Medium',
        rating: 4.4,
        humidity: 36,
        temperature: '15 - 18',
        imageURL: 'assets/images/plant-five.png',
        isFavorated: false,
        decription:
            'This plant is one of the best plant. It grows in most of the regions in the world and can survive even the harshest weather condition.',
        isSelected: false,
        youtubeLink: 'https://www.youtube.com/watch?v=link6'),
    Plant(
        plantId: 6,
        price: 19,
        category: 'Garden',
        plantName: 'Plumbago',
        size: 'Small',
        rating: 4.2,
        humidity: 46,
        temperature: '23 - 26',
        imageURL: 'assets/images/plant-six.png',
        isFavorated: false,
        decription:
            'This plant is one of the best plant. It grows in most of the regions in the world and can survive even the harshest weather condition.',
        isSelected: false,
        youtubeLink: 'https://www.youtube.com/watch?v=link7'),
    Plant(
        plantId: 7,
        price: 23,
        category: 'Garden',
        plantName: 'Tritonia',
        size: 'Medium',
        rating: 4.5,
        humidity: 34,
        temperature: '21 - 24',
        imageURL: 'assets/images/plant-seven.png',
        isFavorated: false,
        decription:
            'This plant is one of the best plant. It grows in most of the regions in the world and can survive even the harshest weather condition.',
        isSelected: false,
        youtubeLink: 'https://www.youtube.com/watch?v=link8'),
    Plant(
        plantId: 8,
        price: 46,
        category: 'Recommended',
        plantName: 'Tritonia',
        size: 'Medium',
        rating: 4.7,
        humidity: 46,
        temperature: '21 - 25',
        imageURL: 'assets/images/plant-eight.png',
        isFavorated: false,
        decription:
            'This plant is one of the best plant. It grows in most of the regions in the world and can survive even the harshest weather condition.',
        isSelected: false,
        youtubeLink: 'https://www.youtube.com/watch?v=link9'),
  ];

  //Get the favorated items
  static List<Plant> getFavoritedPlants() {
    List<Plant> _travelList = Plant.plantList;
    return _travelList.where((element) => element.isFavorated == true).toList();
  }

  //Get the cart items
  static List<Plant> addedToCartPlants() {
    List<Plant> _selectedPlants = Plant.plantList;
    return _selectedPlants
        .where((element) => element.isSelected == true)
        .toList();
  }
}

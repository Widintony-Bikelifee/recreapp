import 'package:flutter/material.dart';
import 'package:recreapp/constants.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;
  final TextEditingController? controller; // Añade un controlador de texto

  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.obscureText,
    required this.hintText,
    this.controller, // Actualiza el constructor para aceptar un controlador de texto
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField( // Cambia TextField a TextFormField
      controller: controller, // Usa el controlador de texto proporcionado
      obscureText: obscureText,
      style: TextStyle(
        color: Constants.blackColor,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(icon, color: Constants.blackColor.withOpacity(.3),),
        hintText: hintText,
      ),
      cursorColor: Constants.blackColor.withOpacity(.5),
    );
  }
}
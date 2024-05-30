import 'package:firestore_ecommerce_adminpanel/tools/constants.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureValue;
  final String text;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.obscureValue,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Constants.getBoldColorStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary),
      controller: controller,
      obscureText: obscureValue,
      decoration: InputDecoration(

          filled: true,
          fillColor: Colors.white,
          hintText: text,

          hintStyle: Constants.getBoldColorStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey),
          )),
    );
  }
}

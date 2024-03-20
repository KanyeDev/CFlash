import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.userNameController,
    required this.hintText,
    required this.keyboardType,
    required this.icon,
    required this.returnText,
  }) : super(key: key);

  final TextEditingController userNameController;
  final String hintText;
  final TextInputType keyboardType;
  final Icon icon;
  final String returnText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: userNameController,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        fillColor: Colors.black,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.blueGrey),
        prefixIcon: icon,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return returnText;
        }
        return null;
      },
    );
  }
}

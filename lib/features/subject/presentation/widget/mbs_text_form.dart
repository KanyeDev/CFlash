import 'package:flutter/material.dart';


class MBSTextFormField extends StatelessWidget {
  const MBSTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.errorText,
    required this.textInputType, required this.height,
  });

  final TextEditingController controller;
  final String hintText;
  final String errorText;
  final TextInputType? textInputType;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: const Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(10)),
      height: height,
      width: MediaQuery.of(context).size.width - 40,
      child: TextFormField(
        maxLines: 10,
        keyboardType: textInputType,
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          }
          return null;
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 12)),
      ),
    );
  }
}

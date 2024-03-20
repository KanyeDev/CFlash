import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color backGroundColor;
  final Color borderColor;
  final Color textColor;
  final String text;
  final bool isLoading;
  double height;
  double width;

   CustomButton({
    Key? key,
    required this.backGroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
    required this.onTap,
    required this.isLoading,
    this.height = 40,
    this.width = 300
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: backGroundColor,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                : Text(
                    text,
                    style: TextStyle(color: textColor, fontSize: 16),
                  )),
      ),
    );
  }
}

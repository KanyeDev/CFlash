import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddNewButton extends StatelessWidget {
   const AddNewButton({
    super.key, required this.text, required this.icons,
  });

  final Icon icons;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 153,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xff2E3F7A),
        borderRadius: BorderRadius.circular(30),
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           icons,
          const Gap(10),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          )
        ],
      ),
    );
  }
}

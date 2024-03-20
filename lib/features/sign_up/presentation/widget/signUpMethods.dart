import 'package:cflash/core/utility/toast.dart';
import 'package:flutter/material.dart';

class SignUpMethods extends StatelessWidget {
  const SignUpMethods({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Utility().toastMessage("Coming Soon!");
      },
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceEvenly,
        children: const [
          SizedBox(
              height: 40,
              width: 40,
              child: Image(
                  image: AssetImage(
                      'asset/images/google.png'))),
          SizedBox(
              height: 50,
              width: 50,
              child: Image(
                  image: AssetImage(
                      'asset/images/microsoft.png'))),
          SizedBox(
              height: 50,
              width: 50,
              child: Image(
                  image: AssetImage(
                      'asset/images/facebook.png'))),
        ],
      ),
    );
  }
}

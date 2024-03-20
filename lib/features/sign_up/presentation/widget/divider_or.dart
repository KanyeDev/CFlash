import 'package:flutter/material.dart';


class DividerOr extends StatelessWidget {
  const DividerOr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 18.0),
      child: Row(children: const <Widget>[
        Expanded(
            child: Divider(
              color: Colors.blueGrey,
              thickness: 1,
            )),
        SizedBox(
          width: 10,
        ),
        Text("or"),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: Divider(
              color: Colors.blueGrey,
              thickness: 1,
            )),
      ]),
    );
  }
}

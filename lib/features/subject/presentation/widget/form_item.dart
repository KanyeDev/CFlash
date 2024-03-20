import 'package:flutter/material.dart';

Padding formItemName(String name) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5),
    child: Text(
      name,
      textAlign: TextAlign.left,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}
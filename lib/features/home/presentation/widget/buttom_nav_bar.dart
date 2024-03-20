import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
    const BottomNavBar({super.key,required this.visit, required this.onTap, required this.items});


  final int visit;
  final VoidCallback? Function(int value) onTap;
  final List<TabItem<dynamic>> items;




  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffD9D9D9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset:
            const Offset(0.8, 2), // changes position of shadow
          ),
        ],
      ),
    child: BottomBarFloating(
    items: items,
    backgroundColor: const Color(0xffF8F8F8),
    color: Colors.black,
    colorSelected: const Color(0xff2E3F7A),
    indexSelected: visit,
    paddingVertical: 15,
    onTap: onTap),
    );
  }
}

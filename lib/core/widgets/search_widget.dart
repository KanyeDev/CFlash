
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.searchController, required this.hintText, required this.onChanged,
  });

  final TextEditingController searchController;
  final String hintText;
  final void Function(String)? onChanged;

@override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width - 20,
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: const Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child:  TextField(
              controller: searchController,
              decoration:  InputDecoration(
                  hintText: hintText,
                  hintStyle:
                  const TextStyle(color: Colors.grey, fontSize: 15),
                  border: InputBorder.none,
                  icon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  )),
            onChanged: onChanged,),
        ));
  }
}
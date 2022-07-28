import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class DeliverySearchBar extends StatefulWidget {
  Function(String)? filterList;
  DeliverySearchBar({Key? key, required this.filterList}) : super(key: key);

  @override
  State<DeliverySearchBar> createState() => _DeliverySearchBarState();
}

class _DeliverySearchBarState extends State<DeliverySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10, left: 40.0, right: 40.0, bottom: 10),
      child: TextField(
        onChanged: (value) {
          widget.filterList!(value);
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff0E1420),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            hintText: "eg: Name, Order ID, or Phone number",
            hintStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            prefixIconColor: Colors.white),
      ),
    );
  }
}

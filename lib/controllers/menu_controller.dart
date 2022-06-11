// ignore_for_file: no_duplicate_case_values

import 'package:deliveryportal/constants/style.dart';
import 'package:deliveryportal/routes/route.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = homePageRoute.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHovering(String itemName) => hoverItem.value == itemName;

  // setup the icons for each of the menu items
  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case homePageRoute:
        return customIcon(Icons.trending_up, itemName);
      case driversPageRoute:
        return customIcon(Icons.drive_eta, itemName);
      case clientPageRoute:
        return customIcon(Icons.people_alt_outlined, itemName);
      case authenticationPageRoute:
        return customIcon(Icons.exit_to_app, itemName);
      case deliveryPageRoute:
        return customIcon(Icons.delivery_dining, itemName);
      default:
        return customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 12, color: dark);

    return Icon(icon, color: isHovering(itemName) ? dark : lightGrey);
  }
}

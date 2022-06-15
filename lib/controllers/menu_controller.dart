// ignore_for_file: no_duplicate_case_values

import 'package:deliveryportal/constants/style.dart';
import 'package:deliveryportal/routes/route.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem = homePageDisplayName.obs;
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
      case homePageDisplayName:
        return customIcon(Icons.trending_up, itemName);
      case driversPageDisplayName:
        return customIcon(Icons.drive_eta, itemName);
      case clientPageDisplayName:
        return customIcon(Icons.people_alt_outlined, itemName);
      case authenticationPageDisplayName:
        return customIcon(Icons.exit_to_app, itemName);
      case deliveryPageDisplayName:
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

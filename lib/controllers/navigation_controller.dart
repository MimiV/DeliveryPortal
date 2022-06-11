import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Local navigation
/*
  this is for when we select a option it doenst refresh the entire page,
  it just refresh the side part/page
 */
class NavigationController extends GetxController {
  static NavigationController instance = Get.find();
  // key to know which screen to change to, this will hold which navigator
  // we coming from
  final GlobalKey<NavigatorState> navigationKey = GlobalKey();

  // changing screen
  Future<dynamic> navigateTo(String routeName) {
    return navigationKey.currentState!.pushNamed(routeName); // next page
  }

  goBack() => navigationKey.currentState!.pop(); // last page
}

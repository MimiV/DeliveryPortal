import 'package:deliveryportal/routes/route.dart';
import 'package:deliveryportal/views/clients/client.dart';
import 'package:deliveryportal/views/deliveries/delivery.dart';
import 'package:deliveryportal/views/drivers/driver.dart';
import 'package:deliveryportal/views/home/home.dart';
import 'package:deliveryportal/views/settings/settings.dart';
import 'package:flutter/material.dart';

// takes routes setting and return a page route
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return _getPageRoute(const HomePage());
    case driversPageRoute:
      return _getPageRoute(const DriversPage());
    case clientPageRoute:
      return _getPageRoute(const ClientsPage());
    case deliveryPageRoute:
      return _getPageRoute(const DeliveryPage());
    case settingsPageRoute:
      return _getPageRoute(const SettingsPage());
    default:
      return _getPageRoute(const HomePage());
  }
}

// return the page route
PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

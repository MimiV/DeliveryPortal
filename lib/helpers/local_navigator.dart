import 'package:deliveryportal/constants/controllers.dart';
import 'package:deliveryportal/routes/route.dart';
import 'package:deliveryportal/routes/router.dart';
import 'package:flutter/widgets.dart';

// * navigator for the route for large side screen
Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: homePageRoute,
      onGenerateRoute: generateRoute, // on generate route
    );

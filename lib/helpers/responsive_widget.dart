import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// Screen sizes
const int large = 1366;
const int small = 360;
const int medium = 768;
const int custom = 1100;

class ResponsiveWidget extends StatelessWidget {
  final Widget largeView;
  final Widget? mediumView;
  final Widget? smallView;
  final Widget? customView;

  // constructor
  const ResponsiveWidget(
      {Key? key,
      required this.largeView,
      this.mediumView,
      this.smallView,
      this.customView})
      : super(key: key);

  // static methods to check the view size

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= large;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= medium &&
      MediaQuery.of(context).size.width < large;

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < medium;

  static bool isCustomScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= medium &&
      MediaQuery.of(context).size.width <= custom;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      // takes the sizes and return the size of the screen
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        if (width >= large) {
          return largeView;
        } else if (width < large && width >= medium) {
          return mediumView ?? largeView;
        } else {
          return smallView ?? largeView;
        }
      },
    );
  }
}

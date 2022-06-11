import 'package:deliveryportal/helpers/responsive_widget.dart';
import 'package:deliveryportal/widgets/large_window.dart';
import 'package:deliveryportal/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/side_menu.dart';
import 'widgets/small_window.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class SiteLayout extends StatelessWidget {
  // const SiteLayout({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: const ResponsiveWidget(
          // changes the screen on size changes
          largeView: LargeWindow(),
          smallView: SmallWindow()),
    );
  }
}

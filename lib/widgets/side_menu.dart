import 'package:deliveryportal/constants/controllers.dart';
import 'package:deliveryportal/constants/style.dart';
import 'package:deliveryportal/views/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/responsive_widget.dart';
import '../routes/route.dart';
import '../views/authentication/auth.dart';
import 'custom_text.dart';
import 'side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "Dash",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
              ],
            ),
          const SizedBox(
            height: 30,
          ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: ResponsiveWidget.isSmallScreen(context)
                  ? driverMenuItems
                      .map((item) => SideMenuItem(
                          itemName: item.name,
                          onTap: () {
                            if (item.route == authenticationPageRoute) {
                              signOutGoogle();
                              menuController
                                  .changeActiveItemTo(homePageDisplayName);
                              Get.offAllNamed(authenticationPageRoute);
                            }

                            if (!menuController.isActive(item.name)) {
                              menuController.changeActiveItemTo(item.name);
                              if (ResponsiveWidget.isSmallScreen(context)) {
                                Get.back();
                              }
                              navigationController.navigateTo(item.route);
                            }
                          }))
                      .toList()
                  : sideMenuItems
                      .map((item) => SideMenuItem(
                          itemName: item.name,
                          onTap: () {
                            if (item.route == authenticationPageRoute) {
                              // Get.offAll(() => AuthenticationPage());
                              signOutGoogle();
                              menuController
                                  .changeActiveItemTo(homePageDisplayName);
                              Get.offAllNamed(authenticationPageRoute);
                            } else {
                              if (!menuController.isActive(item.name)) {
                                menuController.changeActiveItemTo(item.name);
                                if (ResponsiveWidget.isSmallScreen(context)) {
                                  Get.back();
                                }
                                navigationController.navigateTo(item.route);
                              }
                            }
                          }))
                      .toList())
        ],
      ),
    );
  }
}

import 'package:deliveryportal/helpers/responsive_widget.dart';
import 'package:deliveryportal/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import '../constants/style.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      // if screen is small show the drawer icon, otherwise show the logo
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 14),
                  child: Image.asset("assets/icons/logo.png", width: 20),
                )
              ],
            )
          : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                key.currentState?.openDrawer();
              },
            ),
      elevation: 0,
      title: Row(children: [
        Visibility(
            child: CustomText(
          text: "Dash",
          color: lightGrey,
          size: 20,
          weight: FontWeight.bold,
        )),
        Expanded(child: Container()),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: dark.withOpacity(.7),
          ),
          onPressed: () {},
        ),
        Stack(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications, color: dark.withOpacity(.7))),
            Positioned(
              top: 7,
              right: 7,
              child: Container(
                width: 12,
                height: 12,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: active,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: light, width: 2)),
              ),
            )
          ],
        ),
        Container(width: 1, height: 22, color: lightGrey),
        const SizedBox(
          width: 24,
        ),
        CustomText(
          text: "Mike Test",
          color: lightGrey,
        ),
        const SizedBox(
          width: 16,
        ),
        Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: CircleAvatar(
                    backgroundColor: light,
                    child: Icon(Icons.person_outline, color: dark))))
      ]),
      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.transparent,
      //backgroundColor: Colors.red,
    );

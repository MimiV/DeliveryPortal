import 'package:deliveryportal/controllers/home_controller.dart';
import 'package:deliveryportal/helpers/responsive_widget.dart';
import 'package:deliveryportal/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/style.dart';
import '../controllers/delivery_controller.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
  AppBar(
    shape: ResponsiveWidget.isSmallScreen(context) ? Border(bottom: BorderSide(color: active, width: 2)) : Border(bottom: BorderSide(color: Colors.transparent, width: 2)),
      // if screen is small show the drawer icon, otherwise show the logo
    leading: !ResponsiveWidget.isSmallScreen(context) ? // if small screen
      Row(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 25),
            child: Image.asset("assets/icons/logo.png", width: 30, height: 30,),
          )
        ],
      )
      : //else
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          key.currentState?.openDrawer();
        },
      ),
    elevation: 0,
    title: Row(
      children: [
        Visibility(
          child: CustomText(
            text: "DashPortal",
            color: active,
            size: 20,
            weight: FontWeight.bold,
          )
        ),
        SizedBox(
          width: 30.5,
        ),
        Expanded(
          child: Container(
            )
        ),
        
        IconButton(
          icon: Icon(
            Icons.settings,
            color: light.withOpacity(.7),
          ),
          onPressed: () {
            Provider.of<HomeController>(context, listen: false).test();
          },
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: light.withOpacity(.7))
            ),
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
                  border: Border.all(color: light, width: 2)
                ),
              ),
            )
          ], // end children
        ),
        Container(
          width: 1, 
          height: 22, 
          color: lightGrey
        ),

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
            color: Colors.white, 
            borderRadius: BorderRadius.circular(30)
          ),
          
          child: Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(2),
            child: CircleAvatar(
              maxRadius: 15.0,
              backgroundColor: light,
              child: Icon(Icons.person_outline, color: dark)
            )
          )
        )
      ]
    ),
    iconTheme: IconThemeData( color: light ),
    backgroundColor: const Color(0xff0E1420),
      //backgroundColor: Colors.red,
  );

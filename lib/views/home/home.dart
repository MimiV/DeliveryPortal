import 'package:deliveryportal/constants/controllers.dart';
import 'package:deliveryportal/helpers/responsive_widget.dart';
import 'package:deliveryportal/views/home/widgets/available_drivers_table.dart';
import 'package:deliveryportal/views/home/widgets/home_cards_large.dart';
import 'package:deliveryportal/views/home/widgets/home_cards_medium.dart';
import 'package:deliveryportal/views/home/widgets/home_cards_small.dart';
import 'package:deliveryportal/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../notifications/listTest.dart';
import '../notifications/notifications.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Obx(() => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          )),
      Expanded(
          child: ListView(
            shrinkWrap: true,
        children: [
          if (ResponsiveWidget.isLargeScreen(context) ||
              ResponsiveWidget.isMediumScreen(context))
            if (ResponsiveWidget.isCustomScreen(context))
              const HomeCardsMediumScreen()
            else
              const Padding(
                padding: EdgeInsets.all(20.0),
                child:  HomeCardsLargeScreen(),
              )
          else
            const Padding(
              padding: EdgeInsets.all(20.0),
              child:  HomeCardsSmallScreen(),
            ),
          // if (!ResponsiveWidget.isSmallScreen(context))
          //   RevenueSectionLarge()
          // else
          //   RevenueSectionSmall(),
          //Notifications(),
          //ListTest(),
          Notifications()
          //const AvailableDriversTable(),
        ],
      ))
    ]);
  }
}

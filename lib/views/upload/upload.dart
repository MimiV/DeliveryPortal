import 'package:deliveryportal/constants/controllers.dart';
import 'package:deliveryportal/helpers/responsive_widget.dart';
import 'package:deliveryportal/views/home/widgets/available_drivers_table.dart';
import 'package:deliveryportal/views/home/widgets/home_cards_large.dart';
import 'package:deliveryportal/views/home/widgets/home_cards_medium.dart';
import 'package:deliveryportal/views/home/widgets/home_cards_small.dart';
import 'package:deliveryportal/views/upload/upload_page.dart';
import 'package:deliveryportal/views/upload/upload_page2.dart';
import 'package:deliveryportal/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../notifications/listTest.dart';
import '../notifications/notifications.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

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
          DeliveriesUploadPage()
        ],
      ))
    ]);
  }
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../helpers/responsive_widget.dart';
import '../../widgets/custom_text.dart';
import 'widgets/clients_table.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    height: 100,
                    //width: 400,
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: [
              //Clientstable(),
            ],
          ),
          // Expanded(
          //     child: ListView(
          //   shrinkWrap: true,
          //   children: [
          //     Clientstable(),
          //   ],
          // )
          // ),
        ],
      ),
    );
  }
}

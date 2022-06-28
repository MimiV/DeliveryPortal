import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'info_card_small.dart';

class HomeCardsSmallScreen extends StatelessWidget {
  int totalDeliveries = 0;
  int packageDelivered = 0;
  HomeCardsSmallScreen({Key? key, required this.totalDeliveries, required this.packageDelivered}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    //var plat = Theme.of(context).platform;
    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title:  "Total Deliveries",
            value: totalDeliveries.toString(),
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Package Delivered",
            value: packageDelivered.toString(),
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Remaining Deliveries",
            value: (totalDeliveries - packageDelivered).toString(),
            onTap: () {},
          ),
          // SizedBox(
          //   height: _width / 64,
          // ),
          // InfoCardSmall(
          //   title: "Scheduled deliveries",
          //   value: "32",
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}

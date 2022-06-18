import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'info_card_small.dart';

class HomeCardsSmallScreen extends StatelessWidget {
  const HomeCardsSmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    var plat = Theme.of(context).platform;
    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: TargetPlatform.android == plat  ? "ANDROID" : "Total Deliveries",
            value: "7",
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: TargetPlatform.android.toString(),
            value: "17",
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Cancelled delivery",
            value: "3",
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Scheduled deliveries",
            value: "32",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

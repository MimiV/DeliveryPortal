import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import '../../../services/database.dart';
import 'info_card.dart';

class HomeCardsLargeScreen extends StatelessWidget {
  int totalDeliveries = 0;
  int packageDelivered = 0;
  HomeCardsLargeScreen({Key? key, required this.totalDeliveries, required this.packageDelivered}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width; // screen size
    //var plat = Theme.of(context).platform;
    return Row(
      children: [
        InfoCard(
          title: "Total Deliveries",
          value: totalDeliveries.toString(),
          topColor: Colors.orange,
          onTap: () {
            //getData();
            getDrivers();
          },
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Packages Delivered",
          value: packageDelivered.toString(),
          topColor: Colors.green,
          onTap: () {

          },
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Remaining Deliveries",
          value: (totalDeliveries - packageDelivered).toString(),
          topColor: Colors.purple,
          onTap: () {},
        ),
      ],
    );
  }
}

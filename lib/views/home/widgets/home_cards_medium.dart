import 'package:flutter/material.dart';
import 'info_card.dart';

class HomeCardsMediumScreen extends StatelessWidget {
  int totalDeliveries = 0;
  int packageDelivered = 0;
  HomeCardsMediumScreen({Key? key, required this.totalDeliveries, required this.packageDelivered}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title:  "Total Deliveries",
              value: totalDeliveries.toString(),
              onTap: () {},
              topColor: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Packages delivered",
              value: packageDelivered.toString(),
              topColor: Colors.lightGreen,
              onTap: () {},
            ),
          ],
        ),
        SizedBox(
          height: _width / 64,
        ),
        Row(
          children: [
            InfoCard(
              title: "Remaining delivery",
              value: (totalDeliveries - packageDelivered).toString(),
              topColor: Colors.purple,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

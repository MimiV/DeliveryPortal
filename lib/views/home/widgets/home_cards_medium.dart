import 'package:flutter/material.dart';
import 'info_card.dart';

class HomeCardsMediumScreen extends StatelessWidget {
  const HomeCardsMediumScreen({Key? key}) : super(key: key);
// TargetPlatform.android == plat  ? "ANDROID" :
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    var plat = Theme.of(context).platform;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title:  "Total Deliveries",
              value: "7",
              onTap: () {},
              topColor: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Packages delivered",
              value: "17",
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
              value: "3",
              topColor: Colors.purple,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

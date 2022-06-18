import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math';
import '../../../services/database.dart';
import 'info_card.dart';

class HomeCardsLargeScreen extends StatelessWidget {
  const HomeCardsLargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width; // screen size
    var plat = Theme.of(context).platform;
    return Row(
      children: [
        InfoCard(
          title: TargetPlatform.android == plat  ? "ANDROID" : "Total Deliveries",
          value: "7",
          onTap: () {
            // var testdata = {
            //   "name": "Michael Vasconcelos",
            //   "TotalDeliveries": 10,
            //   "completed": 2
            // };
            //var id = sendTestData(testdata);
            //sendData(testdata);
            //var r = createData(testdata);
            //sendData();            
            generateDrivers();

            //print("response --^^");
            //print(r);
            //print(id);
          },
          topColor: Colors.orange,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Packages delivered",
          value: "17",
          topColor: Colors.lightGreen,
          onTap: () {
            //getData();
            getDrivers();
          },
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Cancelled delivery",
          value: "3",
          topColor: Colors.redAccent,
          onTap: () {

          },
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Scheduled deliveries",
          value: "32",
          onTap: () {},
        ),
      ],
    );
  }
}

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
        // InfoCard(
        //   title: TargetPlatform.android == plat  ? "ANDROID" : "Total Deliveries",
        //   value: "7",
        //   onTap: () {
        //     // var testdata = {
        //     //   "name": "Michael Vasconcelos",
        //     //   "TotalDeliveries": 10,
        //     //   "completed": 2
        //     // };
        //     //var id = sendTestData(testdata);
        //     //sendData(testdata);
        //     //var r = createData(testdata);
        //     //sendData();            
        //     generateDrivers();

        //     //print("response --^^");
        //     //print(r);
        //     //print(id);
        //   },
        //   topColor: Colors.orange,
        // ),
        // SizedBox(
        //   width: _width / 64,
        // ),
        InfoCard(
          title: "Total Deliveries",
          value: "17",
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
          value: "3",
          topColor: Colors.green,
          onTap: () {

          },
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Remaining Deliveries",
          value: "32",
          topColor: Colors.purple,
          onTap: () {},
        ),
      ],
    );
  }
}

import 'package:deliveryportal/views/drivers/driver.dart';
import 'package:deliveryportal/views/drivers/widgets/drivers_table.dart';
import 'package:flutter/material.dart';

class testWidget extends StatefulWidget {
  testWidget({Key? key}) : super(key: key);

  @override
  State<testWidget> createState() => _testWidgetState();
}

class _testWidgetState extends State<testWidget> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height:  _height / 1.5,
      width:  _width / 1,
      //constraints: BoxConstraints(minWidth: 0, maxHeight:800, maxWidth: 800),
      //padding: EdgeInsets.all(0),
      child: Column(
        children: [
        //   Flexible(
        // child: Form(
        //       child: TextField(
        //       decoration: InputDecoration(hintText: "test" ),
        //       )
        //     )
        // ),
         Flexible (
          child: DriversTable()
          ),
          


        ],
      )
      
      
      
    );
  }
}
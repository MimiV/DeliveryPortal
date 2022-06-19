import 'package:data_table_2/data_table_2.dart';
import 'package:deliveryportal/views/clients/client.dart';
import 'package:deliveryportal/views/notifications/testdialog.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import '../../models/drivers_mode.dart';
// import '../drivers/driver.dart';
// import '../drivers/widgets/drivers_table.dart';

/// * example of stateful widget changing its value when edit is pressed
class Notifications extends StatefulWidget {
  //int test_count = 0;
  Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  int test_count = 0;

  addCount() {
    setState(() => test_count += 1);

    //print(test_count);
  }

  static List<Drivers> current_drivers = [
    Drivers("michael vasconcelos", 10, 3),
    Drivers("Bebe", 7, 2),
    Drivers("Luna", 8, 4),
    Drivers("Iva", 9, 1),
    Drivers("Michelle", 10, 0),
  ];

  // list to be displayed and filtered
  List<Drivers> display_list = List.from(current_drivers);

  void updateList(String value) {
    setState(() {
      display_list = current_drivers
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ATTENTION"),
          content: const Text("You chose the best place!!"),
          actions: [
            TextButton(
              child: const Text("I see,I agree"),
              onPressed: () => {},
            )
          ],
        );
      },
    );
  }

  showAlertDialog2() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("ATTENTION"),

          // content: Form(
          //   child: TextField(
          //       decoration: InputDecoration(
          //           labelText: "Test form",
          //           hintText: "whole testing",
          //           border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(20)))),
          // ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [testWidget()],
          ),
          actions: [
            TextButton(
              child: const Text("I see,I agree"),
              onPressed: () => {},
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(20),
      ),
     // padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16 ),
      margin: const EdgeInsets.only(top:30,bottom: 30,left: 15, right: 15),
      // width: 100,
      // height: 100,
      child:
       Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Row(
            children: [
              // const SizedBox(
              //   width: 10,
              // ),
              Padding(
                padding: const EdgeInsets.only(top:10, left: 40.0, right: 40.0),
                child: CustomText(
                  text: "Available Drivers",
                  color: lightGrey,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top:10, left: 40.0, right: 40.0, bottom: 10),
            child: TextField(
              onChanged: (value) => updateList(value),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xff0E1420),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none),
                  hintText: "eg: Driver Name",
                  hintStyle: TextStyle(fontSize: 15.0, color: Colors.white),
                  prefixIcon: const Icon(Icons.search, color: Colors.white,),
                  prefixIconColor: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10.0, right:40.0,left:40.0, bottom:10.0),
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                //minWidth: 300,
                columns: const [
                  DataColumn2(
                    label: Text("Name"),
                    size: ColumnSize.S,
                   // fixedWidth: 100.0,
                  ),
                  DataColumn2(
                    label: Text('Total Deliveries'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Completed'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Action'),
                    //size: ColumnSize.S,
                    fixedWidth: 150
                  ),
                ],
                rows: List<DataRow>.generate(
                  display_list.length,
                  (index) => DataRow(cells: [
                    DataCell(CustomText(text: display_list[index].name!)),
                    DataCell(CustomText(
                        text: '${display_list[index].today_deliveries}')),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Icon(
                        //   Icons.star,
                        //   color: Colors.deepOrange,
                        //   size: 18,
                        // ),
                        // SizedBox(
                        //   width: 5,
                        // ),
                        CustomText(
                          text: '${current_drivers[index].completed}',
                        )
                      ],
                    )),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => addCount(),
                            hoverColor: Colors.amber,
                            icon: Icon(
                              Icons.countertops,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 1,
                            color: Colors.white,
                          ),
                          IconButton(
                            onPressed: () => showAlertDialog2(),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 15,
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 1,
                            color: Colors.white,
                          ),
                          Flexible(
                              child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Colors.deepOrange,
                              size: 15,
                            ),
                          ))
                          // InkWell(
                          //     onTap: () => addCount(),
                          //     child: Container(
                          //         // decoration: BoxDecoration(
                          //         //   color: light,
                          //         //   borderRadius: BorderRadius.circular(20),
                          //         //   border: Border.all(color: active, width: .5),
                          //         // ),
                          //         // padding: const EdgeInsets.symmetric(
                          //         //     horizontal: 12, vertical: 6),
                          //         child: CustomText(
                          //       text: "Edit Deliveries",
                          //       color: active.withOpacity(.7),
                          //       weight: FontWeight.bold,
                          //     ))),
                          // InkWell(
                          //     onTap: () {
                          //       showAlertDialog2();
                          //       //setState(() {});
                          //     },
                          //     child: Container(
                          //         child: CustomText(
                          //       text: "Test Deliveries",
                          //       color: active.withOpacity(.7),
                          //       weight: FontWeight.bold,
                          //     )))
                        ],
                      ),
                      // InkWell(
                      //     onTap: () => test(),
                      //     child: Container(
                      //         decoration: BoxDecoration(
                      //           color: light,
                      //           borderRadius: BorderRadius.circular(20),
                      //           border:
                      //               Border.all(color: active, width: .5),
                      //         ),
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 12, vertical: 6),
                      //         child: CustomText(
                      //           text: "Edit Deliveries",
                      //           color: active.withOpacity(.7),
                      //           weight: FontWeight.bold,
                      //         ))),
                    )
                  ]),
                )),
          ),
        ],
      ),
    );
  }
}

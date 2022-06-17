import 'package:data_table_2/data_table_2.dart';
import 'package:deliveryportal/views/clients/client.dart';
import 'package:deliveryportal/views/notifications/testdialog.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import '../drivers/driver.dart';
import '../drivers/widgets/drivers_table.dart';

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
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: lightGrey.withOpacity(.1),
              blurRadius: 12)
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CustomText(
                text: "Available Drivers",
                color: lightGrey,
                weight: FontWeight.bold,
              ),
            ],
          ),
          DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 600,
              columns: const [
                DataColumn2(
                  label: Text("Name"),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('Total Deliveries'),
                ),
                DataColumn(
                  label: Text('Completed'),
                ),
                DataColumn(
                  label: Text('Action'),
                ),
              ],
              rows: List<DataRow>.generate(
                7,
                (index) => DataRow(cells: [
                  const DataCell(CustomText(text: "Test driver")),
                  DataCell(CustomText(text: "$test_count")),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      // Icon(
                      //   Icons.star,
                      //   color: Colors.deepOrange,
                      //   size: 18,
                      // ),
                      // SizedBox(
                      //   width: 5,
                      // ),
                      CustomText(
                        text: "4",
                      )
                    ],
                  )),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => addCount(),
                          hoverColor: Colors.amber,
                          icon:Icon(Icons.countertops ,color: Colors.blue,size: 20,),
                        ),
                        Container(
                          width: 20,
                          height: 1,
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () => showAlertDialog2(),
                            icon:Icon(Icons.edit,color: Colors.black,size: 15,),

                        ),
                        Container(
                          width: 20,
                          height: 1,
                          color: Colors.white,
                        ),
                        Flexible(child: IconButton(
                          onPressed: () {},
                          icon:Icon(Icons.star,color: Colors.deepOrange,size: 15,),

                        )
                        
                        )
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
        ],
      ),
    );
  }
}

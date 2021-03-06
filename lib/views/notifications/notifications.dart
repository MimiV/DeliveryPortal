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

  static List<DriversModel> current_drivers = [
    DriversModel("0","michael vasconcelos", "email@email.com","232423232",10, 3),
    DriversModel("1","Bebe", "email@email.com","2224242323", 7, 2),
    DriversModel("2","Luna", "email@email.com","232323233", 8, 4),
    DriversModel("3","Iva", "email@email.com","423232423", 9, 1),
    DriversModel("4","Michelle", "email@email.com","3242424232", 10, 0),
  ];

  // list to be displayed and filtered
  List<DriversModel> display_list = List.from(current_drivers);

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
      margin: const EdgeInsets.only(top:30,bottom: 30,left: 15, right: 15),
      child:
       Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Row(
            children: [
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
               // minWidth: 300,
                columns: const [
                  DataColumn2(
                    label: Text("Name"), // name, total deliveries, completed, action
                    size: ColumnSize.S,
                    //fixedWidth: 100.0,
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
                    size: ColumnSize.S,
                    //fixedWidth: 150
                  ),
                ],
                rows: List<DataRow>.generate(
                  display_list.length,
                  (index) => DataRow(cells: [
                    DataCell(CustomText(text: display_list[index].name!)),
                    DataCell(
                      CustomText(
                        text: '${display_list[index].deliveries_assigned}',
                      )
                    ),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: '${current_drivers[index].deliveries_completed}',
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
                        ],
                      ),
                    )
                  ]),
                )),
          ),
          
        ],
      ),
    );
  }
}

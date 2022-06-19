import 'dart:typed_data';

import 'package:data_table_2/data_table_2.dart';
import 'package:deliveryportal/controllers/navigation_controller.dart';
import 'package:deliveryportal/views/clients/client.dart';
import 'package:deliveryportal/views/notifications/testdialog.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import '../../models/delivery_model.dart';
import '../../models/drivers_mode.dart';
// import '../drivers/driver.dart';
// import '../drivers/widgets/drivers_table.dart';

/// * example of stateful widget changing its value when edit is pressed
class DeliveriesUploadPage extends StatefulWidget {
  //int test_count = 0;
  DeliveriesUploadPage({Key? key}) : super(key: key);

  @override
  State<DeliveriesUploadPage> createState() => _DeliveriesUploadPage();
}

class _DeliveriesUploadPage extends State<DeliveriesUploadPage> with SingleTickerProviderStateMixin {
  
  static List<DeliveryModel> deliveries = [];
  bool ShowProgress = true;
  bool showTable = false;
  late AnimationController loadingController;
  DateTime selectedDate = DateTime.now();
  List<DeliveryModel> display_list = List.from(deliveries);

  // @override
  // void initState() {
  //   loadingController = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 1),
  //   )..addListener(() {
  //       setState(() {
  //         showTable= true;
  //       });
  //     });

  //   super.initState();
  // }

  Future<void> getFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      Uint8List? file = result.files.first.bytes;
      String fileName = result.files.first.name;
      //print(fileName);
      //print(file);

      var test = file!.toList();
      //var file2 = result.files.first.path!;
      //var bytes = File(file).readAsBytesSync();
      var excel = Excel.decodeBytes(test);

      for (var table in excel.tables.keys) {
        //print(table); //sheet Name
        //print(excel.tables[table]!.maxCols);
        //print(excel.tables[table]!.maxRows);
        for (var row in excel.tables[table]!.rows) {
          //print("$row");
          //print(row[1]!.value);
          deliveries.add(DeliveryModel( deliveries.length + 1,
              '${row[0]!.value}', '${row[1]!.value}', '${row[2]!.value}', ""));
        }
      }

      deliveries.forEach((element) {});

      setState(() {
        display_list = deliveries;
      });
     // loadingController.forward();
    }
  }

  void updateList(String value) {
    setState(() {
      display_list = deliveries
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
              onPressed: () => {
                Navigator.pop(context, true)
              },
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
            children: [
              
              
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () => {
                Navigator.pop(context, true)
              },
            )
          ],
        );
      },
    );
  }

  _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
    });
}

  // showDatePicker(
  //   context: context,
  //   initialDate: selectedDate,
  //   firstDate: DateTime(2000), // Required
  //   lastDate: DateTime(2025),  // Required
  // )

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // Clip(

              // ),
              // Text(
              //   "${selectedDate.toLocal()}".split(' ')[0],
              //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              // ),
              // SizedBox(
              //   width: 20.0,
              // ),
              FloatingActionButton.extended(
                backgroundColor: Colors.orange,
                onPressed: () => _selectDate(context),
                label: CustomText(text:"Assign Drivers", color:Colors.white, size: 15),
                icon: Icon(Icons.date_range )
              ),
              SizedBox(
                width: 20,
              ),
              FloatingActionButton.extended(
                onPressed: () => _selectDate(context),
                label: CustomText(text:"${selectedDate.toLocal()}".split(' ')[0], color:Colors.white, size: 15),
                icon: Icon(Icons.date_range )
              ),
              // TextButton(
              //   onPressed: () => _selectDate(context), // Refer step 3
              //   child: Text(
              //     'Select date',
              //     style:
              //         TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              //   ),
              //   //color: Colors.greenAccent,
              // ),
            

              Expanded(child: Container()),
              FloatingActionButton.extended(
                onPressed: getFile,
                label: CustomText(text:"Add Deliveries", color:Colors.white),
                icon: Icon(Icons.upload_file)
              )
            ],
          ),
        ),
        Container(
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
                      text: "Deliveries",
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
                      hintText: "eg: Name, Order ID, or Phone number",
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
                        label: Text("Order Id"),
                        size: ColumnSize.S,
                       // fixedWidth: 100.0,
                      ),
                      DataColumn2(
                        label: Text('Name'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Address'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Phone Number'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Assigned to Driver'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(
                        label: Text('Delivery Info'),
                        size: ColumnSize.S,
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      display_list.length,
                      (index) => DataRow(cells: [
                        DataCell(CustomText(text: '${deliveries[index].orderId!}')),
                        DataCell(CustomText(text: deliveries[index].name!)),
                        DataCell(CustomText(text: deliveries[index].address!)),
                        DataCell(CustomText(text: deliveries[index].phoneNumber!)),
                        DataCell(CustomText(text: deliveries[index].assignedDriver!)),
                        DataCell(FloatingActionButton(
                          mini: true,
                          onPressed: () {
                            showAlertDialog2();
                          },
                          hoverColor: Colors.amber,
                          child: Icon(
                            Icons.countertops,
                            color: Colors.white,
                            size: 20,
                          ),
                        )
                        )
                      ]),
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

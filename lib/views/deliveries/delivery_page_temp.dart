import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import '../../helpers/responsive_widget.dart';
import '../../models/delivery_model.dart';
import '../../services/database.dart';
import 'widgets/side_panel.dart';

/// * example of stateful widget changing its value when edit is pressed
class DeliverySectionPage extends StatefulWidget {
  DeliverySectionPage({Key? key}) : super(key: key);

  @override
  State<DeliverySectionPage> createState() => _DeliverySectionPage();
}

class _DeliverySectionPage extends State<DeliverySectionPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DeliveryModel> deliveries = [];
  List<DeliveryModel> displayList = [];
  var deliveryList;
  bool showTable = false;
  late AnimationController loadingController;
  DateTime selectedDate = DateTime.now();
  int idx = 0;

  //late Future<QuerySnapshot> deliveryList;

  

  @override
  void initState() {
    //deliveries = widget.deliveries;
    displayList = List.from(deliveries);
   // deliveryList = FirebaseFirestore.instance.collection('deliveries').get();
    super.initState();
    deliveryList = getAllDeliveries();
    print(deliveryList);
    
  }

  getDeliveryData() async {
    var data = await getAllDeliveries();

    setState(() {
      deliveries =
          List.from(data.docs.map((e) => DeliveryModel.fromSnapshot(e)));
      displayList = List.from(deliveries);
    });
  }

  Future<void> getFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List? file = result.files.first.bytes;
      String fileName = result.files.first.name;

      var test = file!.toList();
      var excel = Excel.decodeBytes(test);
      //parseExcel(excel);
      showAlertDialog(fileName, excel);
    }
  }

  void parseExcel(excel) {
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row[0]!.value == 'name') {
          continue;
        }

        String? name = row[0]!.value;
        String? address = row[1]!.value;
        String? phonenumber = '${row[2]!.value}';
        //DeliveryModel delivery = DeliveryModel(Null,name, address, phonenumber, "");
        sendDeliveryDataToDB(name, address, phonenumber);
      }
    }

    setState(() {
      getDeliveryData();
    });
  }

  showAlertDialog(name, excel) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Upload File"),
          content: Text("Uploading file name: $name"),
          actions: [
            TextButton(
              child: const Text("cancel"),
              onPressed: () => {
                //parseExcel(excel),
                Navigator.pop(context, true)
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () => {
                parseExcel(excel),
                deliveryUpdatedTrue(),
                Navigator.pop(context, true)
              },
            )
          ],
        );
      },
    );
  }

  void updateList(String value) {
    setState(() {
      displayList = deliveries
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }


  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // deliveries.forEach((element) { print(element.name!);});
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        key: _scaffoldKey,
        // appBar: AppBar(title: const Text('Drawer Demo')),
        body: SingleChildScrollView(
            child: Column(
          children: [
            topButtons(),
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
              margin: const EdgeInsets.only(
                  top: 30, bottom: 30, left: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 40.0, right: 40.0),
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
                  searchBar(),
                  FutureBuilder<QuerySnapshot>(
                      future: deliveryList,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return const Text("Error");
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          case ConnectionState.done:
                            final List<DocumentSnapshot> documents =
                                snapshot.data!.docs;
                            if(snapshot.data!.docs.length != deliveries.length){
                            deliveries = List.from(documents
                                .map((e) => DeliveryModel.fromSnapshot(e)));
                            displayList = List.from(deliveries);
                            }
                            //print("ran again");
                            return loadTable();
                        }
                      }),
                ],
              ),
            ),
          ],
        )),
        endDrawer: SidePanel(idx: idx, closeSidePanel: _closeEndDrawer),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }

  Widget topButtons(){
    return 
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          FloatingActionButton.extended(
            backgroundColor: Colors.orange,
            onPressed: _openEndDrawer,
            label: const CustomText(
              text: "Assign Drivers",
              color: Colors.white,
              size: 15),
              icon: const Icon(Icons.add_circle
            )
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
            onPressed: () => _selectDate(context),
            isExtended: ResponsiveWidget.isSmallScreen(context) ? false : true,
            label: CustomText(
            text: "${selectedDate.toLocal()}".split(' ')[0],
            color: Colors.white,
            size: 15),
            icon: const Icon(Icons.calendar_month)),
            Expanded(child: Container()),
            FloatingActionButton.extended(
              onPressed: getFile,
              isExtended: ResponsiveWidget.isSmallScreen(context) ? false : true,
              label: const CustomText(
                text: "Add Deliveries", color: Colors.white),
                icon: const Icon(Icons.upload_file
                )
            )
          ],
        ),
    );
  }

  Widget searchBar() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10, left: 40.0, right: 40.0, bottom: 10),
      child: TextField(
        onChanged: (value) => updateList(value),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff0E1420),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            hintText: "eg: Name, Order ID, or Phone number",
            hintStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            prefixIconColor: Colors.white),
      ),
    );
  }
  // Loads table
  Widget loadTable() {
    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          //minWidth: 300,
          columns: const [
            DataColumn2(
              label: Text("Order Id"),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text('Name'),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text('Address'),
              size: ColumnSize.M,
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
                fixedWidth: 100),
          ],
          rows: List<DataRow>.generate(
            displayList.length,
            (index) => DataRow(cells: [
              DataCell(CustomText(text: displayList[index].orderId!)),
              DataCell(CustomText(text: displayList[index].name!)),
              DataCell(CustomText(text: displayList[index].address!)),
              DataCell(CustomText(text: displayList[index].phoneNumber!)),
              DataCell(CustomText(text: displayList[index].assignedDriver!)),
              DataCell(FloatingActionButton(
                mini: true,
                onPressed: () {
                  setState(() {
                    idx = index;
                  });
                  _openEndDrawer();
                },
                hoverColor: Colors.amber,
                child: const Icon(
                  Icons.countertops,
                  color: Colors.white,
                  size: 20,
                ),
              ))
            ]),
          )),
    );
  }

   void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
}

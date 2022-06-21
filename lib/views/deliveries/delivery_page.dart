
import 'dart:typed_data';

import 'package:data_table_2/data_table_2.dart';
import 'package:deliveryportal/models/delivery_model.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import '../../helpers/responsive_widget.dart';
import '../../models/drivers_mode.dart';
import '../../services/database.dart';
import '../upload/widgets/side_panel.dart';
import 'dart:developer' as developer;

/// * example of stateful widget changing its value when edit is pressed
class DeliveriesSectionPage extends StatefulWidget {
  const DeliveriesSectionPage({Key? key}) : super(key: key);

  @override
  State<DeliveriesSectionPage> createState() => _DeliveriesSectionPage();
}

class _DeliveriesSectionPage extends State<DeliveriesSectionPage> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DeliveryModel> deliveries = [];
  List<DeliveryModel> displayList = [];
  int idx = 0;
  bool isDataLoaded = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    getDeliveries().then((value) => 
      setState(() {
        displayList = value;
        deliveries = value;
        isDataLoaded = true;
      }
    ));
    developer.log('initStated', name: 'DeliveriesSectionPage');
  }

  getDeliveryData() async {
    var data = await getAllDeliveries();
    developer.log('getDeliveryData loaded', name: 'DeliveriesSectionPage');
    setState(() {
      deliveries =
          List.from(data.docs.map((e) => DeliveryModel.fromSnapshot(e)));
      displayList = List.from(deliveries);
      isDataLoaded = true;
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
      developer.log('File loaded succesfully', name: 'DeliveriesSectionPage');
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

    developer.log('Excel parsed', name: 'DeliveriesSectionPage');

    setState(() {
      isDataLoaded = false;
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
    // var data = await getAllDeliveries();

    // setState(() {
    //   deliveries =
    //       List.from(data.docs.map((e) => DeliveryModel.fromSnapshot(e)));
    //   displayList = List.from(deliveries);
    //   isDataLoaded = true;
    // });
  }


  // filter list
  void filterList(String value) {
    setState(() {
      displayList = deliveries.where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void startLoading(){
    setState(() {
      isDataLoaded = false;
    });
  }

  void endLoading(){
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
            child: Column(
          children: [
            // load buttons up top
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
                  // widgets
                  searchBar(),
                  loadTable()
                ],
              ),
            ),
          ],
        )),
        endDrawer:SidePanel(idx:idx,closeSidePanel: _closeEndDrawer),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }

  Widget topButtons(){
    developer.log('Loading top buttons', name: 'DeliveriesSectionPage');
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
  
  // buttons at the top
  Widget searchBar() {
    developer.log('Loading search bar', name: 'DeliveriesSectionPage');
    return Padding(
      padding:
          const EdgeInsets.only(top: 10, left: 40.0, right: 40.0, bottom: 10),
      child: TextField(
        onChanged: (value) => filterList(value),
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
    developer.log('table loaded', name: 'DeliveriesSectionPage');
    if(!isDataLoaded){
      return const SizedBox(
        height: 400,
        width: 400,
        child: LoadingIndicator(
            indicatorType: Indicator.pacman, /// Required, The loading type of the widget
            // colors: const [Colors.white],       /// Optional, The color collections
            strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
            // backgroundColor: Colors.black,      /// Optional, Background of the widget
            // pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
        ),
      );
    }

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
                  developer.log('Openning drawer', name: 'DeliveriesSectionPage');
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
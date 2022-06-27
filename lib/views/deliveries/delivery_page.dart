
import 'dart:typed_data';

import 'package:data_table_2/data_table_2.dart';
import 'package:deliveryportal/controllers/delivery_controller.dart';
import 'package:deliveryportal/models/delivery_model.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import '../../helpers/responsive_widget.dart';
import '../../models/drivers_mode.dart';
import '../../services/database.dart';
import 'dart:developer' as developer;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'widgets/side_panel.dart';

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
    // getDeliveries().then((value) => 
    //   setState(() {
    //     displayList = value;
    //     deliveries = value;
    //     isDataLoaded = true;
    //   }



      
    // ));
    isDataLoaded = true;
    developer.log('initStated', name: 'DeliveriesSectionPage');
  }

  // getDeliveryData() async {
  //   var data = await getAllDeliveries();
  //   developer.log('getDeliveryData loaded', name: 'DeliveriesSectionPage');
  //   setState(() {
  //     deliveries =
  //         List.from(data.docs.map((e) => DeliveryModel.fromSnapshot(e)));
  //     displayList = List.from(deliveries);
  //     isDataLoaded = true;
  //   });
  // }

  Future<void> getFile(context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List? file = result.files.first.bytes;
      String fileName = result.files.first.name;

      var test = file!.toList();
      var excel = Excel.decodeBytes(test);
      //parseExcel(excel);
      showAlertDialog(fileName, excel,context);
      //ConfirmDialog(name: fileName, excel: excel);
      developer.log('File loaded succesfully', name: 'DeliveriesSectionPage');
    }
  }

  // void parseExcel(excel) {
  //   for (var table in excel.tables.keys) {
  //     for (var row in excel.tables[table]!.rows) {
  //       if (row[0]!.value == 'name') {
  //         continue;
  //       }

  //       String? name = row[0]!.value;
  //       String? address = row[1]!.value;
  //       String? phonenumber = '${row[2]!.value}';
  //       String? dueDate = row[3]!.value;
  //       String? itemString = row[4]!.value;
  //       //DeliveryModel delivery = DeliveryModel(Null,name, address, phonenumber, "");
  //       sendDeliveryDataToDB(name, address, phonenumber,dueDate,itemString);
  //     }
  //   }

    //developer.log('Excel parsed', name: 'DeliveriesSectionPage');

  //   setState(() {
  //     isDataLoaded = false;
  //     getDeliveryData();
  //   });
  // }

  showAlertDialog(name, excel,context) {
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
              onPressed: ()  async {
               await Provider.of<DeliveryController>(context, listen: false).parseExcel(excel);
                //Provider.of<DeliveryController>(context, listen: false).getAllDeliveries(),
                //parseExcel(excel),
               // await deliveryUpdatedTrue(),
                Navigator.pop(context, true);
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
  // void filterList(String value) {
  //   setState(() {
  //     displayList = deliveries.where((element) =>
  //             element.name!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final deliveryController = Provider.of<DeliveryController>(context);
    deliveries = deliveryController.deliveryList;
    displayList = deliveryController.displayList;
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
            onPressed: () async {
              await Provider.of<DeliveryController>(context, listen: false).assignDrivers("michael@email.com");
            },
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
              onPressed: _openEndDrawer,
              isExtended: ResponsiveWidget.isSmallScreen(context) ? false : true,
              label: const CustomText(
                text: "Add Delivery", color: Colors.white),
                icon: const Icon(Icons.upload_file
                )
            ),
            const SizedBox(
              width: 20,
            ),
            FloatingActionButton.extended(
              onPressed:() {
                getFile(context);
              },
              isExtended: ResponsiveWidget.isSmallScreen(context) ? false : true,
              label: const CustomText(
                text: "Upload Deliveries", color: Colors.white),
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
        onChanged: (value) {
          Provider.of<DeliveryController>(context, listen: false).filterList(value);
          },
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
    if(Provider.of<DeliveryController>(context).loading){
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
    final deliveryController = Provider.of<DeliveryController>(context);

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
              size: ColumnSize.S,
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
              label: Text('Due Date'),
              size: ColumnSize.S,
            ),
            DataColumn2(
                label: Text('Delivery Info'),
                size: ColumnSize.S,
                //fixedWidth: 100
                ),
          ],
          rows: List<DataRow>.generate(
            displayList.length,
            (index) => DataRow(cells: [
              DataCell(CustomText(text: deliveryController.displayList[index].orderId!)),
              DataCell(CustomText(text: deliveryController.displayList[index].name!)),
              DataCell(CustomText(text: deliveryController.displayList[index].address!)),
              DataCell(CustomText(text: deliveryController.displayList[index].phoneNumber!)),
              DataCell(CustomText(text: deliveryController.displayList[index].assignedDriver)),
              DataCell(CustomText(text: deliveryController.displayList[index].dueDate!.substring(0,10))),
              DataCell(FloatingActionButton(
                mini: true,
                onPressed: () {
                  String t = Provider.of<DeliveryController>(context, listen: false).generateBarcodes(index);
                  
                  // show svg
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                     // title: Text(deliveryController.displayList[index].items![0]),
                      content: 
                      Container(
                        width: 400,
                        child: 
                      SvgPicture.string(
                        t,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),)
                  );


                  // setState(() {
                  //   idx = index;
                  // });
                  developer.log('Openning drawer', name: 'DeliveriesSectionPage');
                  //_openEndDrawer();
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
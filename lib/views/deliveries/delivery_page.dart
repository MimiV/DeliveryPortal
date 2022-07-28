import 'dart:io';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:data_table_2/data_table_2.dart';
import 'package:deliveryportal/controllers/delivery_controller.dart';
import 'package:deliveryportal/models/delivery_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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

import 'widgets/delivery_table.dart';
import 'widgets/pdf_test.dart';
import 'widgets/search_bar.dart';
import 'widgets/side_panel.dart';

/// * example of stateful widget changing its value when edit is pressed
class DeliveriesSectionPage extends StatefulWidget {
  const DeliveriesSectionPage({Key? key}) : super(key: key);

  @override
  State<DeliveriesSectionPage> createState() => _DeliveriesSectionPage();
}

class _DeliveriesSectionPage extends State<DeliveriesSectionPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DeliveryModel> deliveries = [];
  List<DeliveryModel> displayList = [];
  int idx = 0;
  bool isDataLoaded = false;
  DateTime selectedDate = DateTime.now();
  String? selectedDriver;
  @override
  void initState() {
    super.initState();
    isDataLoaded = true;
    developer.log('initStated', name: 'DeliveriesSectionPage');
  }

  Future<void> getFile(context) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      Uint8List? file = result.files.first.bytes;
      String fileName = result.files.first.name;

      var test = file!.toList();
      var excel = Excel.decodeBytes(test);
      showAlertDialog(fileName, excel, context);
      developer.log('File loaded succesfully', name: 'DeliveriesSectionPage');
    }
  }

  showAlertDialog(name, excel, context) {
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
              onPressed: () async {
                Navigator.pop(context, true);
                await Provider.of<DeliveryController>(context, listen: false)
                    .parseExcel(excel);
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
  }

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
            topButtons(deliveryController),

            Container(
              height: MediaQuery.of(context).size.height * 0.8,
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
                  //searchBar(),
                  DeliverySearchBar(
                      filterList: Provider.of<DeliveryController>(context,
                              listen: false)
                          .filterList),
                  DeliveryTable(
                      display_list: displayList,
                      loading: deliveryController.loading)
                  //loadTable()
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

  Widget topButtons(deliveryController) {
    developer.log('Loading top buttons', name: 'DeliveriesSectionPage');
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          FloatingActionButton.extended(
              backgroundColor: Colors.orange,
              onPressed: () async {
                await Provider.of<DeliveryController>(context, listen: false)
                    .assignDrivers("michael@email.com");
              },
              label: const CustomText(
                  text: "Assign Drivers", color: Colors.white, size: 15),
              icon: const Icon(Icons.add_circle)),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
              onPressed: () => _selectDate(context),
              isExtended:
                  ResponsiveWidget.isSmallScreen(context) ? false : true,
              label: CustomText(
                  text: "${selectedDate.toLocal()}".split(' ')[0],
                  color: Colors.white,
                  size: 15),
              icon: const Icon(Icons.calendar_month)),
          Expanded(child: Container()),
          FloatingActionButton.extended(
              backgroundColor: Colors.green,
              onPressed: () {
                // go to pdf demo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfLabPage(),
                  ),
                );
              },
              isExtended:
                  ResponsiveWidget.isSmallScreen(context) ? false : true,
              label: const CustomText(text: "Barcodes", color: Colors.white),
              icon: const Icon(Icons.upload_file)),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
              onPressed: _openEndDrawer,
              isExtended:
                  ResponsiveWidget.isSmallScreen(context) ? false : true,
              label:
                  const CustomText(text: "Add Delivery", color: Colors.white),
              icon: const Icon(Icons.upload_file)),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
              onPressed: () {
                getFile(context);
              },
              isExtended:
                  ResponsiveWidget.isSmallScreen(context) ? false : true,
              label: const CustomText(
                  text: "Upload Deliveries", color: Colors.white),
              icon: const Icon(Icons.upload_file))
        ],
      ),
    );
  }

  final pdf = pw.Document();
  var anchor;

  savePDF() async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'pdf.pdf';
    html.document.body!.children.add(anchor);
  }

  createPDF() async {
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text('Hello World', style: pw.TextStyle(fontSize: 40)),
          ],
        ),
      ),
    );
    savePDF();
  }

  // popup with a pdf of barcodes

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
}

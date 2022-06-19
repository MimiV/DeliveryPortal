import 'dart:typed_data';

import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../constants/style.dart';
import '../../models/delivery_model.dart';
import '../../widgets/custom_text.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class UploadFilePage extends StatefulWidget {
  UploadFilePage({Key? key}) : super(key: key);

  @override
  State<UploadFilePage> createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage>
    with SingleTickerProviderStateMixin {
  List<DeliveryModel> deliveries = [];
  bool ShowProgress = true;
  bool showTable = false;
  late AnimationController loadingController;

  @override
  void initState() {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {
          showTable= true;
        });
      });

    super.initState();
  }

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
          deliveries.add(DeliveryModel(0,
              '${row[0]!.value}', '${row[1]!.value}', '${row[2]!.value}',""));
        }
      }

      deliveries.forEach((element) {});

      setState(() {
        showTable = true;
        ShowProgress = false;
      });
      loadingController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
            Text('Upload your file', style: TextStyle(fontSize: 25, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text('File should be jpg, png', style: TextStyle(fontSize: 15, color: Colors.grey.shade500),),
            SizedBox(height: 20,),
              Container(
                height: 200.0,
                width: 200.0,
                child: ShowProgress ? 
                GestureDetector(
                  onTap: () {
                    getFile();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10),
                      dashPattern: [10, 4],
                      strokeCap: StrokeCap.round,
                      color: Colors.blue.shade400,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50.withOpacity(.3),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.folder_open, color: Colors.blue, size: 40,),
                            SizedBox(height: 15,),
                            Text('Select your file', style: TextStyle(fontSize: 15, color: Colors.grey.shade400),),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              :
              LiquidCircularProgressIndicator(
              //value: progress / 100,
              value: loadingController.value * 100,
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
              backgroundColor: Colors.white,
              direction: Axis.vertical,
              center: Text(
                "${(loadingController.value * 100).toStringAsFixed(0)}.%",
                style: GoogleFonts.poppins(color: Colors.black87, fontSize: 25.0),
              ),
            ),

        ),
        // IconButton(
        //   icon: const Icon(Icons.upload_file),
        //   onPressed: () => getFile(),
        // ),
          // Container(
          //   height: 200.0,
          //   width: 200.0,
          //   child: LiquidCircularProgressIndicator(
          //     //value: progress / 100,
          //     value: loadingController.value * 100,
          //     valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
          //     backgroundColor: Colors.white,
          //     direction: Axis.vertical,
          //     center: Text(
          //       "${(loadingController.value * 100).toStringAsFixed(0)}.%",
          //       style: GoogleFonts.poppins(color: Colors.black87, fontSize: 25.0),
          //     ),
          //   ),
          // ),
        
        if ((loadingController.value*100) == 100)
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active, width: .5),
              boxShadow: [
                const BoxShadow(
                    offset: Offset(0, 6), color: Colors.black, blurRadius: 12)
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            // p
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                columns: const [
                  DataColumn2(
                    label: Text("Name"),
                    size: ColumnSize.S,
                    // fixedWidth: 100.0,
                  ),
                  DataColumn2(
                    label: Text('Address'),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    label: Text('Phone Number'),
                    size: ColumnSize.S,
                  ),
                  // DataColumn2(
                  //   label: Text('Action'),
                  //   //size: ColumnSize.S,
                  //   fixedWidth: 150
                  // ),
                ],
                rows: List<DataRow>.generate(
                  deliveries.length,
                  (index) => DataRow(cells: [
                    DataCell(CustomText(text: deliveries[index].name!)),
                    DataCell(CustomText(text: deliveries[index].address!)),
                    DataCell(CustomText(text: deliveries[index].phoneNumber!)),
                  ]),
                )),
          )
      ],
    ));
  }
}

import 'package:barcode/barcode.dart';
import 'package:deliveryportal/models/drivers_mode.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:universal_html/html.dart' as html;

import '../../../controllers/delivery_controller.dart';
import '../../../models/delivery_model.dart';
import '../../../models/item_model.dart';

class PdfLabPage extends StatefulWidget {
  @override
  //PdfLabPage({Key? key}) : super(key: key);
  State<PdfLabPage> createState() => _PdfLabPageState();
}

class _PdfLabPageState extends State<PdfLabPage> {
  @override
  String getCode(String code) {
    final dm = Barcode.code128();
    final svg =
        dm.toSvg(code, width: 200, height: 100, drawText: false, fontHeight: 15);
    //dm.toSvg(data)
    return svg;
  }

  String? selectedDriver;
  Widget build(BuildContext context) {
    final dm = Provider.of<DeliveryController>(context, listen: false);
    final List<DriversModel> items = dm.allDriversList;
    final TextEditingController textEditingController = TextEditingController();
    List<DeliveryModel> deliveriesByDriver =
        selectedDriver != null ? dm.getDeliveriesByDriver(selectedDriver!) : [];
    DriversModel? currentDriver =
        selectedDriver != null ? dm.getDriverByEmail(selectedDriver!) : null;
    print(deliveriesByDriver);
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      maxPages: 100,
      build: (pw.Context context) => [
        //pw.Partition(child: pw.Container()),
        pw.Container(
            alignment: pw.Alignment.center,
            child: pw.Column(children: [
              if (currentDriver != null)
                pw.Text(
                  'Deliveries for ${currentDriver.name}',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold),
                ),
              pw.SizedBox(height: 30),
              //pw.Text("${deliveriesByDriver.length}"),
              if (deliveriesByDriver.isNotEmpty)
                // list build on deliveryModel.items
                pw.ListView.builder(
                    itemCount: deliveriesByDriver.length,
                    itemBuilder: (context, index) {
                      return pw.ListView.builder(
                          itemCount: deliveriesByDriver[index].items!.length,
                          itemBuilder: (cxt, i) {
                            return pw.Column(children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.only(left: 100),
                                child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("Name: ",
                                        style: pw.TextStyle(fontSize: 12)),
                                    pw.Text(
                                      "${deliveriesByDriver[index].name}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.only(left: 100),
                                child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("Address: ",
                                        style: pw.TextStyle(fontSize: 12)),
                                    pw.Text(
                                      "${deliveriesByDriver[index].address}",
                                      style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              pw.SizedBox(height: 10),
                              pw.SvgImage(
                                svg: getCode(
                                    deliveriesByDriver[index].items![i]),
                                width: 200,
                                height: 100,
                              ),
                              pw.SizedBox(height: 30),
                            ]);
                          });
                    })
            ]))
      ],
    ));

    // pdf.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Container(
    //           alignment: pw.Alignment.center,
    //           child: pw.Column(children: [
    //             pw.Text(
    //               'Delivery Portal Delivery',
    //               style: pw.TextStyle(
    //                   fontSize: 30, fontWeight: pw.FontWeight.bold),
    //             ),
    //             pw.Text("${deliveriesByDriver.length}"),
    //             if (deliveriesByDriver.isNotEmpty)
    //               // list build on deliveryModel.items
    //               pw.ListView.builder(
    //                   itemCount: deliveriesByDriver.length,
    //                   itemBuilder: (context, index) {
    //                     return pw.ListView.builder(
    //                         itemCount: deliveriesByDriver[index].items!.length,
    //                         itemBuilder: (cxt, i) {
    //                           return pw.Column(children: [
    //                             pw.Row(
    //                               crossAxisAlignment:
    //                                   pw.CrossAxisAlignment.center,
    //                               children: [
    //                                 pw.Text("Driver: ",
    //                                     style: pw.TextStyle(fontSize: 20)),
    //                                 pw.Text(
    //                                   "${deliveriesByDriver[index].items![i]}",
    //                                   style: pw.TextStyle(
    //                                       fontSize: 20,
    //                                       fontWeight: pw.FontWeight.bold),
    //                                 ),
    //                               ],
    //                             ),
    //                             // pw.SvgImage(
    //                             //   svg: getCode(
    //                             //       deliveriesByDriver[index].items![i]),
    //                             //   width: 100,
    //                             //   height: 100,
    //                             // ),
    //                           ]);
    //                         });
    //                   })
    //           ]));

    //       // return pw.Center(
    //       //   child: pw.Text('Hello World'),
    //       // );
    //     }));

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  "Select a driver",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item.email,
                          child: Text(
                            item.email!,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedDriver,
                onChanged: (value) {
                  var cur = value as String?;
                  setState(() {
                    selectedDriver = cur.toString();
                  });
                  // print(cur.toString());
                },
                buttonHeight: 40,
                buttonWidth: 200,
                itemHeight: 40,
                dropdownMaxHeight: 200,
                searchController: textEditingController,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 4,
                    right: 8,
                    left: 8,
                  ),
                  child: TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'Search for an item...',
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return (item.value.toString().contains(searchValue));
                },
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final bytes = await pdf.save();
                    final blob = html.Blob([bytes], 'application/pdf');
                    final url = html.Url.createObjectUrlFromBlob(blob);
                    html.window.open(url, '_blank');
                    html.Url.revokeObjectUrl(url);
                  },
                  child: Text('Open'),
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () async {
                    final bytes = await pdf.save();
                    final blob = html.Blob([bytes], 'application/pdf');
                    final url = html.Url.createObjectUrlFromBlob(blob);
                    final anchor = html.AnchorElement()
                      ..href = url
                      ..style.display = 'none'
                      ..download = 'barcodes.pdf';
                    html.document.body?.children.add(anchor);
                    anchor.click();
                    html.document.body?.children.remove(anchor);
                    html.Url.revokeObjectUrl(url);
                  },
                  child: Text('Download'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

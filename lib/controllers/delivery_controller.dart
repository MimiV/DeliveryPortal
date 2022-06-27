import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';

import '../models/delivery_model.dart';
import '../services/database.dart';

class DeliveryController extends ChangeNotifier {
  List<DeliveryModel>? _deliveryList; 
  List<DeliveryModel>? _displayList;
  bool? _loading;



  DeliveryController() {
    _deliveryList = [];
    _displayList = [];
    _loading = true;
  }

  List<DeliveryModel> get deliveryList => _deliveryList!;
  bool get loading => _loading!;
  List<DeliveryModel> get displayList => _displayList!;


  Future<void> getAllDeliveries() async {
    _deliveryList = await getDeliveries();
    _displayList = _deliveryList;
    _loading = false;
    notifyListeners();
  }


  Future<void> parseExcel(excel) async {
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row[0]!.value == 'name') {
          continue;
        }

        String? name = row[0]!.value;
        String? address = row[1]!.value;
        String? phonenumber = '${row[2]!.value}';
        String? dueDate = row[3]!.value;
        String? itemString = row[4]!.value;
        //DeliveryModel delivery = DeliveryModel(Null,name, address, phonenumber, "");
        await sendDeliveryDataToDB(name, address, phonenumber,dueDate,itemString);
      }
    }

    // developer.log('Excel parsed', name: 'DeliveriesSectionPage');

    // setState(() {
    //   isDataLoaded = false;
    //   getDeliveryData();
    // });
    _loading = true;
    await getAllDeliveries();
    
    notifyListeners();

  }

  void filterList(String value) {
    _displayList = _deliveryList!.where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    notifyListeners();
  }

  Future<void> addDelivery(DeliveryModel delivery) async {
    await sendDeliveryDataToDB(delivery.name, delivery.address,delivery.phoneNumber,delivery.dueDate,delivery.itemsString);
     _loading = true;
    await getAllDeliveries();
    //notifyListeners(); //already done in all deliveries
  }
  // add todo to all
  // Future<void> test() async {
  //   for (var element in _deliveryList!) { 
  //     //print(element.orderId);
  //     await addStatus(element.orderId);
  //   }
  //    _loading = true;
  //   await getAllDeliveries();
  // }

  Future<void> assignDrivers(driver) async {
    for (var element in _deliveryList!) { 
      if (element.assignedDriver == '') {
        //element.assignedDriver = 'michael@email.com';
        await updateDelivery(element.orderId, driver);
      }
    }
    _loading = true;
    await getAllDeliveries();
  }

  void test(){
    print("test");

    for (var element in _deliveryList!) { 
        //element.assignedDriver = 'michael@email.com';
        print(element.items);
    }
  }

  String generateBarcodes(index) {
    final dm = Barcode.code128();
    final svg = dm.toSvg(displayList[index].items![0], width: 200, height: 200, drawText: true, fontHeight: 15);
    //dm.toSvg(data)
    return svg;
    //var test = await File('${displayList[index].items![0]}.svg').writeAsString(svg);
    //print(test);

  }

}
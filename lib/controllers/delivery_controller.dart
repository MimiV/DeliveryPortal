import 'dart:io';

import 'package:barcode/barcode.dart';
import 'package:deliveryportal/models/drivers_mode.dart';
import 'package:flutter/material.dart';

import '../models/delivery_model.dart';
import '../services/database.dart';

class DeliveryController extends ChangeNotifier {
  List<DeliveryModel>? _deliveryList;
  List<DeliveryModel>? _displayList;
  List<DeliveryModel>? _completedDeliveryList;
  List<DriversModel>? _allDrivers;
  bool? _loading;
  DriversModel? currentSelectedDriver;
  String? driverForPdf;

  DeliveryController() {
    _deliveryList = [];
    _displayList = [];
    _completedDeliveryList = [];
    _loading = true;
    _allDrivers = [];
  }

  List<DeliveryModel> get deliveryList => _deliveryList!;
  bool get loading => _loading!;
  List<DeliveryModel> get displayList => _displayList!;
  List<DeliveryModel> get completedDeliveryList => _completedDeliveryList!;
  List<DriversModel> get allDriversList => _allDrivers!;

  int get deliveryCount => _deliveryList!.length;
  int get completedDeliveryCount => _completedDeliveryList!.length;

  Future<void> getAllDeliveries() async {
    _deliveryList = await getDeliveries();
    _deliveryList!.sort((a, b) => b.dueDate!.compareTo(a.dueDate!));
    _displayList = _deliveryList;
    // sort by due date
    
    _loading = false;
    notifyListeners();
  }

  Future<void> parseExcel(excel) async {
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row[0]!.value.toString().toLowerCase() == 'name') {
          continue;
        }

        String? name = row[0]!.value;
        String? address = row[1]!.value;
        String? phonenumber = '${row[2]!.value}';
        String? dueDate = row[3]!.value;
        String? itemString = row[4]!.value;
        //DeliveryModel delivery = DeliveryModel(Null,name, address, phonenumber, "");
        await sendDeliveryDataToDB(
            name, address, phonenumber, dueDate, itemString);
      }
    }

    // developer.log('Excel parsed', name: 'DeliveriesSectionPage');

    // setState(() {
    //   isDataLoaded = false;
    //   getDeliveryData();
    // });
    _loading = true;
    notifyListeners();
    await getAllDeliveries();

    notifyListeners();
  }

  void selectDriver(index, DriversModel driver) {
    displayList[index].assignedDriver = driver.email!;
    notifyListeners();
  }

  void selectDriverForPdf(String driver) {
    driverForPdf = driver;
    notifyListeners();
  }

  void filterList(String value) {
    _displayList = _deliveryList!
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    notifyListeners();
  }

  Future<void> addDelivery(DeliveryModel delivery) async {
    await sendDeliveryDataToDB(delivery.name, delivery.address,
        delivery.phoneNumber, delivery.dueDate, delivery.itemsString);
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
      //element.assignedDriver = 'michael@email.com';
      _deliveryList![_deliveryList!.indexOf(element)].assignedDriver = driver;
      await updateDelivery(element.orderId, driver);
    }
    //_loading = true;
    notifyListeners();
    //await getAllDeliveries();
  }

  // assign driver to delivery
  Future<void> assignDriver(driver, index) async {
    _deliveryList![index].assignedDriver = driver;
    await updateDelivery(_deliveryList![index].orderId, driver);
    notifyListeners();
  }

  void test() {
    print("test");

    for (var element in _deliveryList!) {
      //element.assignedDriver = 'michael@email.com';
      print(element.items);
    }
  }

  Future<void> getCompleted() async {
    await getAllDeliveries();
    _completedDeliveryList = _deliveryList!
        .where((element) => element.status == 'completed')
        .toList();
    print(_completedDeliveryList.toString());
    notifyListeners();
  }

  // get from db deliveries all with status = 'completed'
  Future<void> getCompletedDeliveries() async {
    _completedDeliveryList = await getAllCompletedDeliveries();
    _loading = false;
    notifyListeners();
  }

  // get all drivers from db
  Future<void> getAllDrivers() async {
    _allDrivers = await getDrivers();
    DriversModel temp = DriversModel(
        "123", "Michael V", "michael@email.com", "123456789", 10, 0);
    _allDrivers!.add(temp);
    DriversModel temp2 = DriversModel(
        "123", "Michael V", "", "123456789", 10, 0);
    _allDrivers!.add(temp2);
    notifyListeners();
  }

  String generateBarcodes(index) {
    final dm = Barcode.code128();
    final svg = dm.toSvg(displayList[index].items![0],
        width: 200, height: 200, drawText: true, fontHeight: 15);
    //dm.toSvg(data)
    return svg;
    //var test = await File('${displayList[index].items![0]}.svg').writeAsString(svg);
    //print(test);
  }

  List<DeliveryModel> getDeliveriesByDriver(String driver) {
    List<DeliveryModel> temp = _deliveryList!
        .where((element) => element.assignedDriver == driver)
        .toList();
    return temp;
  }

  DriversModel getDriverByEmail(String email) {
    return _allDrivers!.firstWhere((element) => element.email == email);
  }
}

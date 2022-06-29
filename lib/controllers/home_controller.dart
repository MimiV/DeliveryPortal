
import 'package:flutter/material.dart';
import '../models/drivers_mode.dart';
import '../services/database.dart';
import 'package:intl/intl.dart';

class HomeController extends ChangeNotifier  {
  List<DriversModel>? _availableDriversList; 
  List<DriversModel>? _displayList;
  bool? _loading;
  String? _hello;
  
  HomeController() {
    _availableDriversList = [];
    _displayList = [];
    _loading = true;
  }

  String get hello => _hello!;
  bool get loading => _loading!;
  List<DriversModel> get availableDriversList {
    return _availableDriversList ?? [];
  }

  List<DriversModel> get displayList {
    return _displayList!;
  }

  void filterList(String value) {
  _displayList = _availableDriversList!.where((element) =>
          element.name!.toLowerCase().contains(value.toLowerCase()))
      .toList();

  notifyListeners();
  }

  Future<void> getAllDrivers() async {
    _availableDriversList = await getDrivers();
    _displayList = _availableDriversList;
    //print(_displayList);
    _loading = false;
    notifyListeners();
  }

  Future<void> getAllDriversAvailableToday() async {
    String day = DateFormat('EEEE').format(DateTime.now());
    //print(day);
    _availableDriversList = await getDriversAvailableToday(day);
    _displayList = _availableDriversList;
    _loading = false;
    notifyListeners();
  }

  // add todo to all
  Future<void> test() async {
    List<DriversModel> drivers = await getDrivers();
    for (var element in drivers) { 
      //print(element.orderId);
      await addAvailability(element.id);
    }
    
    _loading = true;
    await getAllDriversAvailableToday();
  }

  // add new driver
  Future<void> addDriver(name,email,phone,) async {
    await registerDriver(name, email, phone);
    _loading = true;
    notifyListeners();
    await getAllDrivers();
    //notifyListeners(); //already done in all deliveries
  }



  
}
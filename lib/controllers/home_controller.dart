import 'package:deliveryportal/controllers/delivery_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/drivers_mode.dart';
import '../services/database.dart';
import 'package:intl/intl.dart';

class HomeController extends ChangeNotifier {
  List<DriversModel>? _availableDriversList;
  List<DriversModel>? _displayList;
  List<DriversModel>? _dashboardAvailableDriversList;
  List<DriversModel>? _dashboardDisplayList;
  DateTime dashboardSelectedDate = DateTime.now();
  bool? _loading;
  bool? _dashboardLoading;
  String? _hello;

  HomeController() {
    _availableDriversList = [];
    _dashboardAvailableDriversList = [];
    _dashboardDisplayList = [];
    _displayList = [];
    _loading = true;
    _dashboardLoading = true;
  }

  String get hello => _hello!;
  bool get loading => _loading!;
  bool get dashboardLoading => _dashboardLoading!;
  List<DriversModel> get availableDriversList {
    return _availableDriversList ?? [];
  }

  List<DriversModel> get dashboardAvailableDriversList {
    return _dashboardAvailableDriversList ?? [];
  }

  List<DriversModel> get dashboardDisplayList {
    return _dashboardDisplayList ?? [];
  }

  List<DriversModel> get displayList {
    return _displayList!;
  }

  void filterList(String value) {
    _displayList = _availableDriversList!
        .where((element) =>
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
  Future<void> addDriver(
    name,
    email,
    phone,
  ) async {
    await registerDriver(name, email, phone);
    _loading = true;
    notifyListeners();
    await getAllDrivers();
    //notifyListeners(); //already done in all deliveries
  }

  Future<void> getDashBoardAvailabeDrivers(DateTime pickedDate, context) async {
    List<DriversModel> drivers = await getDrivers();
    List<DriversModel> temp = [];
    final dc = Provider.of<DeliveryController>(context, listen: false);
    for (DriversModel element in drivers) {
      String dateWeekday = DateFormat('E').format(pickedDate);
      if (element.availability!.contains(dateWeekday)) {
        int numDeliveries = dc.deliveryList
            .where((e) =>
                (e.assignedDriver == element.email) &&
                (DateFormat('yMd').format(DateTime.parse(e.dueDate!)) ==
                    DateFormat('yMd').format(pickedDate)))
            .length;
        int completedDeliveries = dc.deliveryList
            .where((e) =>
                (e.assignedDriver == element.email) &&
                (DateFormat('yMd').format(DateTime.parse(e.dueDate!)) ==
                    DateFormat('yMd').format(pickedDate)) &&
                (e.status == 'Completed'))
            .length;
        element.deliveries_assigned = numDeliveries;
        element.deliveries_completed = completedDeliveries;
        temp.add(element);
        //print("Driver: ${element.name} is available");
      }
    }
    // sort temp by deliveries_assigned
    temp.sort(
        (a, b) => b.deliveries_assigned!.compareTo(a.deliveries_assigned!));
    _dashboardAvailableDriversList = temp;
    _dashboardDisplayList = _dashboardAvailableDriversList;
    _dashboardLoading = false;
    notifyListeners();
  }

  void filterDasboardList(String value) {
    _dashboardDisplayList = _dashboardAvailableDriversList!
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();

    notifyListeners();
  }
}

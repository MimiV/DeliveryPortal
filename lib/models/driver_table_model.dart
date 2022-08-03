import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multiselect/multiselect.dart';
import 'package:provider/provider.dart';

import '../controllers/delivery_controller.dart';
import 'delivery_model.dart';
import 'drivers_mode.dart';

class DriversTableData extends DataTableSource {
  // Generate some made-up data
  List<DriversModel> _data = [];
  Function()? _onPressed;
  var _context;

  DriversTableData(List<DriversModel> value, onPressed, context) {
    _data = value;
    _onPressed = onPressed;
    _context = context;
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    final dm = Provider.of<DeliveryController>(_context, listen: false);
    List<String>? weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    List<String> availability =
        _data[index].availability!.map((e) => e.toString()).toList();
    // number of deliveries by this driver
    int numDeliveries = dm.deliveryList
        .where((e) => e.assignedDriver == _data[index].email)
        .length;
    return DataRow(cells: [
      DataCell(Text(_data[index].name.toString())),
      DataCell(Text(_data[index].phoneNumber.toString())),
      DataCell(
        //Text(_data[index].availability.toString())

        Container(
          width: 300,
          child: DropDownMultiSelect(
            onChanged: (List<String> x) {
              dm.updateDriversAvailability(_data[index], x);
            },
            options: weekdays,
            selectedValues: availability,
            whenEmpty: 'Select Something',
          ),
        ),
      ),
      DataCell(Text(numDeliveries.toString())),
      DataCell(FloatingActionButton(
        mini: true,
        onPressed: () {
          _onPressed!();
        },
        hoverColor: Colors.amber,
        child: const Icon(
          Icons.countertops,
          color: Colors.white,
          size: 20,
        ),
      ))
    ]);
  }
}

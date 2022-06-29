import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../controllers/delivery_controller.dart';
import 'delivery_model.dart';
import 'drivers_mode.dart';


class DriversTableData extends DataTableSource {
  // Generate some made-up data
  List<DriversModel> _data = [];
  Function()? _onPressed;

  DriversTableData(List<DriversModel> value, onPressed){
    _data = value;
    _onPressed = onPressed;
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index].name.toString())),
      DataCell(Text(_data[index].phoneNumber.toString())),
      DataCell(Text(_data[index].availability.toString())),
      DataCell(Text(_data[index].deliveries_assigned.toString())),
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
      ]
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/drivers_mode.dart';
import '../controllers/delivery_controller.dart';
import '../controllers/home_controller.dart';
import 'package:intl/intl.dart';

class HomeTableData extends DataTableSource {
  // Generate some made-up data
  List<DriversModel> _data = [];
  var _context;

  HomeTableData(List<DriversModel> value, context) {
    _data = value;
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
    final hc = Provider.of<HomeController>(_context, listen: false);
    final dc = Provider.of<DeliveryController>(_context, listen: false);
    int numDeliveries = dc.deliveryList
        .where((e) =>
            (e.assignedDriver == _data[index].email) &&
            (DateFormat('yMd').format(DateTime.parse(e.dueDate!)) ==
                DateFormat('yMd').format(hc.dashboardSelectedDate)))
        .length;

    int completedDeliveries = dc.deliveryList
        .where((e) =>
            (e.assignedDriver == _data[index].email) &&
            (DateFormat('yMd').format(DateTime.parse(e.dueDate!)) ==
                DateFormat('yMd').format(hc.dashboardSelectedDate)) &&
            (e.status == 'completed'))
        .length;
    return DataRow(cells: [
      DataCell(Text(_data[index].name.toString())),
      DataCell(Text(numDeliveries.toString())),
      DataCell(Text(completedDeliveries.toString())),
      DataCell(Row(children: [
        IconButton(
          onPressed: () => {},
          hoverColor: Colors.amber,
          icon: Icon(
            Icons.countertops,
            color: Colors.blue,
            size: 20,
          ),
        ),
        // Container(
        //   width: 5,
        //   height: 1,
        //   color: Colors.white,
        // ),
        IconButton(
          onPressed: () => {},
          icon: Icon(
            Icons.edit,
            color: Colors.black,
            size: 15,
          ),
        ),
        // Container(
        //   width: 5,
        //   height: 1,
        //   color: Colors.white,
        // ),
        Flexible(
            child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.star,
            color: Colors.deepOrange,
            size: 15,
          ),
        ))
      ]))
    ]);
  }
}

import 'package:flutter/material.dart';

import '../../../models/drivers_mode.dart';

class HomeTableData extends DataTableSource {
  // Generate some made-up data
  List<DriversModel> _data = [];

  HomeTableData(List<DriversModel> value){
    _data = value;
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
      DataCell(Text(_data[index].deliveries_assigned.toString())),
      DataCell(Text(_data[index].deliveries_completed.toString())),
      DataCell(
            Row(
              children: [
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
              ]
            )
          )
      ]
    );
  }
}
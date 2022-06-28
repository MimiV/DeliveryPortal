import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../controllers/delivery_controller.dart';
import 'delivery_model.dart';


class DeliveryTableData extends DataTableSource {
  // Generate some made-up data
  List<DeliveryModel> _data = [];
  var _context;

  DeliveryTableData(List<DeliveryModel> value, context){
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
    return DataRow(cells: [
      DataCell(Text(_data[index].orderId.toString())),
      DataCell(Text(_data[index].name.toString())),
      DataCell(Text(_data[index].address.toString())),
      DataCell(Text(_data[index].phoneNumber.toString())),
      DataCell(Text(_data[index].assignedDriver.toString())),
      DataCell(Text(_data[index].dueDate!.substring(0,10).toString())),
      DataCell(
        FloatingActionButton(
          mini: true,
          onPressed: () {
            String t = Provider.of<DeliveryController>(_context, listen: false).generateBarcodes(index);
            
            // show svg
            showDialog(
              context: _context,
              builder: (context) => AlertDialog(
                // title: Text(deliveryController.displayList[index].items![0]),
                content: 
                Container(
                  width: 400,
                  child: 
                SvgPicture.string(
                  t,
                  allowDrawingOutsideViewBox: true,
                ),
              ),)
            );
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
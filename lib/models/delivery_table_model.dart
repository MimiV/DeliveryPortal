import 'package:deliveryportal/models/drivers_mode.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../controllers/delivery_controller.dart';
import 'delivery_model.dart';

class DeliveryTableData extends DataTableSource {
  // Generate some made-up data
  List<DeliveryModel> _data = [];
  var _context;

  DeliveryTableData(List<DeliveryModel> value, context) {
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
      //DataCell(Text(_data[index].assignedDriver.toString())),
      DataCell(dropMenu(index)),
      DataCell(Text(_data[index].dueDate!.substring(0, 10).toString())),
      DataCell(FloatingActionButton(
        mini: true,
        onPressed: () {
          String t = Provider.of<DeliveryController>(_context, listen: false)
              .generateBarcodes(index);

          // show svg
          showDialog(
              context: _context,
              builder: (context) => AlertDialog(
                    // title: Text(deliveryController.displayList[index].items![0]),
                    content: Container(
                      width: 400,
                      child: SvgPicture.string(
                        t,
                        allowDrawingOutsideViewBox: true,
                      ),
                    ),
                  ));
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

  Widget dropMenu(index) {
    final dm = Provider.of<DeliveryController>(_context, listen: false);
    final List<DriversModel> items = dm.allDriversList;
    // filter items by selected value
    // List<DriversModel> filteredItems = items.where((item) {
    //   return item.email != dm.displayList[index].assignedDriver;
    // }).toList();
    String? selectedDriver = dm.displayList[index].assignedDriver;
    final TextEditingController textEditingController = TextEditingController();
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Text(
          "Select a driver",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(_context).hintColor,
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
        value: dm.displayList[index].assignedDriver,
        onChanged: (value) {
          //dm.selectDriver(index, value as DriversModel);
          //var cur = value as DriversModel;
          selectedDriver = value as String?;
          dm.displayList[index].assignedDriver = value!;
          dm.assignDriver(value, index);
          print(value);
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
    );
  }
}

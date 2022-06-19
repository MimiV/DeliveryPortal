import 'dart:math';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../constants/style.dart';
import '../../models/drivers_mode.dart';
import '../../widgets/custom_text.dart';

class ListTest extends StatefulWidget {
  ListTest({Key? key}) : super(key: key);

  @override
  State<ListTest> createState() => _ListTestState();
}

class _ListTestState extends State<ListTest> {
  static List<Drivers> current_drivers = [
    Drivers("michael vasconcelos", 10, 3),
    Drivers("Bebe", 7, 2),
    Drivers("Luna", 8, 4),
    Drivers("Iva", 9, 1),
    Drivers("Michelle", 10, 0),
  ];

  // list to be displayed and filtered
  List<Drivers> display_list = List.from(current_drivers);

  void updateList(String value) {

    setState(() {
      display_list = current_drivers.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    //final items = List<String>.generate(10000, (i) => 'Item $i');
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) => updateList(value),
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none),
                hintText: "eg: Name",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: Colors.black),
          ),
          const SizedBox(
            height: 5.0,
          ),

          Card( 
            color: light,
            
            child:
          SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              DataTable2(
              columnSpacing: 10,
              horizontalMargin: 30,
              //minWidth: _width / 2,
              columns: const [
              DataColumn2(
                  label: Text("Name"),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text('Total Deliveries'),
                  size: ColumnSize.S
                ),
                DataColumn2(
                  label: Text('Completed'),
                  size: ColumnSize.S
                ),
                DataColumn2(
                  label: Text(''),
                  size: ColumnSize.S
                ),
              ],
              rows: List.generate(
                display_list.length,
                (index) => DataRow(cells: [
                  DataCell(CustomText(text: display_list[index].name!)),
                  DataCell(CustomText(text: '${display_list[index].today_deliveries}')),
                  DataCell(Row(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: '${current_drivers[index].completed}',
                      )
                    ],
                  )),
                  DataCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => {},
                          hoverColor: Colors.amber,
                          icon:Icon(Icons.countertops ,color: Colors.blue,size: 20,),
                        ),
                        
                      ],
                    ),

                  )
                ]),
              )),
                  
            ]
            )

                
              
      



  
 
                 
            ))
            ]
          )
      );
    // LIST TILE FOR DRIVER DELIVERIES!!!
  }
}

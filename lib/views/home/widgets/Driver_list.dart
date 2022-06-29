import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../controllers/home_controller.dart';
import '../../../helpers/responsive_widget.dart';
import '../../../models/drivers_mode.dart';
import '../../../models/home_table_model.dart';
import '../../../widgets/custom_text.dart';

class ListOfDrivers extends StatefulWidget {
  List<DriversModel>display_list;
  ListOfDrivers({Key? key, required this.display_list}) : super(key: key);

  @override
  State<ListOfDrivers> createState() => _ListOfDriversState();
}

class _ListOfDriversState extends State<ListOfDrivers> {
  //List<DriversModel>display_list = [];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    //final widget = Provider.of<widget>(context);S
   // print("lenght");
    //print(widget.display_list.length);
    //print(_width);
    double spaceSize(){
      if (ResponsiveWidget.isLargeScreen(context)){
        return _width / 4.5;
      }else if(ResponsiveWidget.isMediumScreen(context)){
        return _width / 7;
      }

      return _width / 39;
    }


    return  Container(
        height: 500,
        child: Padding(
                padding: ResponsiveWidget.isLargeScreen(context) ? 
                  EdgeInsets.only(top:10.0, right:40.0,left:40.0, bottom:0.0): 
                  EdgeInsets.only(top:0.0, right:0.0,left:0.0, bottom:0.0),
                child: SingleChildScrollView(
                  child: PaginatedDataTable(
                    source: HomeTableData(widget.display_list),
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Price')),
                      DataColumn(label: Text('Quantity')),
                  ],
                  columnSpacing:spaceSize(),
                  horizontalMargin: 10,
                  rowsPerPage: 8,
                  showCheckboxColumn: false,
                )
        ),
      ),
    );
  }
}
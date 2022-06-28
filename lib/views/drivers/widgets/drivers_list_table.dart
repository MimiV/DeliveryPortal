

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../helpers/responsive_widget.dart';
import '../../../models/delivery_model.dart';
import '../../../models/delivery_table_model.dart';
import '../../../models/driver_table_model.dart';
import '../../../models/drivers_mode.dart';
import '../../../widgets/custom_text.dart';

class DriversListTable extends StatefulWidget {
  List<DriversModel>display_list;
  Function()? onPress;
  bool loading = false;
  DriversListTable({Key? key, required this.display_list, required this.loading, required this.onPress}) : super(key: key);

  @override
  State<DriversListTable> createState() => _DriversListTable();
}

class _DriversListTable extends State<DriversListTable> {
  //List<DriversModel>display_list = [];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    double spaceSize(){
      if (ResponsiveWidget.isLargeScreen(context)){
        return _width / 17;
      }else if(ResponsiveWidget.isMediumScreen(context)){
        return _width / 7;
      }

      return _width / 39;
    }

    if (widget.loading) {
      return const SizedBox(
        height: 400,
        width: 400,
        child: LoadingIndicator(
            indicatorType: Indicator.pacman, /// Required, The loading type of the widget
            // colors: const [Colors.white],       /// Optional, The color collections
            strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
            // backgroundColor: Colors.black,      /// Optional, Background of the widget
            // pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
        ),
      );
    } else {
      return SizedBox(
        height: 500,
        width: double.infinity,
        child: Padding(
                padding: ResponsiveWidget.isLargeScreen(context) ? 
                  const EdgeInsets.only(top:10.0, right:40.0,left:40.0, bottom:0.0): 
                  const EdgeInsets.only(top:0.0, right:0.0,left:0.0, bottom:0.0),
                child: SingleChildScrollView(
                  child: PaginatedDataTable(
                    source: DriversTableData(widget.display_list,widget.onPress),
                    columns: const [
                      DataColumn(label: CustomText(text:'Driver Name')),
                      DataColumn(
                        label: Flexible(child: CustomText(text:'Contact Number'))
                      ),
                      DataColumn(label: CustomText(text:'Availability')),
                      DataColumn(label: CustomText(text:'Total Deliveries')),
                      DataColumn(label: CustomText(text:'')),
                  ],
                  //columnSpacing:spaceSize(),
                  horizontalMargin: 10,
                  rowsPerPage: 8,
                  showCheckboxColumn: false,
                )
        ),
      ),
    );
    }
  }
}
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../helpers/responsive_widget.dart';
import '../../../models/delivery_model.dart';
import '../../../models/delivery_table_model.dart';
import '../../../widgets/custom_text.dart';

class DeliveryTable extends StatefulWidget {
  List<DeliveryModel> display_list;
  bool loading = false;
  DeliveryTable({Key? key, required this.display_list, required this.loading})
      : super(key: key);

  @override
  State<DeliveryTable> createState() => _DeliveryTable();
}

class _DeliveryTable extends State<DeliveryTable> {
  //List<DriversModel>display_list = [];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    double spaceSize() {
      if (ResponsiveWidget.isLargeScreen(context)) {
        return _width / 17;
      } else if (ResponsiveWidget.isMediumScreen(context)) {
        return _width / 7;
      }

      return _width / 39;
    }

    if (widget.loading) {
      return const SizedBox(
        height: 400,
        width: 400,
        child: LoadingIndicator(
          indicatorType: Indicator.pacman,

          /// Required, The loading type of the widget
          // colors: const [Colors.white],       /// Optional, The color collections
          strokeWidth: 2,

          /// Optional, The stroke of the line, only applicable to widget which contains line
          // backgroundColor: Colors.black,      /// Optional, Background of the widget
          // pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
        ),
      );
    } else {
      return SizedBox(
        height: 500,
        width: double.infinity,
        child: Padding(
          padding: ResponsiveWidget.isLargeScreen(context)
              ? const EdgeInsets.only(
                  top: 10.0, right: 40.0, left: 40.0, bottom: 0.0)
              : const EdgeInsets.only(
                  top: 0.0, right: 0.0, left: 0.0, bottom: 0.0),
          child: SingleChildScrollView(
              child: PaginatedDataTable(
            source: DeliveryTableData(widget.display_list, context),
            columns: const [
              DataColumn(label: CustomText(text: 'ID')),
              DataColumn(label: Flexible(child: CustomText(text: 'Name'))),
              DataColumn(label: CustomText(text: 'Address')),
              DataColumn(label: CustomText(text: 'Phone')),
              DataColumn(label: 
              CustomText(text: 'Assigned Driver')),
              DataColumn(label: CustomText(text: 'Due Date')),
              DataColumn(label: CustomText(text: '')),
            ],
            //columnSpacing:spaceSize(),
            horizontalMargin: 10,
            rowsPerPage: 8,
            showCheckboxColumn: false,
          )),
        ),
      );
    }
  }
}

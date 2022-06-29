
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';
import '../../controllers/home_controller.dart';
import '../../models/drivers_mode.dart';
import '../../services/database.dart';
import 'widgets/driver_side_panel.dart';
import 'widgets/drivers_list_table.dart';
import 'widgets/drivers_search_bar.dart';

/// * example of stateful widget changing its value when edit is pressed
class DriverSectionPage extends StatefulWidget {
  const DriverSectionPage({Key? key}) : super(key: key);

  @override
  State<DriverSectionPage> createState() => _DrviverSectionPage();
}

class _DrviverSectionPage extends State<DriverSectionPage>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DriversModel> drivers = [];
  List<DriversModel> displayList = [];
  int idx = 0;
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getDrivers().then((value) => 
      setState(() {
        displayList = value;
        drivers = value;
        isDataLoaded = true;
    }));    
  }

  // filter list
  void filterList(String value) {
    setState(() {
      displayList = drivers.where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void startLoading(){
    setState(() {
      isDataLoaded = false;
    });
  }

  void endLoading(){
    setState(() {
      isDataLoaded = true;
    });
  }
  // close drawer update
  void _closeEndDrawer() async {
    var data = await getAllDrivers();

    setState(() {
      drivers =
          List.from(data.docs.map((e) => DriversModel.fromSnapshot(e)));
      displayList = List.from(drivers);
      isDataLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hm = Provider.of<HomeController>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
            child: Column(
          children: [
            topButtons(),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: active.withOpacity(.4), width: .5),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 6),
                      color: lightGrey.withOpacity(.1),
                      blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(
                  top: 30, bottom: 30, left: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 40.0, right: 40.0),
                        child: CustomText(
                          text: "drivers",
                          color: lightGrey,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  // Visibility(
                  //   visible: isDataLoaded,
                  //   child: searchBar()
                  // ),
                  DriversSearchBar(filterList: hm.filterList),
                  DriversListTable(display_list: hm.displayList, onPress: _openEndDrawer,loading: hm.loading),
                  //loadTable(),
                  
                ],
              ),
            ),
          ],
        )),
        endDrawer:DriverSidePanel(idx: idx, closeDriverSidePanel: _openEndDrawer, loading: startLoading, addNewDriver: hm.addDriver),
        endDrawerEnableOpenDragGesture: false,
      ),
    );
  }

  loadWidgets(){
    
  }

  Widget loadingWidget(){
    return const LoadingIndicator(
            indicatorType: Indicator.pacman, /// Required, The loading type of the widget
            colors: [Colors.black, Colors.orange],       /// Optional, The color collections
            strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
            // backgroundColor: Colors.black,      /// Optional, Background of the widget
            // pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
        );
  }
  
  // buttons at the top
  Widget topButtons(){
    return 
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          FloatingActionButton.extended(
            backgroundColor: Colors.orange,
            onPressed: _openEndDrawer,
            label: const CustomText(
              text: "Add new Driver",
              color: Colors.white,
              size: 15),
              icon: const Icon(Icons.add_circle
            )
          ),
          ],
        ),
    );
  }
  // search bar to filter list
  Widget searchBar() {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10, left: 40.0, right: 40.0, bottom: 10),
      child: TextField(
        onChanged: (value) => filterList(value),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xff0E1420),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
            hintText: "eg: Name, Order ID, or Phone number",
            hintStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            prefixIconColor: Colors.white),
      ),
    );
  }

  // Loads table
  Widget loadTable() {
    if (isDataLoaded == false) {
      return const SizedBox(
        height: 400,
        width: 400,
        child: LoadingIndicator(
            indicatorType: Indicator.pacman, /// Required, The loading type of the widget
            colors: [Colors.black, Colors.orange],       /// Optional, The color collections
            strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
            // backgroundColor: Colors.black,      /// Optional, Background of the widget
            // pathBackgroundColor: Colors.black   /// Optional, the stroke backgroundColor
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
          top: 10.0, right: 20.0, left: 20.0, bottom: 10.0),
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          //minWidth: 300,
          columns: const [
            DataColumn2(
              label: Text('Driver Name'),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text('Contact Number'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Availability'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Total deliveries'),
              size: ColumnSize.S,
            ),
            DataColumn2(
                label: Text('Driver Info'),
                size: ColumnSize.S,
                //fixedWidth: 100
            ),
          ],
          rows: List<DataRow>.generate(
            displayList.length,
            (index) => DataRow(cells: [
              DataCell(CustomText(text: displayList[index].name!)),
              DataCell(CustomText(text: displayList[index].phoneNumber!)),
              DataCell(CustomText(text: '${displayList[index].deliveries_assigned}')),
              DataCell(CustomText(text: '${displayList[index].deliveries_completed}')),
              DataCell(FloatingActionButton(
                mini: true,
                onPressed: () {
                  setState(() {
                    idx = index;
                  });
                  _openEndDrawer();
                },
                hoverColor: Colors.amber,
                child: const Icon(
                  Icons.countertops,
                  color: Colors.white,
                  size: 20,
                ),
              ))
            ]),
          )),
    );
  }

  /// open drawer
   void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
}

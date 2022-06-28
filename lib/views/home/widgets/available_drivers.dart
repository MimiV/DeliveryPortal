import 'package:data_table_2/data_table_2.dart';
import 'package:deliveryportal/views/clients/client.dart';
import 'package:deliveryportal/views/home/widgets/Driver_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import '../../../controllers/home_controller.dart';
import '../../../models/drivers_mode.dart';
import '../../../widgets/custom_text.dart';
// import '../drivers/driver.dart';
// import '../drivers/widgets/drivers_table.dart';

/// * example of stateful widget changing its value when edit is pressed
class AvailableDriver extends StatefulWidget {
  //int test_count = 0;
  AvailableDriver({Key? key}) : super(key: key);

  @override
  State<AvailableDriver> createState() => _AvailableDriverState();
}

class _AvailableDriverState extends State<AvailableDriver> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    
  }
  // int test_count = 0;

  // addCount() {
  //   setState(() => test_count += 1);

  //   //print(test_count);
  // }

  // static List<DriversModel> current_drivers = [
  //   DriversModel("0","michael vasconcelos", "email@email.com","232423232",10, 3),
  //   DriversModel("1","Bebe", "email@email.com","2224242323", 7, 2),
  //   DriversModel("2","Luna", "email@email.com","232323233", 8, 4),
  //   DriversModel("3","Iva", "email@email.com","423232423", 9, 1),
  //   DriversModel("4","Michelle", "email@email.com","3242424232", 10, 0),
  // ];

  // // list to be displayed and filtered
  // List<DriversModel> display_list = List.from(current_drivers);

  // void updateList(String value) {
  //   setState(() {
  //     display_list = current_drivers
  //         .where((element) =>
  //             element.name!.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomeController>(context);
    return Container(
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
      margin: const EdgeInsets.only(top:30,bottom: 30,left: 15, right: 15),
      child:
       Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:10, left: 40.0, right: 40.0),
                child: CustomText(
                  text: "Available Drivers",
                  color: lightGrey,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top:10, left: 40.0, right: 40.0, bottom: 10),
            child: TextField(
              onChanged: (value){
                homeController.filterList(value);
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xff0E1420),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none),
                  hintText: "eg: Driver Name",
                  hintStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
                  prefixIcon: const Icon(Icons.search, color: Colors.white,),
                  prefixIconColor: Colors.white),
            ),
          ),

          if(homeController.loading)
            const CircularProgressIndicator()
          else
            ListOfDrivers(display_list: homeController.displayList)
          
        ],
      ),
    );
  }
}

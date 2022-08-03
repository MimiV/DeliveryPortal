import 'package:deliveryportal/constants/controllers.dart';
import 'package:deliveryportal/helpers/responsive_widget.dart';
import 'package:deliveryportal/views/home/widgets/home_cards_large.dart';
import 'package:deliveryportal/views/home/widgets/home_cards_medium.dart';
import 'package:deliveryportal/views/home/widgets/home_cards_small.dart';
import 'package:deliveryportal/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../controllers/delivery_controller.dart';
import '../../controllers/home_controller.dart';
import '../notifications/listTest.dart';
import '../notifications/notifications.dart';
import 'widgets/Driver_list.dart';
import 'widgets/available_drivers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).getAllDrivers();
      Provider.of<DeliveryController>(context, listen: false).getAllDeliveries();
      Provider.of<HomeController>(context, listen: false)
          .getDashBoardAvailabeDrivers(selectedDate,context);
      //Provider.of<DeliveryController>(context, listen:false).getAllDeliveries();
      Provider.of<DeliveryController>(context, listen: false).getCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dc = Provider.of<DeliveryController>(context);
    final hc = Provider.of<HomeController>(context);
    return Column(children: [
      Obx(() => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          )),
      Expanded(
          child: ListView(
        shrinkWrap: true,
        children: [
          if (ResponsiveWidget.isLargeScreen(context) ||
              ResponsiveWidget.isMediumScreen(context))
            if (ResponsiveWidget.isCustomScreen(context))
              HomeCardsMediumScreen(
                  totalDeliveries: dc.getNumberOfDeliveriesByDate(selectedDate),
                  packageDelivered:
                      dc.getNumberOfCompletedDeliveriesByDate(selectedDate))
            else
              Column(
                children: [
                  FloatingActionButton.extended(
                      onPressed: () => _selectDate(context, hc),
                      backgroundColor: Color(0xff0E1420),
                      hoverColor: Colors.orange,
                      isExtended: true,
                      label: CustomText(
                          text: "${selectedDate.toLocal()}".split(' ')[0],
                          color: Colors.white,
                          size: 15),
                      icon: const Icon(Icons.calendar_month)),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: HomeCardsLargeScreen(
                        totalDeliveries:
                            dc.getNumberOfDeliveriesByDate(selectedDate),
                        packageDelivered:
                            dc.getNumberOfCompletedDeliveriesByDate(
                                selectedDate)),
                  ),
                ],
              )
          else
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: HomeCardsSmallScreen(
                      totalDeliveries:
                          dc.getNumberOfDeliveriesByDate(selectedDate),
                      packageDelivered: dc
                          .getNumberOfCompletedDeliveriesByDate(selectedDate)),
                ),
              ],
            ),
          AvailableDriver()
        ],
      ))
    ]);
  }

  _selectDate(BuildContext context, HomeController hc) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        hc.dashboardSelectedDate = selectedDate;
        hc.getDashBoardAvailabeDrivers(selectedDate,context);
      });
    }
  }
}

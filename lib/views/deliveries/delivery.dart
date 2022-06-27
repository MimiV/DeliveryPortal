import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryportal/constants/controllers.dart';
import 'package:deliveryportal/controllers/delivery_controller.dart';
import 'package:deliveryportal/helpers/responsive_widget.dart';
import 'package:deliveryportal/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/delivery_model.dart';
import '../../services/database.dart';
import 'delivery_page.dart';

class DeliveryPage extends StatefulWidget {
  DeliveryPage({Key? key}) : super(key: key);
  static List<DeliveryModel> deliveryList = [];

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  //final Stream<QuerySnapshot> deliveries = FirebaseFirestore.instance.collection("deliveries").snapshots();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<DeliveryController>(context, listen: false).getAllDeliveries();
      //Provider.of<DriverViewModel>(context, listen: false).getDeliveries();
      //loading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    
    return 
    Column(children: [
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
            child: DeliveriesSectionPage()
          ),
    ]);
  }
}

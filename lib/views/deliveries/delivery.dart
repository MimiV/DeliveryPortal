import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryportal/constants/controllers.dart';
import 'package:deliveryportal/helpers/responsive_widget.dart';
import 'package:deliveryportal/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/delivery_model.dart';
import '../../services/database.dart';
import 'delivery_section.dart';

class DeliveryPage extends StatelessWidget {
  DeliveryPage({Key? key}) : super(key: key);
  static List<DeliveryModel> deliveryList = [];
  final Stream<QuerySnapshot> deliveries = FirebaseFirestore.instance.collection("deliveries").snapshots();
  
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
          Container(
            child: StreamBuilder<QuerySnapshot>(stream: deliveries, builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasError){
                return Text("error");
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Text("Loading");
              }

              final data = snapshot.requireData;
              print("ran -- ");
              deliveryList = List.from(data.docs.map((e) => DeliveryModel.fromSnapshot(e)));
              //deliveryList.forEach((element) { print(element.toJson());});
              deliveryUpdatedFalse();
              return Expanded(child: DeliverySection(deliveries: deliveryList));
            }
            )
          )
          // Expanded(child:
          
          //  ),
          
          // Expanded(
          //   child: DeliverySection()
          // ),
    ]);
  }
}

import 'package:deliveryportal/models/delivery_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/style.dart';
import '../../../controllers/delivery_controller.dart';
import '../../../helpers/responsive_widget.dart';
import '../../../widgets/custom_text.dart';

class SidePanel extends StatefulWidget {
  int idx;
  Function()? closeSidePanel;
  SidePanel({Key? key, required this.idx, required this.closeSidePanel}) : super(key: key);

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.width;
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final dueDateController = TextEditingController();
    final itemsController = TextEditingController();
    return SizedBox(
            width: ResponsiveWidget.isSmallScreen(context) ? width / 1.2 : width / 2,
            child: Drawer(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // text field to create a new driver
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children:  [
                          // header for new driver
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: active,
                            ),
                            child: Center(
                              child: CustomText(
                                text: 'Add New Delivery',
                                size: 24,
                                color: dark,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),

                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Customer Name',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              labelText: 'Addres',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: 'Contact Number',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: dueDateController,
                            decoration: InputDecoration(
                              labelText: 'Due Date',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: itemsController,
                            decoration: InputDecoration(
                              labelText: 'Items for delivery',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )

                    ),

                    //Text('This is the Drawer ${widget.idx}'),
                    Row(
                      children: [
                    FloatingActionButton.extended(
                      label: const CustomText(text:'Add Delivery', color: Colors.white,),
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        // add the driver to the database
                        DeliveryModel delivery = DeliveryModel(nameController.text, addressController.text, phoneController.text, dueDateController.text, itemsController.text);
                        Navigator.pop(context);
                        await Provider.of<DeliveryController>(context, listen: false).addDelivery(delivery);
                        //Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton.extended(
                      label: const CustomText(text:'Cancel', color: Colors.white,),
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        // close the drawer
                        //widget.closeDriverSidePanel!();
                      },
                    ),

                    ],)
                    
                  ],
                ),
              ),
            )
          );
  }
}
import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../helpers/responsive_widget.dart';
import '../../../services/database.dart';
import '../../../widgets/custom_text.dart';

class DriverSidePanel extends StatefulWidget {
  int idx;
  Function() loading;
  Function() closeDriverSidePanel;
  Function(String, String, String) addNewDriver;
  DriverSidePanel({Key? key, required this.idx, required this.closeDriverSidePanel, required this.loading, required this.addNewDriver}) : super(key: key);

  @override
  State<DriverSidePanel> createState() => _DriverSidePanelState();
}

class _DriverSidePanelState extends State<DriverSidePanel> {
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // text controller for the text field
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

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
                                text: 'Add New Driver',
                                size: 24,
                                color: dark,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ),

                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Driver Name',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              labelText: 'Driver Phone Number',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Driver Email',
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
                      label: const CustomText(text:'Add Driver', color: Colors.white,),
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        // add the driver to the database
                        widget.loading();
                        Navigator.pop(context);
                        await widget.addNewDriver(nameController.text,emailController.text, phoneController.text);

                        // widget.loading!();
                        // registerDriver(nameController.text,emailController.text, phoneController.text).then((value) => 
                          
                        // );
                       // widget.closeDriverSidePanel!();
                      },
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton.extended(
                      label: const CustomText(text:'Cancel', color: Colors.white,),
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        // close the drawer
                        widget.closeDriverSidePanel();
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
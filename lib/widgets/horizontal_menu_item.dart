import 'package:deliveryportal/constants/controllers.dart';
import 'package:deliveryportal/constants/style.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  const HorizontalMenuItem({ Key? key, required this.itemName, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onTap,
      onHover: (value) { 
        value ? menuController.onHover(itemName) : menuController.onHover("not hovering"); 
      },
      child: Obx(
        () => Container(
          color: menuController.isHovering(itemName) ? active : Colors.transparent,
          child: Row(
            children: [
              Visibility(
                visible: menuController.isHovering(itemName) || menuController.isActive(itemName),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  width: 3,
                  height: 40,
                  color: active,
                ),
              ),
              SizedBox(width: _width / 200),
              Padding(
                padding: const EdgeInsets.all(10),
                child: menuController.returnIconFor(itemName),
              ),
              
              if (!menuController.isActive(itemName))
                Flexible(
                  child: CustomText(
                  text: itemName,
                  color: menuController.isHovering(itemName) ? light : lightGrey,
                  )
                )
              else
                Flexible(
                  child: CustomText(
                    text: itemName,
                    color: Colors.white,
                    size: 15,
                    weight: FontWeight.bold,
                  )
                )
                  ],
          ),
        )
      )
    );
  }
}

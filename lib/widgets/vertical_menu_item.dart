import 'package:deliveryportal/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/controllers.dart';
import 'custom_text.dart';

class VerticalMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;
  const VerticalMenuItem({Key? key, required this.itemName, required this.onTap}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) { value ? menuController.onHover(itemName) : menuController.onHover("not hovering"); },
      child: Obx(
        () => Container(
          color: menuController.isHovering(itemName)? active : Colors.transparent,
          child: Row(
            children: [
              Visibility(
                visible: menuController.isHovering(itemName) || menuController.isActive(itemName),
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  width: 3,
                  height: 72,
                  color: active,
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: menuController.returnIconFor(itemName),
                      ),
                      if (!menuController.isActive(itemName))
                        Flexible(
                          child: CustomText(
                            text: itemName,
                            color: menuController.isHovering(itemName) ? Colors.white : Colors.white,
                          )
                        )
                      else
                        Flexible(
                          child: CustomText(
                            text: itemName,
                            color: Colors.white,
                            size: 10,
                            weight: FontWeight.bold,
                          )
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}

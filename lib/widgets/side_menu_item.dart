import 'package:deliveryportal/widgets/horizontal_menu_item.dart';
import 'package:deliveryportal/widgets/vertical_menu_item.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../helpers/responsive_widget.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final void Function() onTap;

  const SideMenuItem({ Key? key,required this.itemName,required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(ResponsiveWidget.isCustomScreen(context)){
      return VerticalMenuItem(itemName: itemName, onTap: onTap,);
    }else{
      return HorizontalMenuItem(itemName: itemName, onTap: onTap,);
    }
  }
}

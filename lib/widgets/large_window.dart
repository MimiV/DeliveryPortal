import 'package:deliveryportal/helpers/local_navigator.dart';
import 'package:flutter/material.dart';
import 'side_menu.dart';
// testing stuff
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class LargeWindow extends StatelessWidget {
  const LargeWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      // we break the layout into 6 differet columns
        const Expanded(
          child: SideMenu()
        ),
        Expanded(
            flex: 5, // this takes 5 columns
            child: localNavigator()
        )
      ]
    );
  }
}

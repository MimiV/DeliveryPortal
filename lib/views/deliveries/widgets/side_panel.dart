import 'package:flutter/material.dart';

import '../../../helpers/responsive_widget.dart';

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
    return Container(
            width: ResponsiveWidget.isSmallScreen(context) ? _width / 1.2 : _width / 2,
            child: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('This is the Drawer ${widget.idx}'),
                  ElevatedButton(
                    onPressed: widget.closeSidePanel,
                    child: const Text('Close Drawer'),
                  ),
                ],
              ),
            )
          );
  }
}
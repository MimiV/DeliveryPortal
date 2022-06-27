import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widgets/custom_text.dart';

class InfoCardSmall extends StatefulWidget {
  final String title;
  final String value;
  final bool isActive;
  final void Function() onTap;

  const InfoCardSmall(
      {Key? key,
      required this.title,
      required this.value,
      this.isActive = false,
      required this.onTap})
      : super(key: key);

  @override
  State<InfoCardSmall> createState() => _InfoCardSmallState();
}

class _InfoCardSmallState extends State<InfoCardSmall> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: widget.isActive ? active : lightGrey, width: .5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: widget.title,
                  size: 24,
                  weight: FontWeight.w300,
                  color: widget.isActive ? active : lightGrey,
                ),
                CustomText(
                  text: widget.value,
                  size: 24,
                  weight: FontWeight.bold,
                  color: widget.isActive ? active : dark,
                )
              ],
            )),
      ),
    );
  }
}

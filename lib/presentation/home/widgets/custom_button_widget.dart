import 'package:flutter/material.dart';
import 'package:netflix_project/core/colors/colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final double fontsize;
  final double iconsize;
  const CustomButtonWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.fontsize = 18,
    this.iconsize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kWhiteColor,
          size: iconsize,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

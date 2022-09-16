import 'dart:math';

import 'package:flutter/material.dart';
import 'package:netflix_project/core/colors/colors.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/widgets/app_bar_widget.dart';

class ScreenDownload extends StatelessWidget {
  ScreenDownload({Key? key}) : super(key: key);
  final List imageList = [
    "https://www.themoviedb.org/t/p/w440_and_h660_face/wE0I6efAW4cDDmZQWtwZMOW44EJ.jpg",
    "https://www.themoviedb.org/t/p/w440_and_h660_face/g8sclIV4gj1TZqUpnL82hKOTK3B.jpg",
    "https://www.themoviedb.org/t/p/w440_and_h660_face/sKCr78MXSLixwmZ8DyJLrpMsd15.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarWidget(
            title: "Downloads",
          )),
      body: ListView(children: [
        Row(
          children: const [
            kwidth,
            Icon(
              Icons.settings,
              color: kWhiteColor,
            ),
            kwidth,
            Text('Smart Downloads '),
          ],
        ),
        const Text("Introducing Downloads for you "),
        Text(
            "We'll download a personalised selection of  movies and shows for you, so there's always something to watch on your   device."),
        Container(
          width: size.width,
          height: size.width,
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                radius: size.width * 0.37,
              ),
              DwonloadsImageWidget(
                imageList: imageList[0],
                margin: EdgeInsets.only(left: 210),
                angle: 15,
              ),
              DwonloadsImageWidget(
                imageList: imageList[1],
                margin: EdgeInsets.only(right: 210),
                angle: -15,
              ),
              DwonloadsImageWidget(
                imageList: imageList[2],
                margin: EdgeInsets.only(left: 0),
              ),
            ],
          ),
        ),
        MaterialButton(
          color: kButtonColorBlue,
          onPressed: (() {}),
          child: const Text(
            'Set up',
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        MaterialButton(
          color: kButtonColorWhite,
          onPressed: (() {}),
          child: const Text(
            "See what you can download",
            style: TextStyle(
              color: kBlackColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}

class DwonloadsImageWidget extends StatelessWidget {
  const DwonloadsImageWidget(
      {Key? key, required this.imageList, this.angle = 0, required this.margin})
      : super(key: key);

  final String imageList;
  final double angle;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: size.width * 0.4,
        height: size.width * 0.58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(
              imageList,
            ),
          ),
        ),
      ),
    );
  }
}

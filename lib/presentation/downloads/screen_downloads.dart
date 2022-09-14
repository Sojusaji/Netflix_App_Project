import 'package:flutter/material.dart';
import 'package:netflix_project/core/colors/colors.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/widgets/app_bar_widget.dart';

class ScreenDownload extends StatelessWidget {
  const ScreenDownload({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBarWidget(
              title: "Downloads",
            )),
        body: ListView(
          children: [
            Row(
              children: const [
                kwidth,
                Icon(
                  Icons.settings,
                  color: kwhiteColor,
                ),
                kwidth,
                Text('Smart Downloads '),
              ],
            ),
            const Text("Introducing Downloads for you"),
          ],
        ));
  }
}

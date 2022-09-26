import 'package:flutter/material.dart';
import 'package:netflix_project/core/colors.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_project/presentation/new_and_hot/widgets/video_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  const EveryonesWatchingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
        const Text(
          "Friends",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight,
        const Text(
          "This hit sitcom follows the merry misadventures of six 20-something pals as they navigatethe pitfalls of work, life and love in 1998s Manhattam.",
          style: TextStyle(color: kGreyColor),
        ),
        kHeight50,
        const VideoWidget(),
        kHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CustomButtonWidget(
              icon: Icons.share,
              title: 'Share',
              fontsize: 16,
              iconsize: 25,
            ),
            kwidth,
            CustomButtonWidget(
              icon: Icons.add,
              title: 'My List',
              fontsize: 16,
              iconsize: 25,
            ),
            kwidth,
            CustomButtonWidget(
              icon: Icons.play_arrow,
              title: 'Play',
              fontsize: 16,
              iconsize: 25,
            ),
            kwidth,
          ],
        )
      ],
    );
  }
}

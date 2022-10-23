import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/home/widgets/background_card.dart';
import 'package:netflix_project/presentation/home/widgets/number_title_card.dart';
import '../widgets/main_title_card.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: scrollNotifier,
        builder: ((BuildContext context, index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              print(direction);
              if (direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else {
                direction == ScrollDirection.forward;
                scrollNotifier.value = true;
              }
              return true;
            },
            child: Stack(
              children: [
                ListView(
                  children: const [
                    BackgroundCard(),
                    MainTitleCard(
                      title: 'Released in the Past Year',
                    ),
                    kHeight,
                    MainTitleCard(
                      title: 'Trending Now',
                    ),
                    kHeight,
                    NumberTitleCard(),
                    kHeight,
                    MainTitleCard(
                      title: 'Tense Dramas',
                    ),
                    kHeight,
                    MainTitleCard(
                      title: 'South Indian Cinema',
                    ),
                    kHeight,
                  ],
                ),
                scrollNotifier.value == true
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 1000),
                        width: double.infinity,
                        height: 90,
                        color: Colors.black.withOpacity(0.3),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "asset/netflixlogo.png",
                                  width: 60,
                                  height: 60,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.cast,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                kwidth,
                                Container(
                                  width: 30,
                                  height: 30,
                                  color: Colors.blue,
                                ),
                                kwidth,
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "TV Shows",
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  "Movies",
                                  style: kHomeTitleText,
                                ),
                                Text(
                                  "Categories",
                                  style: kHomeTitleText,
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    : kHeight
              ],
            ),
          );
        }),
      ),
    );
  }
}

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
                        duration: Duration(milliseconds: 1000),
                        width: double.infinity,
                        height: 90,
                        color: Colors.black.withOpacity(0.3),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Image(
                                  image: NetworkImage(
                                      "https://th.bing.com/th/id/R.d8f3c5ce449fd32fbe0fcfac58bd591a?rik=xEh2gQ1%2bQZX2hg&riu=http%3a%2f%2fcasting.flashmode.tn%2fwp-content%2fuploads%2f2018%2f05%2fnetflix.png&ehk=ChVtOp91gm31SePW24SWT5W4WSuZzWyV1FEk7fUXdn4%3d&risl=&pid=ImgRaw&r=0 "),
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

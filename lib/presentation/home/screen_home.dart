import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/application/home/home_bloc.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/home/widgets/background_card.dart';
import 'package:netflix_project/presentation/home/widgets/number_title_card.dart';
import '../widgets/main_title_card.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
      },
    );
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
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            );
                          } else if (state.hasError) {
                            return const Center(
                              child: Text(
                                "Error while getting data",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          //realsed past year

                          final releasedPastYear = state.patYearMovieList.map(
                            (m) {
                              return '$imageAppendUrl${m.posterPath}';
                            },
                          ).toList();

                          //trending
                          final trendingNow = state.trendingMovieList.map(
                            (m) {
                              return '$imageAppendUrl${m.posterPath}';
                            },
                          ).toList();

                          //tense dramas
                          final tenseDramas = state.tenseDramasMovieList.map(
                            (m) {
                              return '$imageAppendUrl${m.backdropPath}';
                            },
                          ).toList();

                          //south indian cinema

                          final southIndianCinema =
                              state.southIndianMovieList.map(
                            (m) {
                              return '$imageAppendUrl${m.backdroPath}';
                            },
                          ).toList();

                          final top10MovieList = state.trendingTvList.map(
                            (m) {
                              return '$imageAppendUrl${m.backdropPath}';
                            },
                          ).toList();

                          return ListView(
                            children: [
                              const BackgroundCard(),
                              MainTitleCard(
                                title: 'Released in the Past Year',
                                posterList: releasedPastYear,
                              ),
                              kHeight,
                              MainTitleCard(
                                title: 'Trending Now',
                                posterList: trendingNow,
                              ),
                              kHeight,
                              NumberTitleCard(
                                posterPath: top10MovieList,
                              ),
                              kHeight,
                              MainTitleCard(
                                title: 'Tense Dramas',
                                posterList: tenseDramas,
                              ),
                              kHeight,
                              MainTitleCard(
                                title: 'South Indian Cinema',
                                posterList: southIndianCinema,
                              ),
                              kHeight,
                            ],
                          );
                        },
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                  ));
            })));
  }
}

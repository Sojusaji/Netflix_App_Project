import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:netflix_project/application/new_and_hot/new_and_hot_bloc.dart';
import 'package:netflix_project/core/colors.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_project/presentation/new_and_hot/widgets/everyones_watching.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<NewAndHotBloc>(context)
            .add(const LoadDataInComingSoon());
        BlocProvider.of<NewAndHotBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
    );
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: AppBar(
              title: Text("New & Hot",
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  )),
              actions: [
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
              ],
              bottom: TabBar(
                  labelColor: kBlackColor,
                  isScrollable: true,
                  unselectedLabelColor: kWhiteColor,
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  indicator: BoxDecoration(
                      color: kWhiteColor, borderRadius: kRadius30),
                  tabs: const [
                    Tab(
                      text: "🍿 Coming Soon",
                    ),
                    Tab(
                      text: "👀 Everyone's watching",
                    )
                  ]),
            ),
          ),
          body: const TabBarView(
            children: [
              BuildCommingSoon(
                key: Key('commig soon'),
              ),
              BuildEveryOnesWatching(
                key: Key('everyoneswatching'),
              )
            ],
          )),
    );
  }
}

class BuildCommingSoon extends StatelessWidget {
  const BuildCommingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<NewAndHotBloc>(context)
            .add(const LoadDataInComingSoon());
      },
    );
    return BlocBuilder<NewAndHotBloc, NewAndHotState>(
        builder: (context, state) {
      if (state.isLoading) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      } else if (state.hasError) {
        return const Text(" Error while loading coming soon list");
      } else {
        return ListView.builder(
            itemCount: state.comingSoonList.length,
            itemBuilder: ((context, index) {
              final movie = state.comingSoonList[index];
              if (movie.id == null) {
                return const SizedBox();
              }
              String month = '';
              String date = '';
              try {
                final _date = DateTime.tryParse(movie.releaseDate!);
                final formatedDate = DateFormat.yMMMMd('en_us').format(_date!);
                month =
                    formatedDate.split(' ').first.substring(0, 3).toUpperCase();
                date = movie.releaseDate!.split('-')[2];
              } catch (_) {
                month = '';
                date = '';
              }
              return ComingSoonWidget(
                id: movie.id.toString(),
                month: month,
                day: date,
                posterPath: '$imageAppendUrl${movie.posterPath}',
                movieName: movie.originalTitle ?? 'No title ',
                description: movie.overview ?? 'No description ',
              );
            }));
      }
    });
  }
}

class BuildEveryOnesWatching extends StatelessWidget {
  const BuildEveryOnesWatching({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        BlocProvider.of<NewAndHotBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
    );
    return BlocBuilder<NewAndHotBloc, NewAndHotState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else if (state.hasError) {
          return const Text("Error while loading everyoneswatching list");
        } else {
          return ListView.builder(
              padding: const EdgeInsets.all(9),
              itemCount: state.everyoneIsWatchingList.length,
              itemBuilder: ((context, index) {
                final tv = state.everyoneIsWatchingList[index];
                return EveryonesWatchingWidget(
                    posterPath: "$imageAppendUrl${tv.posterPath}",
                    movieName: tv.originalName ?? 'No title',
                    description: tv.overview ?? 'No description');
              }));
        }
      },
    );
  }
}

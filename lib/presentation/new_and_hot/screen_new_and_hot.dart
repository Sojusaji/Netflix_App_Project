import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_project/core/colors.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_project/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_project/presentation/new_and_hot/widgets/everyones_watching.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          body: TabBarView(
            children: [
              _buildComingSoon(),
              _buildEveryonesWatching(),
            ],
          )),
    );
  }

  Widget _buildComingSoon() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) => const ComingSoonWidget()));
  }

  Widget _buildEveryonesWatching() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) => const EveryonesWatchingWidget()));
  }
}

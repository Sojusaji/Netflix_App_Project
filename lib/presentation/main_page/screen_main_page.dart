import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix_project/core/colors.dart';
import 'package:netflix_project/presentation/downloads/screen_downloads.dart';
import 'package:netflix_project/presentation/fast_laugh/screenfastlaugh.dart';
import 'package:netflix_project/presentation/home/screen_home.dart';
import 'package:netflix_project/presentation/main_page/widgets/bottom_nav.dart';
import 'package:netflix_project/presentation/new_and_hot/screen_new_and_hot.dart';
import 'package:netflix_project/presentation/search/screen_search.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({Key? key}) : super(key: key);
  final _pages = [
    ScreenHome(),
    ScreenNewAndHot(),
    ScreenFastLaugh(),
    ScreenSearch(),
    ScreenDownload(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: indexChangeNotifier,
            builder: ((context, int index, child) {
              return _pages[index];
            })),
      ),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}

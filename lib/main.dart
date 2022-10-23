import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/application/downloads/downloads_bloc.dart';
import 'package:netflix_project/application/fast_laugh/fast_laugh_bloc.dart';

import 'package:netflix_project/core/colors.dart';
import 'package:netflix_project/domain/core/di/injectable.dart';

import 'package:netflix_project/presentation/main_page/screen_main_page.dart';

import 'application/search/search_bloc.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => getIt<DownloadsBloc>()),
        BlocProvider(create: (ctx) => getIt<SearchBloc>()),
        BlocProvider(create: (ctx) => getIt<FastLaughBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          primarySwatch: Colors.blue,
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: backgroundColor,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        home: ScreenMainPage(),
      ),
    );
  }
}

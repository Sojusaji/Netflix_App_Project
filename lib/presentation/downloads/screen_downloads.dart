import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/application/downloads/downloads_bloc.dart';

import 'package:netflix_project/core/colors.dart';
import 'package:netflix_project/core/constants.dart';

import 'package:netflix_project/presentation/widgets/app_bar_widget.dart';

class ScreenDownload extends StatelessWidget {
  const ScreenDownload({Key? key}) : super(key: key);

  final _widgetList = const [
    _SmartDownloads(),
    Section2(),
    Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarWidget(
            title: "Downloads",
          )),
      body: Builder(builder: (context) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) => _widgetList[index],
          separatorBuilder: (context, index) => const SizedBox(
            height: 25,
          ),
          itemCount: _widgetList.length,
        );
      }),
    );
  }
}

class Section2 extends StatelessWidget {
  const Section2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    final Size size = MediaQuery.of(context).size;

    return Column(children: [
      const Text(
        "Introducing Downloads for You ",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kWhiteColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      kHeight,
      const Text(
        "We'll download a personalised selection of\nmovies and shows for you, so there'S\nalways something to watch on your\ndevice.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
      kHeight,
      BlocBuilder<DownloadsBloc, DownloadsState>(builder: (context, state) {
        if (state.downloads.isNotEmpty) {
          return SizedBox(
            width: size.width,
            height: size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: size.width * 0.4,
                  backgroundColor: Colors.grey.withOpacity(0.5),
                ),
                DwonloadsImageWidget(
                  imageList: '$imageAppendUrl${state.downloads[0].posterPath}',
                  margin: const EdgeInsets.only(
                    left: 165,
                  ),
                  angle: 20,
                  size: Size(size.width * 0.5, size.width * 0.60),
                ),
                DwonloadsImageWidget(
                  imageList: '$imageAppendUrl${state.downloads[1].posterPath}',
                  margin: const EdgeInsets.only(
                    right: 165,
                  ),
                  angle: -20,
                  size: Size(size.width * 0.5, size.width * 0.60),
                ),
                DwonloadsImageWidget(
                  imageList: '$imageAppendUrl${state.downloads[2].posterPath}',
                  radius: 20,
                  margin: const EdgeInsets.only(bottom: 20),
                  size: Size(size.width * 0.6, size.width * 0.65),
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      })
    ]);
  }
}

class Section3 extends StatelessWidget {
  const Section3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            color: kButtonColorBlue,
            onPressed: (() {}),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Set up',
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        kHeight,
        MaterialButton(
          color: kButtonColorWhite,
          onPressed: (() {}),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "See what you can download",
              style: TextStyle(
                color: kBlackColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  const _SmartDownloads({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kwidth,
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kwidth,
        Text('Smart Downloads '),
      ],
    );
  }
}

class DwonloadsImageWidget extends StatelessWidget {
  const DwonloadsImageWidget({
    Key? key,
    required this.imageList,
    this.angle = 0,
    required this.margin,
    required this.size,
    this.radius = 10,
  }) : super(key: key);

  final String imageList;
  final double angle;
  final EdgeInsets margin;
  final Size size;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: size.width,
            height: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  imageList,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:netflix_project/core/colors/colors.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/search/widgets/title.dart';

const imageUrl =
    'https://www.themoviedb.org/t/p/w500_and_h282_face/qadgqPjHWyI2RHSnTrL7liLxeLf.jpg';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: ((context, index) => const TopSearchItemTitle()),
            separatorBuilder: ((context, index) => kHeight20),
            itemCount: 10,
          ),
        )
      ],
    );
  }
}

class TopSearchItemTitle extends StatelessWidget {
  const TopSearchItemTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 65,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        const Expanded(
          child: Text(
            'Movie Name',
            style: TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const CircleAvatar(
          backgroundColor: kWhiteColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: kBlackColor,
            radius: 23,
            child: Icon(
              CupertinoIcons.play_fill,
              color: kWhiteColor,
            ),
          ),
        )
      ],
    );
  }
}

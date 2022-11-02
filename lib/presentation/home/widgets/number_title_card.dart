import 'package:flutter/material.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/home/widgets/number_card.dart';

import '../../widgets/main_title.dart';

class NumberTitleCard extends StatelessWidget {
  final List<String> posterPath;
  const NumberTitleCard({
    Key? key,
    required this.posterPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitle(title: "Top 10 TV Shows in India Today"),
        kHeight,
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
                posterPath.length,
                ((index) => NumberCard(
                      index: index,
                      mainImage: posterPath[index],
                    ))),
          ),
        )
      ],
    );
  }
}

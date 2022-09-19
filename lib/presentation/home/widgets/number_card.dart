import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_project/core/constants.dart';

class NumberCard extends StatelessWidget {
  final int index;
  const NumberCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
              height: 150,
            ),
            Container(
                width: 130,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: kRadius10,
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://www.themoviedb.org/t/p/w440_and_h660_face/sKCr78MXSLixwmZ8DyJLrpMsd15.jpg",
                    ),
                  ),
                ))
          ],
        ),
        Positioned(
          left: 12,
          top: 85,
          child: BorderedText(
            strokeWidth: 10,
            strokeColor: Colors.black,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                  fontSize: 120,
                  decoration: TextDecoration.none,
                  decorationColor: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

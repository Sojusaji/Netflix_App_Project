import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/application/search/search_bloc.dart';

import 'package:netflix_project/core/colors.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/presentation/search/widgets/title.dart';

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
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text("Error while getting data"),
                );
              } /* else if (state.idleList.isEmpty) {
                return const Center(
                  child: Text("List is empty"),
                );
              }*/
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: ((context, index) {
                  final movie = state.idleList[index];
                  return TopSearchItemTitle(
                    title: movie.title ?? 'No title provided',
                    imageUrl: '$imageAppendUrl${movie.posterPath}',
                  );
                }),
                separatorBuilder: ((context, index) => kHeight20),
                itemCount: state.idleList.length,
              );
            },
          ),
        )
      ],
    );
  }
}

class TopSearchItemTitle extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTitle({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 65,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_project/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_project/core/colors.dart';
import 'package:netflix_project/core/constants.dart';
import 'package:netflix_project/domain/downloads/models/downloads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget({
    Key? key,
    required this.widget,
    required this.movieData,
  }) : super(key: key, child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatefulWidget {
  final int index;
  final videoUrl;
  const VideoListItem({
    Key? key,
    required this.index,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  late VideoPlayerController _videoPlayerController;
  bool audioController = true;
  bool videoPlayerControllerValue = true;
  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: _videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController))
              : const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //left side

                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  radius: 30,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (audioController == true) {
                          _videoPlayerController.setVolume(0.0);
                          audioController = false;
                        } else {
                          _videoPlayerController.setVolume(1.0);
                          audioController = true;
                        }
                      });
                    },
                    icon: audioController == true &&
                            videoPlayerControllerValue == true
                        ? const Icon(
                            Icons.volume_up,
                            color: kWhiteColor,
                            size: 30,
                          )
                        : const Icon(
                            Icons.volume_off,
                            color: kWhiteColor,
                            size: 30,
                          ),
                  ),
                ),
                //right side
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CircleAvatar(
                            radius: 30,
                            backgroundImage: posterPath == null
                                ? null
                                : NetworkImage('$imageAppendUrl$posterPath'))),
                    ValueListenableBuilder(
                      valueListenable: likedVideosIdsNotifier,
                      builder: (BuildContext c, Set<int> newLikedListIds,
                          Widget? _) {
                        final _index = widget.index;
                        if (newLikedListIds.contains(_index)) {
                          return GestureDetector(
                            onTap: () {
                              likedVideosIdsNotifier.value.remove(_index);
                              likedVideosIdsNotifier.notifyListeners();
                            },
                            child: const VideoActionWidget(
                              icon: Icons.favorite_outline,
                              title: 'Liked',
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            likedVideosIdsNotifier.value.add(_index);
                            likedVideosIdsNotifier.notifyListeners();
                          },
                          child: const VideoActionWidget(
                            icon: Icons.emoji_emotions,
                            title: 'LOL',
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable: myListVideoIdNotifier,
                        builder: (BuildContext myListContext, Set<int> myListId,
                            Widget? _) {
                          final myListIndex = widget.index;
                          if (myListId.contains(myListIndex)) {
                            return GestureDetector(
                              onTap: () {
                                myListVideoIdNotifier.value.remove(myListIndex);
                                myListVideoIdNotifier.notifyListeners();
                              },
                              child: const VideoActionWidget(
                                  icon: Icons.check_circle_outline_rounded,
                                  title: 'Added'),
                            );
                          }
                          return GestureDetector(
                            onTap: () {
                              myListVideoIdNotifier.value.add(myListIndex);
                              myListVideoIdNotifier.notifyListeners();
                            },
                            child: const VideoActionWidget(
                                icon: Icons.add, title: 'MyList'),
                          );
                        }),
                    GestureDetector(
                        onTap: () {
                          log('Share clicked');
                          final movieName =
                              VideoListItemInheritedWidget.of(context)
                                  ?.movieData
                                  .posterPath;
                          log(movieName.toString());
                          if (movieName != null) {
                            Share.share(movieName);
                          }
                        },
                        child: const VideoActionWidget(
                            icon: Icons.share, title: 'Share')),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_videoPlayerController.value.isPlaying) {
                              _videoPlayerController.pause();
                              videoPlayerControllerValue = false;
                            } else {
                              _videoPlayerController.play();
                              videoPlayerControllerValue = true;
                            }
                          });
                        },
                        child: _videoPlayerController.value.isPlaying
                            ? const VideoActionWidget(
                                icon: Icons.play_arrow, title: 'Playing')
                            : const VideoActionWidget(
                                icon: Icons.pause, title: 'Paused')),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }
}

class VideoActionWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  const VideoActionWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          Text(
            title,
            style: const TextStyle(color: kWhiteColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

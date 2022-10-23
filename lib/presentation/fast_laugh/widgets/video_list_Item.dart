import 'dart:async';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
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

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    return Stack(
      children: [
        FastLaughVideoPlayer(
          videoUrl: videoUrl,
          onStateChanged: (bool isPlaying) {},
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
                    onPressed: () {},
                    icon: const Icon(
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
                        final _index = index;
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
                    const VideoActionWidget(icon: Icons.add, title: 'My List'),
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

                    // VedioPlayAndPauseButton(videoPlayerController: );
                    /*const VideoActionWidget(
                        icon: Icons.play_arrow, title: 'Play'),*/
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
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

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.onStateChanged,
  });

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });
    VedioPlayAndPauseButton(videoPlayerController: _videoPlayerController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController))
          : const Center(
              child: CircularProgressIndicator(
              strokeWidth: 2,
            )),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}

class VedioPlayAndPauseButton extends StatelessWidget {
  const VedioPlayAndPauseButton({
    Key? key,
    required VideoPlayerController videoPlayerController,
  })  : _videoPlayerController = videoPlayerController,
        super(key: key);

  final VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          _videoPlayerController.value.isPlaying
              ? _videoPlayerController.pause()
              : _videoPlayerController.play();
        },
        child: _videoPlayerController.value.isPlaying
            ? const Icon(Icons.play_arrow)
            : const Icon(Icons.pause));
  }
}

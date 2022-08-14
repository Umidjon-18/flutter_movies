import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/youtube_view_model.dart';
import 'package:fluttery_filmy/views/connection_error_view.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeView extends StatefulWidget {
  const YoutubeView({required this.movieId, required this.movieName, Key? key})
      : super(key: key);
  final String movieId;
  final String movieName;

  @override
  State<YoutubeView> createState() => _YoutubeViewState();
}

class _YoutubeViewState extends State<YoutubeView> {
  late String videoTitle;
  // Url List
  final List<String> _videoUrlList = [
    'https://youtu.be/dWs3dzj4Wng',
    'https://www.youtube.com/watch?v=668nUCeBHyY',
    'https://youtu.be/S3npWREXr8s',
    'https://youtu.be/S3npWREXr8s',
    'https://youtu.be/S3npWREXr8s',
    'https://youtu.be/S3npWREXr8s',
  ];

  List<YoutubePlayerController> lYTC = [];

  Map<String, dynamic> cStates = {};

  // late YoutubeViewModel youtubeViewModel = YoutubeViewModel();

  @override
  void initState() {
    super.initState();
    // youtubeViewModel.uploadYoutubeVideos(widget.movieId);
    // print(youtubeViewModel.youtubeVideoLinks);
    fillYTlists();
  }

  fillYTlists() {
    for (var element in _videoUrlList) {
      String id = YoutubePlayer.convertUrlToId(element)!;
      YoutubePlayerController ytController = YoutubePlayerController(
        initialVideoId: id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: true,
          captionLanguage: 'en',
        ),
      );

      ytController.addListener(() {
        if (cStates[id] != ytController.value.isPlaying) {
          if (mounted) {
            setState(() {
              cStates[id] = ytController.value.isPlaying;
            });
          }
        }
      });

      lYTC.add(ytController);
    }
  }

  @override
  void dispose() {
    for (var element in lYTC) {
      element.dispose();
    }
    // youtubeViewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<YoutubeViewModel>(
      builder: (context, youtubeViewModel, child) {
        if (youtubeViewModel.state == YoutubeState.init) {
          Future.delayed(Duration.zero, () {
            youtubeViewModel.uploadYoutubeVideos(widget.movieId);
            youtubeViewModel.update();
          });
            print(youtubeViewModel.youtubeVideoLinks);
        }
        switch (youtubeViewModel.state) {
          case YoutubeState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case YoutubeState.error:
            return ConnectionErrorView(
              pageIndex: 4,
              movieId: widget.movieId,
            );
          case YoutubeState.done:
            return Scaffold(
              appBar: AppBar(
                title: const Text('Tubeloid'),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu_outlined),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: _videoUrlList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    YoutubePlayerController ytController = lYTC[index];
                    String id =
                        YoutubePlayer.convertUrlToId(_videoUrlList[index])!;
                    String curState = 'undefined';
                    if (cStates[id] != null) {
                      curState = cStates[id] ? 'playing' : 'paused';
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 220.0,
                            decoration: const BoxDecoration(
                              color: Color(0xfff5f5f5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: YoutubePlayer(
                                controller: ytController,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.lightBlueAccent,
                                bottomActions: [
                                  CurrentPosition(),
                                  ProgressBar(isExpanded: true),
                                  FullScreenButton(),
                                ],
                                onReady: () {},
                                onEnded: (YoutubeMetaData _md) {
                                  ytController
                                      .seekTo(const Duration(seconds: 0));
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              curState,
                              textScaleFactor: 1.5,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          default:
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

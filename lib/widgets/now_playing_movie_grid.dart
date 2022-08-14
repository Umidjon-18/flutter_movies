import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttery_filmy/models/now_playing_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes.dart';
import '../view_models/now_playing_view_model.dart';

class NowPlayingGrid extends StatefulWidget {
  final List<NowPlayingMovieModel> moviesList;

  const NowPlayingGrid(
      {required this.moviesList, required this.nowPlayingViewModel, Key? key})
      : super(key: key);
  final NowPlayingViewModel nowPlayingViewModel;
  @override
  State<NowPlayingGrid> createState() => _NowPlayingGridState();
}

class _NowPlayingGridState extends State<NowPlayingGrid> {
  late ScrollController scrollController;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels.truncate() > -100) {
    //     print('swiped to down');
    //     widget.nowPlayingViewModel.update();
    //     // nowPlayingViewModel.uploadMovies();
    //   }
    // });
//     double lastEndOfScroll = 0;

// scrollController.addListener(() {
//   double maxScroll = scrollController.position.;
//   double currentScroll = scrollController.position.pixels;
//   if (maxScroll == currentScroll) {
//       lastEndOfScroll = maxScroll;
//       print('swiped to down');
//     }
// });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NowPlayingViewModel>(
      builder: (BuildContext context, value, Widget? child) {
        return NotificationListener<ScrollUpdateNotification>(
          onNotification: (notification) {
            print(notification);
            return true;
          },
          child: GridView.builder(
            controller: scrollController,
            itemCount: widget.moviesList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 2
                      : 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (BuildContext _, int index) {
              final movie = widget.moviesList[index];

              return GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  Routes.detailPage,
                  arguments: {'movieId': movie.id.toString()},
                ),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black38,
                                Colors.black38,
                              ],
                            ),
                          ),
                          child: Center(
                              child: Text(
                            movie.originalTitle ?? "Undefined",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

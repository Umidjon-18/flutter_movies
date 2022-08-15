import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer<NowPlayingViewModel>(
      builder: (BuildContext context, nowPlayingViewModel, Widget? child) {
        return RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.white,
          strokeWidth: 0,
          onRefresh: () async {
            nowPlayingViewModel.uploadMovies();
          },
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: widget.moviesList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 2
                      : 4,
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
                    Hero(
                      tag: movie.id.toString(),
                      child: CachedNetworkImage(
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
                        errorWidget: (context, url, error) => const Image(
                          image: AssetImage('assets/images/placeholder.jpeg'),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 60,
                          padding: const EdgeInsets.all(5),
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
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
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

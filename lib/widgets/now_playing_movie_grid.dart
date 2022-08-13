import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_filmy/models/now_playing_movie_model.dart';

import '../utils/routes.dart';

class NowPlayingGrid extends StatelessWidget {
  final List<NowPlayingMovieModel> moviesList;

  const NowPlayingGrid({required this.moviesList, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: moviesList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            (MediaQuery.of(context).orientation == Orientation.portrait)
                ? 2
                : 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemBuilder: (BuildContext _, int index) {
        final movie = moviesList[index];

        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            Routes.detailPage,
            arguments: {
              'movieId': movie.id.toString()
            },
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    )),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

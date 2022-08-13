import 'package:flutter/material.dart';
import 'package:fluttery_filmy/models/detail_model.dart';

import 'arc_banner_image.dart';
import 'poster.dart';
import 'rating_info.dart';

class MovieDetailHeader extends StatelessWidget {
  MovieDetailHeader(this.movie);

  final DetailModel movie;

  _buildCategoryChips(TextTheme textTheme) {
    return movie.genres!.map((genres) {
      return Chip(
        label: Text(genres.name ?? ""),
        labelStyle: textTheme.caption,
        backgroundColor: Colors.black12,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    var movieInformation = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            movie.originalTitle ?? "",
            style: textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RatingInformation(movie),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            direction: Axis.horizontal,
            children: _buildCategoryChips(textTheme),
          ),
        )
      ],
    );

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 240.0),
          child: ArcBannerImage(
              "https://image.tmdb.org/t/p/w500/${movie.backdropPath}", null),
        ),
        Positioned(
          bottom: 32.0,
          left: 16.0,
          right: 16.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Poster(
                  "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                  height: 190.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: movieInformation,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

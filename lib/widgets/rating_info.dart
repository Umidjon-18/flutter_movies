import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttery_filmy/models/detail_model.dart';

class RatingInformation extends StatelessWidget {
  const RatingInformation(this.movie, {Key? key}) : super(key: key);

  final DetailModel movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var ratingCaptionStyle = textTheme.caption!.copyWith(color: Colors.black45);

    var numericRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          movie.voteAverage!.toStringAsFixed(2),
          style: textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: theme.colorScheme.secondary,
              fontSize: 26),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            'Ratings',
            style: ratingCaptionStyle,
          ),
        ),
      ],
    );

    var starRating = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RatingBar.builder(
          initialRating: movie.voteAverage!.truncate() / 2,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: size.width * 0.06,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.blue,
          ),
          onRatingUpdate: (rating) {},
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0, left: 4.0),
          child: Text(
            'Grade now',
            style: ratingCaptionStyle,
          ),
        ),
      ],
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        numericRating,
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: starRating,
        )
      ],
    );
  }
}

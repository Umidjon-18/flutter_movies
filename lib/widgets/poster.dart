import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Poster extends StatelessWidget {
  static const posterRatio = 0.7;

  const Poster(
    this.posterUrl, {
    Key? key,
    this.height = 100.0,
  }) : super(key: key);

  final String posterUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    var width = posterRatio * height;

    return Material(
      borderRadius: BorderRadius.circular(5.0),
      shadowColor: Colors.black,
      elevation: 25.0,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        width: width,
        height: height,
        imageUrl: posterUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        errorWidget: (context, url, error) => const Image(
          image: AssetImage('assets/images/im_placeholder.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

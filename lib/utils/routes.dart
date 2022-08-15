import 'package:flutter/material.dart';
import 'package:fluttery_filmy/views/details_view.dart';
import 'package:fluttery_filmy/views/youtube_view.dart';

import '../views/home_view.dart';

class Routes {
  static const String detailPage = '/detailPage';
  static const String youtubePage = '/youtubePage';
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case detailPage:
          return MaterialPageRoute(
            builder: (
              context,
            ) =>
                DetailsView(
              movieId: args?['movieId'],
            ),
          );
        case youtubePage:
          return MaterialPageRoute(
            builder: (
              context,
            ) =>
                YoutubeView(
              movieId: args?['movieId'],
              movieName: args?['movieName'],
            ),
          );
        default:
          return MaterialPageRoute(builder: (context) => const HomeView());
      }
    } catch (e) {
      return MaterialPageRoute(builder: (context) => const HomeView());
    }
  }
}

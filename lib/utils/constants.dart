import 'package:flutter/material.dart';
import 'package:fluttery_filmy/views/now_playing_view.dart';

import '../views/popular_view.dart';
import '../views/upcoming_view.dart';

class Constants {
  static const String baseUrl = 'https://api.themoviedb.org';
  static const String myApiKey = '1866d9c54a70ab583c00e22c6790ba97';

  static const List<Widget> pages = [
    NowPlayingView(),
    UpcomingView(),
    PopularView(),
  ];
}

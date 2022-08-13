import 'package:flutter/material.dart';
import 'package:fluttery_filmy/views/details_view.dart';

import '../views/home_view.dart';

class Routes {
    static const String detailPage = '/detailPage';
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
        default:
          return MaterialPageRoute(builder: (context) => const HomeView());
      }
    } catch (e) {
      return MaterialPageRoute(builder: (context) => const HomeView());
    }
  }
}

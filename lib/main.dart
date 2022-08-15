import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

import 'utils/routes.dart';
import 'view_models/detail_view_model.dart';
import 'view_models/now_playing_view_model.dart';
import 'view_models/popular_view_model.dart';
import 'view_models/upcoming_view_model.dart';
import 'view_models/youtube_view_model.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => NowPlayingViewModel()),
        ChangeNotifierProvider(create: (_) => UpcomingViewModel()),
        ChangeNotifierProvider(create: (_) => PopularViewModel()),
        ChangeNotifierProvider(create: (_) => DetailViewModel()),
        ChangeNotifierProvider(create: (_) => YoutubeViewModel()),
      ],
      child: Consumer<HomeViewModel>(
        builder: (context, homeViewModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: homeViewModel.isDark ? ThemeData.dark() : ThemeData.light(),
            onGenerateRoute: (settings) => Routes.generateRoute(settings),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

import 'utils/routes.dart';
import 'view_models/detail_view_model.dart';
import 'view_models/now_playing_view_model.dart';
import 'view_models/popular_view_model.dart';
import 'view_models/upcoming_view_model.dart';

void main() {
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) => Routes.generateRoute(settings),
      ),
    );
  }
}

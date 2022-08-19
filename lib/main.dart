import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

import 'utils/routes.dart';
import 'view_models/detail_view_model.dart';
import 'view_models/now_playing_view_model.dart';
import 'view_models/popular_view_model.dart';
import 'view_models/upcoming_view_model.dart';
import 'view_models/youtube_view_model.dart';

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => Container();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('uz', 'UZ'),
        Locale('en', 'US'),
        Locale('ru', 'RU')
      ],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            onGenerateRoute: (settings) => Routes.generateRoute(settings),
          );
        },
      ),
    );
  }
}

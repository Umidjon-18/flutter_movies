import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_filmy/services/network_services/check_connection.dart';
import 'package:fluttery_filmy/view_models/detail_view_model.dart';
import 'package:fluttery_filmy/view_models/now_playing_view_model.dart';
import 'package:fluttery_filmy/view_models/popular_view_model.dart';
import 'package:fluttery_filmy/view_models/upcoming_view_model.dart';
import 'package:fluttery_filmy/view_models/youtube_view_model.dart';
import 'package:provider/provider.dart';

class ConnectionErrorView extends StatefulWidget {
  const ConnectionErrorView({required this.pageIndex, this.movieId, Key? key})
      : super(key: key);
  final int pageIndex;
  final String? movieId;
  @override
  State<ConnectionErrorView> createState() => _ConnectionErrorViewState();
}

class _ConnectionErrorViewState extends State<ConnectionErrorView> {
  bool indicatorVisibility = false;
  updater(value) {
    indicatorVisibility = true;
    setState(() {});
    Timer(const Duration(milliseconds: 1000), () async {
      await NetworkConnection.checkConnection().then((res) {
        res ? value.uploadMovies() : indicatorVisibility = false;
        setState(() {});
      });
    });
  }

  updaterWithId(value, int pageNum) {
    indicatorVisibility = true;
    setState(() {});
    Timer(const Duration(milliseconds: 1000), () async {
      await NetworkConnection.checkConnection().then((res) {
        res
            ? pageNum == 4
                ? value.uploadMovieDetails(widget.movieId.toString())
                : value.uploadYoutubeVideos(widget.movieId.toString())
            : indicatorVisibility = false;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Consumer5<NowPlayingViewModel, UpcomingViewModel, PopularViewModel,
        DetailViewModel, YoutubeViewModel>(
      builder: (BuildContext context, value, value2, value3, value4, value5,
          Widget? child) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                child: orientation == Orientation.portrait
                    ? ListView(
                        children: [
                          const SizedBox(
                            width: 200,
                            height: 200,
                            child: Image(
                              image: AssetImage('assets/images/ic_wifi.png'),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 40),
                            width: size.width * 0.6,
                            height: size.width * 0.4,
                            child: const Image(
                              image: AssetImage(
                                  'assets/images/wifi_astronaut.gif'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              switch (widget.pageIndex) {
                                case 0:
                                  updater(value);
                                  break;
                                case 1:
                                  updater(value2);
                                  break;
                                case 2:
                                  updater(value3);
                                  break;
                                case 3:
                                  updaterWithId(value4, 4);
                                  break;
                                case 4:
                                  updaterWithId(value5, 5);
                                  break;
                                default:
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                              child: const Text(
                                'tryAgain',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ).tr(),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.45,
                                height: size.width * 0.35,
                                child: const Image(
                                  image: AssetImage(
                                      'assets/images/wifi_astronaut.gif'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    width: size.height * 0.5,
                                    height: size.height * 0.5,
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/ic_wifi.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      switch (widget.pageIndex) {
                                        case 0:
                                          updater(value);
                                          break;
                                        case 1:
                                          updater(value2);
                                          break;
                                        case 2:
                                          updater(value3);
                                          break;
                                        case 3:
                                          updaterWithId(value4, 4);
                                          break;
                                        case 4:
                                          updaterWithId(value5, 5);
                                          break;
                                        default:
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 40),
                                      child: const Text(
                                        'tryAgain',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ).tr(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
              Visibility(
                visible: indicatorVisibility,
                child: const Center(
                  child: CupertinoActivityIndicator(
                    radius: 50,
                    color: Color.fromARGB(255, 2, 5, 82),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

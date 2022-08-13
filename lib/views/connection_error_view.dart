import 'package:flutter/material.dart';
import 'package:fluttery_filmy/view_models/detail_view_model.dart';
import 'package:fluttery_filmy/view_models/now_playing_view_model.dart';
import 'package:fluttery_filmy/view_models/popular_view_model.dart';
import 'package:fluttery_filmy/view_models/upcoming_view_model.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer4<NowPlayingViewModel, UpcomingViewModel, PopularViewModel,
        DetailViewModel>(
      builder:
          (BuildContext context, value, value2, value3, value4, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: const EdgeInsets.all(40),
            child: ListView(
              children: [
                const SizedBox(
                  width: 200,
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/images/ic_wifi.png'),
                  ),
                ),
                const Center(
                  child: Text(
                    'Connection not found',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 200,
                  height: 200,
                  child: Image(
                    image: AssetImage('assets/images/upset_bear.gif'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    switch (widget.pageIndex) {
                      case 0:
                        value.uploadMovies();
                        break;
                      case 1:
                        value2.uploadMovies();
                        break;
                      case 2:
                        value3.uploadMovies();
                        break;
                      case 3:
                        value4.uploadMovieDetails(widget.movieId.toString());
                        break;
                      default:
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Try Again',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttery_filmy/widgets/now_playing_movie_grid.dart';
import 'package:provider/provider.dart';

import '../view_models/now_playing_view_model.dart';
import 'connection_error_view.dart';

class NowPlayingView extends StatefulWidget {
  const NowPlayingView({Key? key}) : super(key: key);

  @override
  State<NowPlayingView> createState() => _NowPlayingViewState();
}

class _NowPlayingViewState extends State<NowPlayingView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NowPlayingViewModel>(
      builder: (context, nowPlayingViewModel, child) {
        switch (nowPlayingViewModel.state) {
          case NowPlayingState.init:
            Future.delayed(Duration.zero, () {
              nowPlayingViewModel.uploadMovies();
              nowPlayingViewModel.update();
            });
            return const Center(child: CircularProgressIndicator());
          case NowPlayingState.loading:
            return const Center(child: CircularProgressIndicator());
          case NowPlayingState.done:
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: NowPlayingGrid(
                  moviesList: nowPlayingViewModel.moviesList,  nowPlayingViewModel:nowPlayingViewModel
                ),
              ),
            );
          case NowPlayingState.error:
            return const ConnectionErrorView(pageIndex: 0,);
          default:
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

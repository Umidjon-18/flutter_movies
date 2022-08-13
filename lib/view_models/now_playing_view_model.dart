import 'package:flutter/material.dart';
import 'package:fluttery_filmy/models/now_playing_movie_model.dart';
import 'package:fluttery_filmy/services/network_services/now_playing.dart';


enum NowPlayingState {
  init,
  loading,
  done,
  error,
}

class NowPlayingViewModel extends ChangeNotifier {
  NowPlayingState state = NowPlayingState.init;
  List<NowPlayingMovieModel> moviesList = [];
  uploadMovies() async {
    state = NowPlayingState.loading;
    notifyListeners();
    var moviesDataList = await NowPlayingService().getNowPlayingMovies();
    for (var i = 0; i < moviesDataList['results'].length; i++) {
      moviesList
          .add(NowPlayingMovieModel.fromJson(moviesDataList['results'][i]));
    }
    state = NowPlayingState.done;
    notifyListeners();
  }

  update() {
    notifyListeners();
  }
}

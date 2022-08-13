import 'package:flutter/material.dart';
import 'package:fluttery_filmy/services/network_services/now_playing.dart';

import '../models/upcoming_model.dart';


enum UpcomingState {
  init,
  loading,
  done,
  error,
}

class UpcomingViewModel extends ChangeNotifier {
   UpcomingState state =  UpcomingState.init;
  List<UpcomingMovieModel> moviesList = [];
  uploadMovies() async {
    state =  UpcomingState.loading;
    notifyListeners();
    var moviesDataList = await NowPlayingService().getNowPlayingMovies();
    for (var i = 0; i < moviesDataList['results'].length; i++) {
      moviesList
          .add(UpcomingMovieModel.fromJson(moviesDataList['results'][i]));
    }
    state =  UpcomingState.done;
    notifyListeners();
  }

  update() {
    notifyListeners();
  }
}
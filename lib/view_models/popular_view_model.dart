import 'package:flutter/material.dart';

import '../models/popular_model.dart';
import '../services/network_services/popular.dart';


enum PopularState {
  init,
  loading,
  done,
  error,
}

class PopularViewModel extends ChangeNotifier {
   PopularState state =  PopularState.init;
  List<PopularMovieModel> moviesList = [];
  uploadMovies() async {
    state =  PopularState.loading;
    notifyListeners();
    var moviesDataList = await PopularService().getPopularMovies();
    for (var i = 0; i < moviesDataList['results'].length; i++) {
      moviesList
          .add(PopularMovieModel.fromJson(moviesDataList['results'][i]));
    }
    state =  PopularState.done;
    notifyListeners();
  }

  update() {
    notifyListeners();
  }
}
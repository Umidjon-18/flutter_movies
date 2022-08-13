import 'package:flutter/material.dart';
import 'package:fluttery_filmy/models/detail_model.dart';

import '../services/network_services/movie_detail.dart';

enum DetailState {
  init,
  loading,
  done,
  error,
}

class DetailViewModel extends ChangeNotifier {
  DetailState state = DetailState.init;
  late DetailModel detailModel;
  uploadMovieDetails(String movieId) async {
    state = DetailState.loading;
    notifyListeners();
    var request = await MovieDetailService.uploadMovieDetail(movieId);
    detailModel = DetailModel.fromJson(request);
    state = DetailState.done;
    notifyListeners();
  }

  update() {
    notifyListeners();
  }

  onDispose(){
    state = DetailState.init;
    notifyListeners();
  }
}

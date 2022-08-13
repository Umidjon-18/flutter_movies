import 'package:flutter/material.dart';
import 'package:fluttery_filmy/models/detail_model.dart';

import '../services/network_services/check_connection.dart';
import '../services/network_services/movie_detail.dart';

enum DetailState {
  init,
  loading,
  done,
  error,
}

class DetailViewModel extends ChangeNotifier {
  DetailState state = DetailState.init;
  late DetailModel detail;
  uploadMovieDetails(String movieId) async {
    if (await NetworkConnection.checkConnection()) {
      state = DetailState.loading;
      notifyListeners();
      var request = await MovieDetailService.uploadMovieDetail(movieId);
      detail = DetailModel.fromJson(request);
      state = DetailState.done;
      notifyListeners();
    } else {
      state = DetailState.error;
    }
  }

  update() {
    notifyListeners();
  }

  onDispose() {
    state = DetailState.init;
  }
}

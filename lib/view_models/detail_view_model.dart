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
      var genres = List.generate(request['genres'].length,
          (index) => Genres.fromJson(request['genres'][index]));
      var productionCompanies = List.generate(request['production_companies'].length,
          (index) => ProductionCompanies.fromJson(request['production_companies'][index]));
      var productionCountries = List.generate(request['production_countries'].length,
          (index) => ProductionCountries.fromJson(request['production_countries'][index]));
      var spokenLanguages = List.generate(request['spoken_languages'].length,
          (index) => SpokenLanguages.fromJson(request['spoken_languages'][index]));
      detail = DetailModel.fromJson(request);
      detail.genres = genres;
      detail.productionCompanies = productionCompanies;
      detail.productionCountries = productionCountries;
      detail.spokenLanguages = spokenLanguages;
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

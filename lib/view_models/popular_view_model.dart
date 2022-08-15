import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/popular_model.dart';
import '../services/network_services/check_connection.dart';
import '../services/network_services/popular.dart';

enum PopularState {
  init,
  loading,
  done,
  error,
}

class PopularViewModel extends ChangeNotifier {
  PopularState state = PopularState.init;
  List<PopularMovieModel> moviesList = [];
  List<PopularMovieModel> moviesListCopy = [];
  var randomPage = 1;
  uploadMovies() async {
    if (await NetworkConnection.checkConnection()) {
      moviesListCopy.clear();
      moviesList.clear();
      state = PopularState.loading;
      notifyListeners();
      var moviesDataList = await PopularService().getPopularMovies(randomPage);
      randomPage = Random.secure().nextInt(500) + 1;
      for (var i = 0; i < moviesDataList['results'].length; i++) {
        moviesList
            .add(PopularMovieModel.fromJson(moviesDataList['results'][i]));
      }
      for (PopularMovieModel movie in moviesList) {
        moviesListCopy.add(movie.copyWith());
      }
      state = PopularState.done;
      notifyListeners();
    } else {
      state = PopularState.error;
      notifyListeners();
    }
  }

  update() {
    notifyListeners();
  }

  sortByPopularity() {
    state = PopularState.loading;
    notifyListeners();
    moviesList.sort(((b, a) {
      return a.popularity!.compareTo(b.popularity!);
    }));
    state = PopularState.done;
    notifyListeners();
  }

  sortByRate() {
    state = PopularState.loading;
    notifyListeners();
    moviesList.sort(((b, a) {
      return a.voteAverage!.compareTo(b.voteAverage!);
    }));
    state = PopularState.done;
    notifyListeners();
  }

  sortByDate() {
    state = PopularState.loading;
    notifyListeners();
    DateFormat format = DateFormat("yyyy-MM-dd");
    moviesList.sort(((a, b) {
      return format
          .parse(a.releaseDate!)
          .compareTo(format.parse(b.releaseDate!));
    }));
    state = PopularState.done;
    notifyListeners();
  }

  sortByVote() {
    state = PopularState.loading;
    notifyListeners();
    moviesList.sort(((b, a) {
      return a.voteCount!.compareTo(b.voteCount!);
    }));
    state = PopularState.done;
    notifyListeners();
  }

  searchMovie(String searchText) {
    List<PopularMovieModel> tempValue = [];
    for (var movie in moviesListCopy) {
      if (movie.originalTitle!
          .toLowerCase()
          .contains(searchText.toLowerCase())) {
        tempValue.add(movie);
      }
    }
    moviesList.clear();
    moviesList = tempValue;
    notifyListeners();
    if (searchText.isEmpty) {
      moviesList.clear();
      for (PopularMovieModel movie in moviesListCopy) {
        moviesList.add(movie.copyWith());
      }
      notifyListeners();
    }
  }
}

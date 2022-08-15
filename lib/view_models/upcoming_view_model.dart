import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/upcoming_model.dart';
import '../services/network_services/check_connection.dart';
import '../services/network_services/upcoming.dart';

enum UpcomingState {
  init,
  loading,
  done,
  error,
}

class UpcomingViewModel extends ChangeNotifier {
  UpcomingState state = UpcomingState.init;
  List<UpcomingMovieModel> moviesList = [];
  List<UpcomingMovieModel> moviesListCopy = [];
  var randomPage = 1;
  uploadMovies() async {
    if (await NetworkConnection.checkConnection()) {
      moviesListCopy.clear();
      moviesList.clear();
      state = UpcomingState.loading;
      notifyListeners();
      var moviesDataList =
          await UpcomingService().getUpcomingMovies(randomPage);
      randomPage =
          Random.secure().nextInt(moviesDataList['total_pages'] - 1) + 1;
      for (var i = 0; i < moviesDataList['results'].length; i++) {
        moviesList
            .add(UpcomingMovieModel.fromJson(moviesDataList['results'][i]));
      }
      for (UpcomingMovieModel movie in moviesList) {
        moviesListCopy.add(movie.copyWith());
      }
      state = UpcomingState.done;
      notifyListeners();
    } else {
      state = UpcomingState.error;
      notifyListeners();
    }
  }

  update() {
    notifyListeners();
  }

  sortByPopularity() {
    state = UpcomingState.loading;
    notifyListeners();
    moviesList.sort(((b, a) {
      return a.popularity!.compareTo(b.popularity!);
    }));
    state = UpcomingState.done;
    notifyListeners();
  }

  sortByRate() {
    state = UpcomingState.loading;
    notifyListeners();
    moviesList.sort(((b, a) {
      return a.voteAverage!.compareTo(b.voteAverage!);
    }));
    state = UpcomingState.done;
    notifyListeners();
  }

  sortByDate() {
    state = UpcomingState.loading;
    notifyListeners();
    DateFormat format = DateFormat("yyyy-MM-dd");
    moviesList.sort(((a, b) {
      return format
          .parse(a.releaseDate!)
          .compareTo(format.parse(b.releaseDate!));
    }));
    state = UpcomingState.done;
    notifyListeners();
  }

  sortByVote() {
    state = UpcomingState.loading;
    notifyListeners();
    moviesList.sort(((b, a) {
      return a.voteCount!.compareTo(b.voteCount!);
    }));
    state = UpcomingState.done;
    notifyListeners();
  }

  searchMovie(String searchText) {
    List<UpcomingMovieModel> tempValue = [];
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
      for (UpcomingMovieModel movie in moviesListCopy) {
        moviesList.add(movie.copyWith());
      }
      notifyListeners();
    }
  }
}

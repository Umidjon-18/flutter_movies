import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttery_filmy/models/now_playing_model.dart';
import 'package:fluttery_filmy/services/network_services/check_connection.dart';
import 'package:fluttery_filmy/services/network_services/now_playing.dart';
import 'package:intl/intl.dart';

enum NowPlayingState {
  init,
  loading,
  done,
  error,
}

class NowPlayingViewModel extends ChangeNotifier {
  ScrollController scrollController = ScrollController();
  NowPlayingState state = NowPlayingState.init;
  List<NowPlayingMovieModel> moviesList = [];
  List<NowPlayingMovieModel> moviesListCopy = [];
  var randomPage = 1;
  var totalPages = 1;
  uploadMovies() async {
    bool isAvailableConnection = await NetworkConnection.checkConnection();
    if (isAvailableConnection) {
      moviesListCopy.clear();
      moviesList.clear();
      state = NowPlayingState.loading;
      notifyListeners();
      var moviesDataList =
          await NowPlayingService().getNowPlayingMovies(randomPage);
      totalPages = moviesDataList['total_pages'];
      if (randomPage < totalPages && randomPage<25) {
        randomPage += 1;
      } else {
        randomPage = 1;
      }
      for (var i = 0; i < moviesDataList['results'].length; i++) {
        moviesList
            .add(NowPlayingMovieModel.fromJson(moviesDataList['results'][i]));
      }
      for (NowPlayingMovieModel movie in moviesList) {
        moviesListCopy.add(movie.copyWith());
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        state = NowPlayingState.done;
        notifyListeners();
      });
    } else {
      state = NowPlayingState.error;
      notifyListeners();
    }
  }

  update() {
    notifyListeners();
  }

  sortByPopularity() {
    state = NowPlayingState.loading;
    notifyListeners();
    moviesList.sort(((b, a) {
      return a.popularity!.compareTo(b.popularity!);
    }));
    state = NowPlayingState.done;
    notifyListeners();
  }

  sortByRate() {
    state = NowPlayingState.loading;
    notifyListeners();
    moviesList.sort(((b, a) {
      return a.voteAverage!.compareTo(b.voteAverage!);
    }));
    state = NowPlayingState.done;
    notifyListeners();
  }

  sortByDate() {
    state = NowPlayingState.loading;
    notifyListeners();
    DateFormat format = DateFormat("yyyy-MM-dd");
    moviesList.sort(((a, b) {
      return format
          .parse(a.releaseDate!)
          .compareTo(format.parse(b.releaseDate!));
    }));
    state = NowPlayingState.done;
    notifyListeners();
  }

  sortByVote() {
    state = NowPlayingState.loading;
    notifyListeners();
    moviesList.sort(((b, a) {
      return a.voteCount!.compareTo(b.voteCount!);
    }));
    state = NowPlayingState.done;
    notifyListeners();
  }

  searchMovie(String searchText) {
    List<NowPlayingMovieModel> tempValue = [];
    for (var movie in moviesListCopy) {
      bool searchResult =
          movie.originalTitle!.toLowerCase().contains(searchText.toLowerCase());
      if (searchResult) {
        tempValue.add(movie);
      }
    }
    moviesList.clear();
    moviesList = tempValue;
    if (searchText.isEmpty) {
      moviesList.clear();
      for (NowPlayingMovieModel movie in moviesListCopy) {
        moviesList.add(movie.copyWith());
      }
    }
    notifyListeners();
  }
}

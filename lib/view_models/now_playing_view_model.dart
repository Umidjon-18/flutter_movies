import 'package:flutter/material.dart';
import 'package:fluttery_filmy/models/now_playing_movie_model.dart';
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
  NowPlayingState state = NowPlayingState.init;
  List<NowPlayingMovieModel> moviesList = [];
  List<NowPlayingMovieModel> moviesListCopy = [];
  uploadMovies() async {
    if (await NetworkConnection.checkConnection()) {
      moviesListCopy.clear();
      state = NowPlayingState.loading;
      notifyListeners();
      var moviesDataList = await NowPlayingService().getNowPlayingMovies();
      for (var i = 0; i < moviesDataList['results'].length; i++) {
        moviesList
            .add(NowPlayingMovieModel.fromJson(moviesDataList['results'][i]));
      }
      for (NowPlayingMovieModel movie in moviesList) {
        moviesListCopy.add(movie.copyWith());
      }

      state = NowPlayingState.done;
      notifyListeners();
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
      for (NowPlayingMovieModel movie in moviesListCopy) {
        moviesList.add(movie.copyWith());
      }
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import 'package:fluttery_filmy/models/youtube_model.dart';

import '../services/network_services/check_connection.dart';
import '../services/network_services/youtube.dart';

enum YoutubeState {
  init,
  loading,
  done,
  error,
}

class YoutubeViewModel extends ChangeNotifier {
  YoutubeState state = YoutubeState.init;
  late List<String> youtubeVideoLinks = [];
  int initialVideoIndex = 0;
  uploadYoutubeVideos(String movieId) async {
    if (await NetworkConnection.checkConnection()) {
      state = YoutubeState.loading;
      notifyListeners();
      var request = await YoutubeService.getYoutubeVideos(movieId);
      // print(request);
      for (var video in request['results']) {
        youtubeVideoLinks.add(
            "https://www.youtube.com/watch?v=${YoutubeVideoModel.fromJson(video).key}");
      }
      state = YoutubeState.done;
      notifyListeners();
    } else {
      state = YoutubeState.error;
    }
  }

  update() {
    notifyListeners();
  }

  onDispose() {
    youtubeVideoLinks.clear();
    state = YoutubeState.init;
  }
}

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
  late Map<String, String> youtubeVideos = {};
  int initialVideoIndex = 0;
  uploadYoutubeVideos(String movieId) async {
    bool isAvailableConnection = await NetworkConnection.checkConnection();
    if (isAvailableConnection) {
      state = YoutubeState.loading;
      notifyListeners();
      var request = await YoutubeService.getYoutubeVideos(movieId);
      // print(request);
      for (var video in request['results']) {
        YoutubeVideoModel youtubeVideo = YoutubeVideoModel.fromJson(video);
        youtubeVideos[youtubeVideo.name ?? "Video Name"] =
            "https://www.youtube.com/watch?v=${youtubeVideo.key}";
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
    youtubeVideos.clear();
    state = YoutubeState.init;
  }
}

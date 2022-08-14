import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../../utils/constants.dart';

class YoutubeService {
  // This method gets now playing movies data from API
 static Future getYoutubeVideos(String movieId) async {
    final String url =
        '${Constants.baseUrl}/3/movie/$movieId/videos?api_key=${Constants.myApiKey}';

    try {
      final response = await get(Uri.parse(url));
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> responseJson =
              jsonDecode(response.body) as Map<String, dynamic>;
          return responseJson;
        case 400:
          throw Exception('Bad Request');
        case 401:
        case 403:
          throw Exception('UnAuthorised Exception');
        case 404:
          throw Exception('UnAuthorised Exception');
        case 500:
        default:
          throw Exception('Error occured while communication with server'
              ' with status code : ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    }
  }
}

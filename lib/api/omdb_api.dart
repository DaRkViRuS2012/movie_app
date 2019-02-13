import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/api/endpoints.dart';
import 'package:movie_app/models/omdb_movie.dart';

class OMDBApi {
  Future<OMDBMovie> getMovieByTitleAndYear({String title, String year}) async {
    final response =
        await _makeRequest(Endpoints.omdbMovieByTitleAndYearUrl(title, year));
    return OMDBMovie.fromJson(json.decode(response.body));
  }

  Future<http.Response> _makeRequest(String url) async {
    print("calling -> " + url);
    return await http.get(url);
  }
}

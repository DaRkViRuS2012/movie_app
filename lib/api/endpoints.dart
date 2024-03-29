import 'package:movie_app/constants/api_constants.dart';
import 'package:movie_app/constants/api_secrets.dart';

class Endpoints {
  static String discoverMoviesUrl(int page) {
    return '$TMDB_API_BASE_URL'
        '/discover/movie?api_key='
        '$TMDB_API_KEY'
        '&language=en-US&sort_by=popularity'
        '.desc&include_adult=false&include_video=true&page'
        '=$page';
  }

  static String nowPlayingMoviesUrl(int page) {
    return '$TMDB_API_BASE_URL'
        '/movie/now_playing?api_key='
        '$TMDB_API_KEY'
        '&include_adult=false&page=$page';
  }

  static String topRatedUrl(int page) {
    return '$TMDB_API_BASE_URL'
        '/movie/top_rated?api_key='
        '$TMDB_API_KEY'
        '&include_adult=false&page=$page';
  }

  static String popularMoviesUrl(int page) {
    return '$TMDB_API_BASE_URL'
        '/movie/popular?api_key='
        '$TMDB_API_KEY'
        '&include_adult=false&page=$page';
  }

  static String upcomingMoviesUrl(int page, String region) {
    return '$TMDB_API_BASE_URL'
        '/movie/upcoming?api_key='
        '$TMDB_API_KEY'
        '&include_adult=false&page=$page&region=$region';
  }

  static String movieDetailsUrl(int movieId) {
    return '$TMDB_API_BASE_URL/movie/$movieId?api_key=$TMDB_API_KEY&append_to_response=credits,'
        'images';
  }

  static String genresUrl() {
    return '$TMDB_API_BASE_URL/genre/movie/list?api_key=$TMDB_API_KEY&language=en-US';
  }

  static String getMoviesForGenre(int genreId, int page) {
    // https://api.themoviedb.org/3/discover/movie?api_key=135401ad80768ff3cc3e4abc7cee2874&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_genres=18
    return '$TMDB_API_BASE_URL/discover/movie?api_key=$TMDB_API_KEY'
        '&language=en-US'
        '&sort_by=popularity.desc'
        '&include_adult=false'
        '&include_video=true'
        '&page=$page'
        '&with_genres=$genreId';
  }

  static String movieReviewsUrl(int movieId, int page) {
    return '$TMDB_API_BASE_URL/movie/$movieId/reviews?api_key=$TMDB_API_KEY'
        '&language=en-US&page=$page';
  }

  static getMovieRecomindation(int movieId, int page) {
    return '$TMDB_API_BASE_URL/movie/$movieId/similar?api_key=$TMDB_API_KEY'
        '&language=en-US&page=$page';
    //"https://api.themoviedb.org/3/movie/438808/recommendations?api_key=57a21e38b26baa1dffc4f34ae88ca876&language=en-US&page=2"
  }

  static String omdbMovieByTitleAndYearUrl(String title, String year) {
    return "$OMDB_API_BASE_URL/?t=$title&y=$year&apikey=$OMDB_API_KEY";
  }

  static String movieSearchUrl(String query) {
    return "$TMDB_API_BASE_URL/search/movie?query=$query&api_key=$TMDB_API_KEY";
  }

  static String personSearchUrl(String query) {
    return "$TMDB_API_BASE_URL/search/person?query=$query&api_key=$TMDB_API_KEY";
  }

  static getPerson(int personId) {
    return "$TMDB_API_BASE_URL/person/$personId?api_key=$TMDB_API_KEY&append_to_response=movie_credits";
  }

  static getVedios(int movieId) {
    //https://api.themoviedb.org/3/movie/299537/videos?api_key=57a21e38b26baa1dffc4f34ae88ca876&language=en-US
    return "$TMDB_API_BASE_URL/movie/$movieId/videos?api_key=$TMDB_API_KEY&language=en-US";
  }
}

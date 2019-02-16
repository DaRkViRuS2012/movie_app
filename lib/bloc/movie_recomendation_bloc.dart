import 'dart:async';

import 'package:movie_app/api/tmdb_api.dart';
import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/models/tmdb_movies_response.dart';
import 'package:movie_app/ui/list_screen/movie_state.dart';
import 'package:rxdart/rxdart.dart';

class MovieRecommendationBloc extends BlocBase {
  TMDBApi api;
  int page = 0;
  int movieId;
  //an instance of the MoviesPopulated state that will be used for each Bloc implementation
  MoviesPopulated moviesPopulated = MoviesPopulated([]);

  // This is the internal object whose stream/sink is provided by this component
  var _streamController = BehaviorSubject<MoviesState>();

  // This is the stream of movies. Use this to show the contents
  Stream<MoviesState> get stream => _streamController.stream;

  final _nextPageController = StreamController();

  Sink get nextPage => _nextPageController.sink;

  MovieRecommendationBloc({this.api, this.movieId}) {
    _nextPageController.stream.listen(fetchNextPage);
    init();
  }

  @override
  void dispose() {
    _streamController.close();
  }

  void init() {
    print('initialising bloc for $movieId');
    _streamController = BehaviorSubject<MoviesState>();
    if (page == 0) {
      fetchNextPage();
    }
  }

  fetchNextPage([event]) {
    _streamController.addStream(fetchMoviesFromNetwork());
  }

  Stream<MoviesState> fetchMoviesFromNetwork() async* {
    if (_hasNoExistingData()) {
      yield MoviesLoading();
    }

    page += 1;
    try {
      final result = await _getApiCall(page);
      if (result.isEmpty && _hasNoExistingData()) {
        yield MoviesEmpty();
      } else {
        yield moviesPopulated.update(newMovies: result.results);
      }
    } catch (e) {
      print('error $e');
      yield MoviesError(e.toString());
    }
  }

  bool _hasNoExistingData() => moviesPopulated.movies?.isEmpty ?? true;

  Future<TMDBMoviesResponse> _getApiCall(int page) {
    return api.recomindationMovie(movieId: movieId, page: page);
  }
}

import 'dart:async';

import 'package:movie_app/api/tmdb_api.dart';
import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/models/tmdb_genres.dart';
import 'package:movie_app/ui/genres/genres_state.dart';
import 'package:rxdart/rxdart.dart';

class GenresBloc extends BlocBase {
  TMDBApi tmdbApi;
  bool fetchOnInit;

  GenresBloc({this.tmdbApi, this.fetchOnInit}) {
    if (fetchOnInit) {
      _streamController.addStream(_fetchGenres());
    }
  }

  //the internal object whose sink/stream we can use
  final _streamController = BehaviorSubject<GenresState>();

  //the stream of genres. We use this to show the list of fetched genres
  Stream<GenresState> get stream => _streamController.stream;

  @override
  void dispose() {
    _streamController.close();
  }

  Stream<GenresState> _fetchGenres() async* {
    yield GenresLoading();

    try {
      TMDBGenresResponse response = await tmdbApi.getGenres();
      if (response.isEmpty) {
        yield GenresEmpty();
      } else {
        yield GenresPopulated(response.genres);
      }
    } on Exception catch (e) {
      print('exception: $e');
      yield GenresError(e.toString());
    }
  }
}

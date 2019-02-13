import 'package:movie_app/api/tmdb_api.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/models/tmdb_genres.dart';
import 'package:movie_app/ui/tabs/tab_object.dart';

class MovieListForGenreBloc extends MovieBloc {
  TMDBGenre genre;

  MovieListForGenreBloc(TMDBApi api, TMDBGenre this.genre)
      : super(api: api, tabKey: TabKey.kGenres, genre: genre);
}

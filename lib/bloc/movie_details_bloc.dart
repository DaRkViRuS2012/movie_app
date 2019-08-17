import 'dart:async';

import 'package:movie_app/api/omdb_api.dart';
import 'package:movie_app/api/tmdb_api.dart';
import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/models/omdb_movie.dart';
import 'package:movie_app/models/tmdb_movie_basic.dart';
import 'package:movie_app/models/tmdb_movie_details.dart';
import 'package:movie_app/models/tmdb_movie_response.dart';
import 'package:movie_app/models/tmdb_movies_response.dart';
import 'package:movie_app/models/tmdb_reviews_response.dart';
import 'package:movie_app/ui/details_screen/movie_details_state.dart';
import 'package:movie_app/ui/details_screen/movie_videos_state.dart';
import 'package:movie_app/ui/list_screen/movie_state.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailsBloc extends BlocBase {
  TMDBApi tmdb;
  OMDBApi omdb;

  TMDBMovieBasic movieBasic;
  MoviesPopulated moviesPopulated = MoviesPopulated([]);

  MovieDetailsBloc({this.tmdb, this.omdb, this.movieBasic}) {
    _streamController.addStream(_fetchMovieDetails(movieBasic.id));
    _videosController.addStream(_fetchVideos(movieBasic.id));
  }

  //the internal object whose sink/stream we can use
  final _streamController = BehaviorSubject<MovieDetailsState>();
  final _recomindationStreamController = BehaviorSubject<TMDBMovieBasic>();
  final _videosController = BehaviorSubject<VideosState>();

  Stream<TMDBMovieBasic> get recomindationStream =>
      _recomindationStreamController.stream;
  //the stream of movie details. use this to show the details
  Stream<MovieDetailsState> get stream => _streamController.stream;
  Stream<VideosState> get videosStream => _videosController.stream;

  @override
  void dispose() {
    print('closing movie details streamcontroller');
    _streamController.close();
  }

  /*
  create an initial state with the basic movie object and an empty movie
	details object
	*/
  MovieDetailsState initialData() {
    return MovieDetailsLoadingState(movieBasic);
  }

  Stream<MovieDetailsState> _fetchMovieDetails(int movieId) async* {
    String year = movieBasic.releaseDate?.split('-')[0];
    yield MovieDetailsLoadingState(movieBasic);

    try {
      TMDBMovieDetails tmdbMovieDetails = await tmdbMovieDetailsCall(movieId);
      OMDBMovie omdbMovie = await omdbMovieByTitleAndYearCall(year);

      if (tmdbMovieDetails.hasErrors()) {
        yield MovieDetailsFailureState(
          moveBasic: movieBasic,
          errorMessage: tmdbMovieDetails.status_message,
        );
      } else {
        yield MovieDetailsSuccessState(
          movieDetails: tmdbMovieDetails,
          movieBasic: movieBasic,
          omdbMovie: omdbMovie,
        );
      }
    } on Exception catch (e) {
      yield MovieDetailsFailureState(
        moveBasic: movieBasic,
        errorMessage: e.toString(),
      );
    }
  }

  Future<OMDBMovie> omdbMovieByTitleAndYearCall(String year) {
    return omdb.getMovieByTitleAndYear(title: movieBasic.title, year: year);
  }

  Future<TMDBMovieDetails> tmdbMovieDetailsCall(int movieId) =>
      tmdb.movieDetails(movieId: movieId);

  Future<TMDBReviewsResponse> tmdbMovieReviewsCall(int movieId, int page) =>
      tmdb.movieReviews(movieId: movieId, page: page);

  tmdbMovieRecomindation(int movieId, int page) {
    tmdb.recomindationMovie(movieId: movieId, page: page).then((value) {});
  }

  Future<TmdbVediosResponse> tmdbVideosCall(int movieId) =>
      tmdb.getVedios(movieId: movieId);

  Stream<VideosState> _fetchVideos(int movieId) async* {
    yield VideosLoading();

    try {
      TmdbVediosResponse tmdbVediosResponse = await tmdbVideosCall(movieId);

      if (tmdbVediosResponse.hasErrors()) {
        yield VideosFailed(tmdbVediosResponse.statusMessage);
      } else {
        yield VideosPopulated(tmdbVideos: tmdbVediosResponse.results);
      }
    } on Exception catch (e) {
      yield VideosFailed(e.toString());
    }
  }
}

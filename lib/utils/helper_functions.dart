import 'package:movie_app/api/tmdb_api.dart';
import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/bloc/genres_bloc.dart';
import 'package:movie_app/bloc/movie_bloc.dart';
import 'package:movie_app/bloc/seach_movies_bloc.dart';
import 'package:movie_app/bloc/search_people_bloc.dart';
import 'package:movie_app/ui/genres/genres_screen.dart';
import 'package:movie_app/ui/list_screen/movies_list_screen.dart';
import 'package:movie_app/ui/search_screen/search_screen_content.dart';
import 'package:movie_app/ui/tabs/tab_object.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

BlocProvider<GenresBloc> getGenresProvider() {
  return BlocProvider<GenresBloc>(
    child: GenresScreen(),
    bloc: GenresBloc(tmdbApi: TMDBApi(), fetchOnInit: true),
  );
}

BlocProvider<MovieBloc> getNowPlayingProvider() {
  return BlocProvider<MovieBloc>(
    child: MoviesListScreen(),
    bloc: MovieBloc(api: TMDBApi(), tabKey: TabKey.kNowPlaying),
  );
}

BlocProvider<MovieBloc> getTopRatedProvider() {
  return BlocProvider<MovieBloc>(
    child: MoviesListScreen(),
    bloc: MovieBloc(api: TMDBApi(), tabKey: TabKey.kTopRated),
  );
}

BlocProvider<MovieBloc> getPopularProvider() {
  return BlocProvider<MovieBloc>(
    child: MoviesListScreen(),
    bloc: MovieBloc(api: TMDBApi(), tabKey: TabKey.kPopular),
  );
}

BlocProvider<MovieBloc> getUpcomingProvider(String region) {
  return BlocProvider<MovieBloc>(
    child: MoviesListScreen(),
    bloc: MovieBloc(api: TMDBApi(), tabKey: TabKey.kUpcoming, region: region),
  );
}

BlocProvider<SearchMoviesBloc> getMovieSearchProvider(
    TextEditingController textController) {
  return BlocProvider<SearchMoviesBloc>(
    child: SearchContentScreen(textController, TabKey.kSearchMovies),
    bloc: SearchMoviesBloc(TMDBApi()),
  );
}

BlocProvider<SearchPeopleBloc> getPeopleSearchProvider(
    TextEditingController textController) {
  return BlocProvider<SearchPeopleBloc>(
    child: SearchContentScreen(textController, TabKey.kSearchPeople),
    bloc: SearchPeopleBloc(TMDBApi()),
  );
}

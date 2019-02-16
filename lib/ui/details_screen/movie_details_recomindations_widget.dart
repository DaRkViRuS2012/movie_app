import 'package:movie_app/api/tmdb_api.dart';
import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/bloc/movie_recomendation_bloc.dart';
import 'package:movie_app/models/tmdb_movie_basic.dart';
import 'package:movie_app/ui/common_widgets/common_widgets.dart';
import 'package:movie_app/ui/common_widgets/empty_result_widget.dart';
import 'package:movie_app/ui/common_widgets/errors_widget.dart';
import 'package:movie_app/ui/common_widgets/loading_widget.dart';
import 'package:movie_app/ui/details_screen/movie_recommendation_list_widget.dart';
import 'package:movie_app/ui/list_screen/movie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/utils/styles.dart';

Container buildSubtitleForDetailsPage(String title) {
  return Container(
      margin: const EdgeInsets.only(left: 8.0, bottom: 18.0),
      child: Align(
          alignment: Alignment.topLeft,
          child: Text(title, style: STYLE_SUBTITLE)));
}

class MoviesRecomendationListWidget extends StatefulWidget {
  final movieId;

  MoviesRecomendationListWidget({this.movieId});

  @override
  MoviesListWidgetState createState() {
    return new MoviesListWidgetState();
  }

  StreamBuilder<MoviesState> buildStreamBuilder(
      BuildContext context, MovieRecommendationBloc movieBloc, int movieId) {
    return StreamBuilder(
        stream: movieBloc.stream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          print(data is MoviesLoading);
          return Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Fade in an Empty Result screen if the search contained
                    // no items

                    EmptyWidget(visible: data is MoviesEmpty),

                    // Fade in a loading screen when results are being fetched
                    LoadingWidget(visible: data is MoviesLoading),

                    // Fade in an error if something went wrong when fetching
                    // the results
                    ErrorsWidget(
                        visible: data is MoviesError,
                        error: data is MoviesError ? data.error : ""),

                    // Fade in the Result if available
                    MovieRecommendationListWidget(
                      movieId: this.movieId,
                      movieBloc: movieBloc,
                      movies: data is MoviesPopulated ? getMovies(data) : [],
                    ),
                    // Container(
                    //   color: Colors.red,
                    // )
                  ],
                ),
              ),
            ],
          );
        });
  }

  List<TMDBMovieBasic> getMovies(MoviesPopulated data) {
    print('length ${data.movies.length}');
    return data.movies;
  }
}

class MoviesListWidgetState extends State<MoviesRecomendationListWidget> {
  MovieRecommendationBloc movieBloc;
  @override
  void initState() {
    // TODO: implement initState
    movieBloc =
        MovieRecommendationBloc(movieId: widget.movieId, api: TMDBApi());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Column(
      children: <Widget>[
        buildSubtitleForDetailsPage("Recommended Movies"),
        Container(
          height: 300.0,
          child: widget.buildStreamBuilder(
            context,
            movieBloc,
            widget.movieId,
          ),
        ),
        buildHorizontalDivider(),
      ],
    );
  }
}

import 'package:movie_app/bloc/movie_recomendation_bloc.dart';
import 'package:movie_app/models/tmdb_movie_basic.dart';
import 'package:movie_app/ui/grid_screen/grid_item.dart';
import 'package:movie_app/ui/list_screen/movie_row/poster_row.dart';
import 'package:movie_app/ui/scroll_controller/list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MovieRecommendationListWidget extends StatefulWidget {
  final List<TMDBMovieBasic> movies;
  final MovieRecommendationBloc movieBloc;
  final movieId;

  MovieRecommendationListWidget(
      {Key key,
      @required this.movies,
      @required this.movieBloc,
      @required this.movieId})
      : super(key: key);

  @override
  MovieListWidgetState createState() {
    return new MovieListWidgetState();
  }
}

class MovieListWidgetState extends State<MovieRecommendationListWidget> {
  ListController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ListController()..addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2000 &&
        !_scrollController.isPaused) {
      this.widget.movieBloc.nextPage.add(this.widget.movieId);
      _scrollController.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("bulid list");
    _scrollController.unPause();
    return AnimatedOpacity(
        duration: Duration(milliseconds: 800),
        opacity: this.widget.movies.isNotEmpty ? 1.0 : 0.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            itemCount: this.widget.movies.length,
            itemBuilder: (context, index) {
              print("movie");
              final movie = this.widget.movies[index];
              print('movie ${movie.title}');
              return Container(
                  width: 200.0,
                  padding: EdgeInsets.all(8.0),
                  child: GridItem(movie: movie));
            }));
  }
}

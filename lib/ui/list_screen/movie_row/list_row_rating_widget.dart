import 'package:movie_app/models/tmdb_movie_basic.dart';
import 'package:movie_app/models/tmdb_movie_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListRowRatingWidget extends StatelessWidget {
  final TMDBMovieBasic movie;
  final defaultStyle = TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  final TMDBMovieDetails movieDetails;

  ListRowRatingWidget(TMDBMovieBasic this.movie, TMDBMovieDetails this.movieDetails);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: 40.0,
                  height: 40.0,
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Image(image: AssetImage("assets/tmdb_icon.png"))),
              //wrap in Material for the Hero transition
              Material(
                color: Colors.transparent,
                child: Text("${movie.voteAverage}",
                    style: defaultStyle.copyWith(color: Colors.yellow, fontSize: 17.0)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

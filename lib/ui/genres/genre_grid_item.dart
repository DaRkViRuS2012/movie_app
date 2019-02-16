import 'package:movie_app/models/tmdb_genres.dart';
import 'package:movie_app/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/utils/app_colors.dart';

class GenreGridItem extends StatelessWidget {
  final TMDBGenre genre;

  GenreGridItem({TMDBGenre this.genre});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          // boxShadow: [AppColors.shadow],
          gradient: AppColors.gradiant_decoration,
        ),
        child: FlatButton(
          // textColor: Theme.of(context).accentColor,
          color: Colors.transparent,
          onPressed: () {
            Router.goToMoviesByGenreList(context, genre);
          },
          child: Hero(
            child: Material(
              color: Colors.transparent,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${genre.name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
            tag: "${genre.name}",
          ),
        ),
      ),
    );
  }
}

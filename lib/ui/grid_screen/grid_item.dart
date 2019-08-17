import 'package:auto_size_text/auto_size_text.dart';
import 'package:movie_app/constants/api_constants.dart';
import 'package:movie_app/models/tmdb_movie_basic.dart';
import 'package:movie_app/models/tmdb_movie_details.dart';
import 'package:movie_app/models/tmdb_person_search_response.dart';
import 'package:movie_app/navigation/router.dart';
import 'package:movie_app/ui/common_widgets/poster_widget.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridItem extends StatelessWidget {
  final TMDBMovieBasic movie;
  final TMDBPersonBasic person;

  GridItem({this.movie, this.person});

  BoxDecoration textDecoration() {
    return const BoxDecoration(boxShadow: <BoxShadow>[
      const BoxShadow(
        offset: const Offset(0.0, 0.0),
        blurRadius: 40.0,
        color: Colors.black,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildGridItem(context);
  }

  DefaultTextStyle _buildGridItem(BuildContext context) {
    return DefaultTextStyle(
      style: STYLE_TITLE,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Material(
                child: InkWell(
                  onTap: () => goToAppropriateDetailScreen(context),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: getPosterWidget(),
                      ),
                      Positioned.directional(
                        textDirection: TextDirection.ltr,
                        start: 4.0,
                        end: 4.0,
                        bottom: 4.0,
                        child: Container(
                          decoration: textDecoration(),
                          child: _buildTitle(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PosterWidget getPosterWidget() {
    int id = isMovie() ? movie.id : person.id;
    String imagePath = isMovie() ? movie.posterPath : person.profilePath;
    IMAGE_TYPE imageType = isMovie() ? IMAGE_TYPE.POSTER : IMAGE_TYPE.PROFILE;
    String size = isMovie() ? POSTER_SIZE : PROFILE_SIZE;

    return PosterWidget(
        id: id,
        imagePath: imagePath,
        imageType: imageType,
        boxFit: BoxFit.fitHeight,
        animate: false,
        size: size);
  }

  Widget _buildTitle() {
    String title = isMovie() ? movie.title : person.name;
    int id = isMovie() ? movie.id : getCastFromPerson().id;

    return Hero(
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Robot',
                  shadows: [AppColors.shadow]),
              maxLines: 4,
            ),
          ),
        ),
        tag: "$id-$title");
  }

  bool isMovie() {
    return movie != null;
  }

  goToAppropriateDetailScreen(BuildContext context) {
    if (isMovie()) {
      Router.goToMovieDetailsScreen(context, movie, POSTER_SIZE);
    } else {
      Router.goToPersonDetailsScreen(context, getCastFromPerson());
    }
  }

  Cast getCastFromPerson() {
    return Cast.fromJson(person.toJson());
  }
}

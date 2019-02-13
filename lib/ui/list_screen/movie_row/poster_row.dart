import 'package:movie_app/constants/api_constants.dart';
import 'package:movie_app/models/tmdb_movie_basic.dart';
import 'package:movie_app/navigation/router.dart';
import 'package:movie_app/ui/common_widgets/common_widgets.dart';
import 'package:movie_app/ui/common_widgets/poster_widget.dart';
import 'package:movie_app/ui/list_screen/movie_row/list_row_rating_widget.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

const String POSTER_SIZE = SIZE_ORGINAL;

class PosterRow extends StatelessWidget {
  final TMDBMovieBasic movie;

  PosterRow({this.movie});

  Widget descriptionWidget() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        "", // 'Maya, a 40-year-old woman struggling with frustrations from unfulfilled dreams. Until that is, she gets the chance to prove to Madison Avenue that street smarts are as valuable as book smarts, and that it is never too late for a second act.',
        style: TextStyle(
            color: AppColors.lightWhite,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            shadows: [AppColors.shadow]),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget timeWidget() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(movie.getReleaseYear(),
                style: TextStyle(
                    color: AppColors.lightWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [AppColors.shadow])),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('120 min',
          //       style: TextStyle(
          //           color: AppColors.lightWhite,
          //           fontSize: 16,
          //           fontWeight: FontWeight.bold,
          //           shadows: [AppColors.shadow])),
          // )
        ]);
  }

  Widget rateWidget(theme) {
    var stars = <Widget>[];
    stars.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        movie.voteAverage.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.lightWhite,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            shadows: [AppColors.shadow]),
      ),
    ));
    for (var i = 1; i <= 5; i++) {
      var color = i <= (movie.voteAverage / 2)
          ? theme.accentColor
          : Colors.grey.shade400;
      var star = Icon(
        Icons.star,
        color: color,
        size: 12,
      );
      stars.add(star);
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: stars);
  }

  Widget titleWidget() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: AutoSizeText(
        movie.title,
        style: AppStyles.STYLE_TITLE,
        maxLines: 2,
      ),
    );
  }

  Widget imageContainer() {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.red,
          boxShadow: [AppColors.shadow],
          borderRadius: BorderRadius.circular(10)),
      child: PosterWidget(
        id: movie.id,
        imagePath: movie.posterPath,
        imageType: IMAGE_TYPE.POSTER,
        size: POSTER_SIZE,
        boxFit: BoxFit.cover,
      ),
    );
  }

  Widget infoContriner(theme) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          titleWidget(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              timeWidget(),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8.0),
                child: rateWidget(theme),
              ),
            ],
          ),
          descriptionWidget(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Router.goToMovieDetailsScreen(context, movie, POSTER_SIZE);
        },
        child: buildListMovieRow(movie, context));
  }

  BoxDecoration textDecoration() {
    return const BoxDecoration(boxShadow: <BoxShadow>[
      const BoxShadow(
        offset: const Offset(0.0, 0.0),
        blurRadius: 40.0,
        color: Colors.black,
      )
    ]);
  }

  Widget buildListMovieRow(TMDBMovieBasic movie, BuildContext context) {
    return DefaultTextStyle(
        style: STYLE_TITLE,
        child: Container(
          padding: const EdgeInsets.only(top: 16.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 3, child: imageContainer()),
                // SizedBox(height: 32),
                Expanded(
                  flex: 2,
                  child: Container(
                    // color: Colors.red,
                    margin: const EdgeInsets.only(top: 24.0, bottom: 24.0),
                    child: infoContriner(Theme.of(context)),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildHeader({TMDBMovieBasic movie, bool showRating = true}) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(movie),
            showRating ? ListRowRatingWidget(movie, null) : Container()
          ]),
    );
  }

  Widget _buildTitle(TMDBMovieBasic movie) {
    return Hero(
        child: Material(
            color: Colors.transparent,
            child: Text(movie.title, style: STYLE_TITLE)),
        tag: "${movie.id}-${movie.title}");
  }

  Widget buildReleaseDate(TMDBMovieBasic movie) {
    return Positioned(
      bottom: 0.0,
      right: 0.0,
      child: Container(
        padding: EdgeInsets.all(3.0),
        child:
            //extract the year
            Text(movie.getUpcomingReleaseDate(),
                style: STYLE_TITLE.copyWith(fontSize: 14.0)),
      ),
    );
  }
}

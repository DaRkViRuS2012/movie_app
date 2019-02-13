import 'package:movie_app/bloc/movie_details_bloc.dart';
import 'package:movie_app/models/tmdb_movie_details.dart';
import 'package:movie_app/ui/common_widgets/common_widgets.dart';
import 'package:movie_app/ui/common_widgets/errors_widget.dart';
import 'package:movie_app/ui/details_screen/movie_details_header_widget.dart';
import 'package:movie_app/ui/details_screen/movie_extra_content_widget.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/app_styles.dart';
import 'package:movie_app/utils/styles.dart';
import 'package:flutter/material.dart';

class MovieDetailsContentWidget extends StatelessWidget {
  final TMDBMovieDetails movieDetails;
  final MovieDetailsBloc movieDetailsBloc;
  final bool hasFailed;

  MovieDetailsContentWidget(
      this.movieDetails, this.movieDetailsBloc, bool this.hasFailed);

  Widget descriptionWidget() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        movieDetails.getOverview,
        style: AppStyles.STYLE_SUBTITLE,
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
            child: Text('2018',
                style: TextStyle(
                    color: AppColors.lightWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [AppColors.shadow])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('120 min',
                style: TextStyle(
                    color: AppColors.lightWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [AppColors.shadow])),
          )
        ]);
  }

  Widget generWidget() {
    final geners = movieDetails.genres != null
        ? movieDetails.genres.map((f) {
            return f.name;
          })
        : [""];
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(geners.join(', '), style: AppStyles.STYLE_SUBTITLE),
          )
        ]);
  }

  Widget rateWidget(theme) {
    var stars = <Widget>[];
    stars.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        movieDetails.getRatingFor(RATING_SOURCE.IMDB),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.lightWhite,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            shadows: [AppColors.shadow]),
      ),
    ));
    for (var i = 1; i <= 5; i++) {
      var color = i <= 3 ? Colors.yellow.shade700 : Colors.grey.shade400;
      var star = Icon(
        Icons.star,
        color: color,
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
      child: Text(
        'Annihilation',
        style: AppStyles.STYLE_SUBTITLE,
      ),
    );
  }

  Widget infoContriner(theme) {
    return Container(
      child: Column(
        children: <Widget>[
          titleWidget(),
          rateWidget(theme),
          timeWidget(),
          descriptionWidget()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //use a ListView to make the screen vertically scrollable
    return ListView(
      children: <Widget>[
        buildHeaderImage(context),
        buildTitle(),
        generWidget(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildMinorDetailsRow(),
        ),
        //buildOverview(),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: descriptionWidget(),
        ),
        buildHorizontalDivider(),
        buildMovieExtraDetailsContainer(),
      ],
    );
  }

  Widget buildHeaderImage(BuildContext context) {
    return SizedBox(
      //0.32 is just a magic number that makes things not overlap even in smaller screens
      height: 250.0, //MediaQuery.of(context).size.height * 0.32,
      child: MovieDetailsHeaderWidget(
        backdropPath: movieDetails.movieBasic.backdropPath,
      ),
    );
  }

  Widget buildMovieExtraDetailsContainer() {
    return CrossFadeWidgets(
        childOne: MovieExtraContentWidget(
            movieDetails: movieDetails, movieDetailsBloc: movieDetailsBloc),
        childTwo:
            ErrorsWidget(visible: true, error: movieDetails.status_message),
        showHappyPath: !hasFailed);
  }

  Widget buildMinorDetailsRow() {
    return CrossFadeWidgets(
        childOne: Row(
          children: <Widget>[
            buildReleaseDate(),
            buildRunningTime(),
            buildDirectorName(),
          ],
        ),
        childTwo: Container(),
        showHappyPath: movieDetails.hasData);
  }

  Widget buildOverview() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: Text(
          movieDetails.getOverview,
          textAlign: TextAlign.justify,
          style: AppStyles.STYLE_SUBTITLE,
        ),
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Hero(
              //wrapping up a Text with Material prevents the formatting
              // being lost between transitions
              child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      movieDetails.getTitle,
                      textAlign: TextAlign.center,
                      style: AppStyles.STYLE_TITLE,
                    ),
                  )),
              tag: "${movieDetails.getId}-${movieDetails.getTitle}",
            ),
          ),
        ],
      ),
    );
  }

  buildRunningTime() {
    var formattedRunningTime = movieDetails.getFormattedRunningTime();

    if (formattedRunningTime != null && formattedRunningTime.isNotEmpty) {
      return Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Text(
              formattedRunningTime,
              style: TextStyle(
                color: AppColors.lightWhite,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          getDotSeparator(),
        ],
      );
    }
    return Container();
  }

  buildReleaseDate() {
    var formattedReleaseDate = movieDetails.getFormattedReleaseDate();
    if (formattedReleaseDate != null && formattedReleaseDate.isNotEmpty) {
      return Column(
        children: <Widget>[
          Text('Date'),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(formattedReleaseDate,
                    style: TextStyle(
                      color: AppColors.lightWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              getDotSeparator(),
            ],
          ),
        ],
      );
    }
    return Container();
  }

  buildDirectorName() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("directed by ${movieDetails.getDirector()}",
            style: TextStyle(fontSize: 13.0)),
      ),
    );
  }
}

import 'package:movie_app/bloc/movie_details_bloc.dart';
import 'package:movie_app/models/tmdb_movie_details.dart';
import 'package:movie_app/ui/common_widgets/blurred_image.dart';
import 'package:movie_app/ui/details_screen/movie_details_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/utils/app_colors.dart';

class MovieDetailsWidget extends StatelessWidget {
  final TMDBMovieDetails movieDetails;
  final MovieDetailsBloc movieDetailsBloc;
  final bool hasFailed;
  final String backgroundSize;

  MovieDetailsWidget(
      {@required this.movieDetails,
      @required this.movieDetailsBloc,
      bool this.hasFailed,
      this.backgroundSize});

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  /*
  A stack with a blurred background and contents laid out on top of it
   */
  buildContent(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        Hero(
          tag: "${movieDetails.id}-imagePath",
          child: BlurredImage(
            imagePath: movieDetails.movieBasic.posterPath,
            imageSize: backgroundSize,
          ),
        ),
        // Container(
        //   decoration: BoxDecoration(gradient: AppColors.gradiant_decoration),
        // ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: MovieDetailsContentWidget(
              movieDetails, movieDetailsBloc, hasFailed),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
        )
      ],
    ));
  }
}

import 'package:movie_app/bloc/movie_details_bloc.dart';
import 'package:movie_app/models/tmdb_movie_details.dart';
import 'package:movie_app/ui/common_widgets/errors_widget.dart';
import 'package:movie_app/ui/common_widgets/loading_widget.dart';
import 'package:movie_app/ui/details_screen/cast_thumbnails_widget.dart';
import 'package:movie_app/ui/details_screen/movie_details_images_widget.dart';
import 'package:movie_app/ui/details_screen/movie_details_ratings_widget.dart';
import 'package:movie_app/utils/styles.dart';
import 'package:flutter/widgets.dart';


Container buildSubtitleForDetailsPage(String title) {
	return Container(
			margin: const EdgeInsets.only(left: 8.0, bottom: 18.0),
			child: Align(alignment: Alignment.topLeft, child: Text(title, style: STYLE_SUBTITLE)));
}

class MovieExtraContentWidget extends StatelessWidget {
  final TMDBMovieDetails movieDetails;
  final MovieDetailsBloc movieDetailsBloc;

  MovieExtraContentWidget({this.movieDetails, this.movieDetailsBloc});

  //this approach of adding things to the builder only when they become available
  //helps us avoid the need to deal with null values in the children
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];

    if (movieDetails.hasData) {
      widgetList.addAll(extraChildren());
    } else if (movieDetails.hasErrors()) {
      widgetList.add(ErrorsWidget(visible: true, error: movieDetails.status_message));
    } else {
      widgetList.add(getLoadingWidget());
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgetList,
    );
  }

  List<Widget> extraChildren() {
    return [
      MovieDetailsRatingsWidget(movieDetails: movieDetails, movieDetailsBloc: movieDetailsBloc),
      CastThumbnailsWidget(movieDetails: movieDetails),
      MovieDetailsImagesWidget(movieDetails: movieDetails),
    ];
  }

  Widget getLoadingWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LoadingWidget(visible: true),
    );
  }
}



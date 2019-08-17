import 'package:movie_app/api/tmdb_api.dart';
import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/bloc/movie_details_bloc.dart';
import 'package:movie_app/bloc/movie_recomendation_bloc.dart';
import 'package:movie_app/models/tmdb_movie_basic.dart';
import 'package:movie_app/models/tmdb_movie_response.dart';
import 'package:movie_app/ui/common_widgets/common_widgets.dart';
import 'package:movie_app/ui/common_widgets/empty_result_widget.dart';
import 'package:movie_app/ui/common_widgets/errors_widget.dart';
import 'package:movie_app/ui/common_widgets/loading_widget.dart';
import 'package:movie_app/ui/details_screen/movie_recommendation_list_widget.dart';
import 'package:movie_app/ui/details_screen/movie_video_list.dart';
import 'package:movie_app/ui/details_screen/movie_videos_state.dart';
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

class MoviesVediosListWidget extends StatefulWidget {
  final movieId;

  MoviesVediosListWidget({this.movieId});

  @override
  MoviesVediosListWidgetState createState() {
    return new MoviesVediosListWidgetState();
  }

  StreamBuilder<VideosState> buildStreamBuilder(
      BuildContext context, MovieDetailsBloc movieBloc, int movieId) {
    return StreamBuilder(
        stream: movieBloc.videosStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          print(data is VideosLoading);
          return Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Fade in an Empty Result screen if the search contained
                    // no items

                    EmptyWidget(visible: data is VideosEmpty),

                    // Fade in a loading screen when results are being fetched
                    LoadingWidget(visible: data is VideosLoading),

                    // Fade in an error if something went wrong when fetching
                    // the results
                    ErrorsWidget(
                        visible: data is VideosError,
                        error: data is VideosError ? data.error : ""),

                    // Fade in the Result if available
                    MovieVideosListWidget(
                      movieId: this.movieId,
                      movieBloc: movieBloc,
                      videos: data is VideosPopulated ? getVideos(data) : [],
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

  List<Video> getVideos(VideosPopulated data) {
    print('length ${data.tmdbVideos.length}');
    return data.tmdbVideos;
  }
}

class MoviesVediosListWidgetState extends State<MoviesVediosListWidget> {
  MovieDetailsBloc movieBloc;
  @override
  void initState() {
    // TODO: implement initState
    movieBloc = BlocProvider.of<MovieDetailsBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Column(
      children: <Widget>[
        buildSubtitleForDetailsPage("Trailers"),
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

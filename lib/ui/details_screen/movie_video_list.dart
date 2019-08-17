import 'package:movie_app/bloc/movie_details_bloc.dart';
import 'package:movie_app/models/tmdb_movie_response.dart';
import 'package:movie_app/ui/common_widgets/common_widgets.dart';
import 'package:movie_app/ui/scroll_controller/list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_app/utils/image_helper.dart';

class MovieVideosListWidget extends StatefulWidget {
  final List<Video> videos;
  final MovieDetailsBloc movieBloc;
  final movieId;

  MovieVideosListWidget(
      {Key key,
      @required this.videos,
      @required this.movieBloc,
      @required this.movieId})
      : super(key: key);

  @override
  MovieVideosListWidgetState createState() {
    return new MovieVideosListWidgetState();
  }
}

class MovieVideosListWidgetState extends State<MovieVideosListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("bulid list");

    return AnimatedOpacity(
        duration: Duration(milliseconds: 800),
        opacity: this.widget.videos.isNotEmpty ? 1.0 : 0.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: this.widget.videos.length,
            itemBuilder: (context, index) {
              print("movie");
              final movie = this.widget.videos[index];
              print('movie ${movie.key}');
              return Container(
                  width: 200.0,
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.contain,
                      image: NetworkImage(
                        ImageHelper.getImagePath(
                          widget.movieBloc.movieBasic.posterPath,
                          "w342",
                        ),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      playViedo(context, movie.key),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        movie.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ));
            }));
  }
}

/**
 * decoration: BoxDecoration(
                      image: DecorationImage(
                          image: 
                          
                          NetworkImage(
      ImageHelper.getImagePath(
        widget.movieBloc.movieBasic.posterPath,
        "w342",
      ),
      
    )),
 * 
 */

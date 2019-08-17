import 'package:movie_app/models/tmdb_movie_response.dart';

class VideosState {
  VideosState();
}

class VideosLoading extends VideosState {}

class VideosPopulated extends VideosState {
  List<Video> tmdbVideos;

  VideosPopulated({this.tmdbVideos});
}

class VideosError extends VideosState {
  final String error;
  VideosError(this.error);
}

class VideosFailed extends VideosState {
  String error;
  VideosFailed(this.error);
}

class VideosNoResults extends VideosState {}

class VideosEmpty extends VideosState {}

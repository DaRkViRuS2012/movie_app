import 'package:movie_app/models/tmdb_person.dart';

class PersonState {
  PersonState();
}

class PersonLoading extends PersonState {}

class PersonPopulated extends PersonState {
  TMDBPerson tmdbPerson;

  PersonPopulated({this.tmdbPerson}) {}
}

class PersonFailed extends PersonState {
  String error;

  PersonFailed(String this.error);
}

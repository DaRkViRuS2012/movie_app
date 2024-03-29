import 'package:movie_app/models/omdb_movie.dart';
import 'package:movie_app/models/tmdb_movie_basic.dart';
import 'package:movie_app/models/tmdb_reviews_response.dart';
import 'package:json_annotation/json_annotation.dart';

part "tmdb_movie_details.g.dart";

enum RATING_SOURCE { IMDB, ROTTEN_TOMATOES, METACRITIC }

@JsonSerializable()
class TMDBMovieDetails {
  @JsonKey(name: "status_message")
  String status_message;
  @JsonKey(name: "backdrop_path")
  String backdropPath;
  @JsonKey(name: "belongs_to_collection")
  Object belongsToCollection;
  @JsonKey(name: "imdb_id")
  String imdbId;
  @JsonKey(name: "original_language")
  String originalLanguage;
  @JsonKey(name: "original_title")
  String originalTitle;
  @JsonKey(name: "poster_path")
  String posterPath;
  @JsonKey(name: "production_companies")
  List<ProductionCompany> productionCompanies = null;
  @JsonKey(name: "production_countries")
  List<ProductionCountry> productionCountries = null;
  @JsonKey(name: "release_date")
  String releaseDate;
  @JsonKey(name: "spoken_languages")
  List<SpokenLanguage> spokenLanguages = null;
  @JsonKey(name: "tag_line")
  String tagline;
  @JsonKey(name: "vote_average")
  double voteAverage;
  @JsonKey(name: "vote_count")
  int voteCount;
  @JsonKey(name: "overview")
  String overview;
  @JsonKey(name: "adult")
  bool adult;
  @JsonKey(name: "budget")
  int budget;
  @JsonKey(name: "genres")
  List<Genre> genres = null;
  @JsonKey(name: "homepage")
  String homepage;
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "popularity")
  double popularity;
  @JsonKey(name: "revenue")
  int revenue;
  @JsonKey(name: "runtime")
  int runtime;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "video")
  bool video;
  @JsonKey(name: "credits")
  Credits credits;
  @JsonKey(name: "images")
  Images images;

  OMDBMovie omdbMovie = null;
  List<TMDBReview> movieReviews = [];
  TMDBMovieBasic movieBasic = null;
  bool hasData = false;

  List<TMDBImage> get backdrops => images?.backdrops ?? [];
  List<TMDBImage> get posters => images?.posters ?? [];
  List<TMDBImage> get allImages =>
      [backdrops, posters].expand((images) => images).toList();

  String get getOverview => movieBasic.overview;

  String get getTitle => movieBasic.title;

  int get getId => movieBasic.id;

  String getRatingFor(RATING_SOURCE ratingSource) {
    if (omdbMovie != null && omdbMovie.ratings != null) {
      switch (ratingSource) {
        case RATING_SOURCE.IMDB:
          return omdbMovie?.imdbRating ?? "N/A";
        case RATING_SOURCE.METACRITIC:
          return omdbMovie?.metascore ?? "N/A";
        case RATING_SOURCE.ROTTEN_TOMATOES:
          return findRottenTomatoesRating();
      }
    }
    return "N/A";
  }

  String findRottenTomatoesRating() {
    OMDBRating rating = omdbMovie.ratings.firstWhere(
        (OMDBRating rating) => rating.source == "Rotten Tomatoes",
        orElse: () => null);
    return rating?.value ?? "N/A";
  }

  String getFormattedRunningTime() {
    if (runtime != null) {
      String hours = (runtime / 60).floor().toString();
      String hourLabel = hours == 1 ? "hr" : "hrs";
      String minutes = (runtime % 60).toString();

      return "$hours $hourLabel $minutes mins";
    }
    return "";
  }

  String getFormattedReleaseDate() {
    String year = movieBasic.releaseDate?.split('-')[0];
    return year != null ? "$year" : "";
  }

  String getDirector() {
    if (credits != null) {
      Crew director = credits.crew.firstWhere(
          (Crew crew) => crew.job == "Director",
          orElse: () => null);
      return director != null ? director.name : "";
    }
    return "";
  }

  factory TMDBMovieDetails.fromJson(Map<String, dynamic> json) =>
      _$TMDBMovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TMDBMovieDetailsToJson(this);

  TMDBMovieDetails(
      [this.adult,
      this.backdropPath,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.status_message]);

  hasErrors() {
    return status_message != null;
  }
}

@JsonSerializable()
class Images {
  List<TMDBImage> backdrops;
  List<TMDBImage> posters;

  Images(this.backdrops, this.posters);

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}

@JsonSerializable()
class TMDBImage {
  @JsonKey(name: "aspect_ration")
  double aspectRatio;
  @JsonKey(name: "file_path")
  String filePath;
  @JsonKey(name: "iso_639_1")
  String iso6391;
  @JsonKey(name: "vote_average")
  double voteAverage;
  @JsonKey(name: "vote_count")
  int voteCount;
  int height;
  int width;

  TMDBImage(this.aspectRatio, this.filePath, this.height, this.iso6391,
      this.voteAverage, this.voteCount, this.width);

  factory TMDBImage.fromJson(Map<String, dynamic> json) =>
      _$TMDBImageFromJson(json);

  Map<String, dynamic> toJson() => _$TMDBImageToJson(this);
}

@JsonSerializable()
class ProductionCompany {
  int id;
  Object logoPath;
  String name;
  String originCountry;

  ProductionCompany(this.id, this.logoPath, this.name, this.originCountry);

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);
}

@JsonSerializable()
class ProductionCountry {
  String iso31661;
  String name;

  ProductionCountry(this.iso31661, this.name);

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountryToJson(this);
}

@JsonSerializable()
class SpokenLanguage {
  String iso6391;
  String name;

  SpokenLanguage(this.iso6391, this.name);

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}

@JsonSerializable()
class Genre {
  int id;
  String name;

  Genre(this.id, this.name);

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

/*
"credits": {
        "cast":
        [
            {
                "cast_id": 34,
                "character": "Thomas Anderson / Neo",
                "credit_id": "52fe425bc3a36847f80181c1",
                "gender": 2,
                "id": 6384,
                "name": "Keanu Reeves",
                "order": 0,
                "profile_path": "/bOlYWhVuOiU6azC4Bw6zlXZ5QTC.jpg"
            },
				],
				"crew":
				[
					{
						"credit_id": "52fe425bc3a36847f801812f",
						"department": "Production",
						"gender": 2,
						"id": 1091,
						"job": "Producer",
						"name": "Joel Silver",
						"profile_path": "/9BUSlPpIAEQYtRdzVrSXaivld04.jpg"
					},
				]
 */

@JsonSerializable()
class Credits {
  List<Cast> cast;
  List<Crew> crew;

  Credits(this.cast, this.crew);

  factory Credits.fromJson(Map<String, dynamic> json) =>
      _$CreditsFromJson(json);

  Map<String, dynamic> toJson() => _$CreditsToJson(this);
}

@JsonSerializable()
class Cast {
  @JsonKey(name: "cast_id")
  int castId;
  @JsonKey(name: "character")
  String character;
  @JsonKey(name: "credit_id")
  String creditId;
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "profile_path")
  String profilePath;

  Cast(this.castId, this.character, this.creditId, this.id, this.name,
      this.profilePath);

  bool hasCharacter() {
    return (character != null && character.isNotEmpty);
  }

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable()
class Crew {
  @JsonKey(name: "credit_id")
  String creditId;
  String department;
  int gender;
  int id;
  String job;
  String name;
  @JsonKey(name: "profile_path")
  String profilePath;

  Crew(this.creditId, this.department, this.gender, this.id, this.job,
      this.name, this.profilePath);

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);
}

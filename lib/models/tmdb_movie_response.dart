// To parse this JSON data, do
//
//     final tmdbVediosResponse = tmdbVediosResponseFromJson(jsonString);

import 'dart:convert';

TmdbVediosResponse tmdbVediosResponseFromJson(String str) {
  final jsonData = json.decode(str);
  return TmdbVediosResponse.fromJson(jsonData);
}

String tmdbVediosResponseToJson(TmdbVediosResponse data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class TmdbVediosResponse {
  int id;
  List<Video> results;
  String statusMessage;

  TmdbVediosResponse({
    this.id,
    this.results,
    this.statusMessage,
  });

  factory TmdbVediosResponse.fromJson(Map<String, dynamic> json) =>
      new TmdbVediosResponse(
        id: json["id"] == null ? null : json["id"],
        results: json["results"] == null
            ? null
            : new List<Video>.from(
                json["results"].map((x) => Video.fromJson(x))),
        statusMessage:
            json["status_message"] == null ? null : json["status_message"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "results": results == null
            ? null
            : new List<dynamic>.from(results.map((x) => x.toJson())),
        "status_message": statusMessage == null ? null : statusMessage,
      };

  hasErrors() {
    return statusMessage != null;
  }
}

class Video {
  String id;

  String key;
  String name;
  Site site;
  int size;
  Type type;

  Video({
    this.id,
    this.key,
    this.name,
    this.site,
    this.size,
    this.type,
  });

  factory Video.fromJson(Map<String, dynamic> json) => new Video(
        id: json["id"] == null ? null : json["id"],
        key: json["key"] == null ? null : json["key"],
        name: json["name"] == null ? null : json["name"],
        site: json["site"] == null ? null : siteValues.map[json["site"]],
        size: json["size"] == null ? null : json["size"],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "key": key == null ? null : key,
        "name": name == null ? null : name,
        "site": site == null ? null : siteValues.reverse[site],
        "size": size == null ? null : size,
        "type": type == null ? null : typeValues.reverse[type],
      };
}

enum Site { YOU_TUBE }

final siteValues = new EnumValues({"YouTube": Site.YOU_TUBE});

enum Type { TEASER, CLIP, FEATURETTE, TRAILER }

final typeValues = new EnumValues({
  "Clip": Type.CLIP,
  "Featurette": Type.FEATURETTE,
  "Teaser": Type.TEASER,
  "Trailer": Type.TRAILER
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

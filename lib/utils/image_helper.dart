import 'package:movie_app/constants/api_constants.dart';

class ImageHelper {
  static String getImagePath(String path, String size) {
    if (path != null) {
      return TMDB_BASE_IMAGE_URL + size + path;
    }
    return "";
  }
}

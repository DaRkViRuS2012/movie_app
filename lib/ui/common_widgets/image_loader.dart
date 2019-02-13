import 'package:movie_app/constants/api_constants.dart';
import 'package:movie_app/utils/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageLoader extends StatefulWidget {
  final String imagePath;
  final IMAGE_TYPE imageType;
  final String size;
  final BoxFit boxFit;
  final bool animate;

  ImageLoader(
      {@required this.imagePath,
      @required this.imageType,
      @required this.size,
      this.animate = true,
      this.boxFit = BoxFit.cover});

  @override
  _ImageLoaderState createState() => _ImageLoaderState();
}

class _ImageLoaderState extends State<ImageLoader> {
  bool _loaded = false;
  var image;

  var profilePlaceholder =
      Image(image: AssetImage("assets/person_placeholder.png"));
  var moviePlaceholder =
      Image(image: AssetImage("assets/movie_placeholder.png"));

  @override
  void initState() {
    _loadImage();

    image?.image?.resolve(ImageConfiguration())?.addListener((i, b) {
      mounted
          ? setState(() {
              _loaded = true;
            })
          : null;
    });
    super.initState();
  }

  void _loadImage() {
    image = getPlaceholder();

    image = Image.network(
      ImageHelper.getImagePath(
        widget.imagePath,
        widget.size,
      ),
      fit: widget.boxFit,
    );
  }

  Widget getPlaceholder() {
    Widget placeholder;
    switch (widget.imageType) {
      case IMAGE_TYPE.PROFILE:
        placeholder = profilePlaceholder;
        break;
      case IMAGE_TYPE.POSTER:
        placeholder = moviePlaceholder;
        break;
      case IMAGE_TYPE.BACKDROP:
        placeholder = moviePlaceholder;
        break;
    }
    return placeholder;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate) {
      return AnimatedOpacity(
        child: image,
        duration: Duration(milliseconds: 300),
        opacity: _loaded ? 1.0 : 0.0,
      );
    } else {
      if (_loaded) {
        return image;
      } else {
        return getPlaceholder();
      }
    }
  }
}

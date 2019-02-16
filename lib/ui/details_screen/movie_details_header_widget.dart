import 'package:movie_app/constants/api_constants.dart';
import 'package:movie_app/ui/common_widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/utils/app_colors.dart';

class MovieDetailsHeaderWidget extends StatelessWidget {
  final String backdropPath;

  MovieDetailsHeaderWidget({@required this.backdropPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipShadowPath(
          clipper: ArcClipper(),
          shadow: AppColors.shadow,
          child: ImageLoader(
            imageType: IMAGE_TYPE.BACKDROP,
            imagePath: backdropPath,
            size: BACKDROP_SIZES[SIZE_ORGINAL],
          ),
        ),
      ],
    );
  }
}

class BackdropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var clipHeight = 30.0;
    var startPoint = Offset(0.0, size.height - clipHeight);
    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - clipHeight);

    path.lineTo(startPoint.dx, startPoint.dy);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0); //top right corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 25);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 4), size.height - 0);
    var secondPoint = Offset(size.width, size.height - 25);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    canvas.drawPath(clipper.getClip(size), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

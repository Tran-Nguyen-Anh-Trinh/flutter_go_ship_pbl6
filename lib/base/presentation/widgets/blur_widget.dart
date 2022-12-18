import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'blur_widget.g.dart';

@swidget
Widget blurWidget(
  BuildContext context, {
  required Widget child,
  required Widget childInsideIgnoreBlur,
  required PositionIgnoreBlur positionIgnoreBlur,
  double blurOpacity = 0.6,
  double boderRadius = 0,
}) {
  double widthScreen = MediaQuery.of(context).size.width;
  double heightScreen = MediaQuery.of(context).size.height;
  return Container(
    height: double.infinity,
    width: double.infinity,
    alignment: Alignment.center,
    child: Stack(
      children: [
        ClipPath(
          clipper: CustomClipperPath(position: positionIgnoreBlur, boderRadius: boderRadius),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: ColorName.black000.withOpacity(blurOpacity),
                width: widthScreen,
                height: heightScreen,
              ),
            ),
          ),
        ),
        Positioned(
          top: positionIgnoreBlur.y - positionIgnoreBlur.height / 2,
          left: positionIgnoreBlur.x - positionIgnoreBlur.width / 2,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(boderRadius),
              ),
            ),
            height: positionIgnoreBlur.height,
            width: positionIgnoreBlur.width,
            child: childInsideIgnoreBlur,
          ),
        ),
        Positioned.fill(child: child),
      ],
    ),
  );
}

class CustomClipperPath extends CustomClipper<Path> {
  CustomClipperPath({required this.position, required this.boderRadius});
  PositionIgnoreBlur position;
  double boderRadius;
  @override
  Path getClip(Size size) {
    double widthScreen = size.width;
    double heightScreen = size.height;

    final path = Path();

    if (position.height == boderRadius) {
      path.lineTo(0, heightScreen);
      path.lineTo(widthScreen, heightScreen);
      path.lineTo(widthScreen, 0);

      path.addOval(
        Rect.fromLTRB(
          position.x - position.height / 2,
          position.y - position.height / 2,
          position.x + position.height / 2,
          position.y + position.height / 2,
        ),
      );
    } else {
      path.lineTo(0, heightScreen);
      path.lineTo(widthScreen, heightScreen);
      path.lineTo(widthScreen, position.y + position.height / 2);

      // Left bottom
      path.lineTo(position.x - position.width / 2 + boderRadius, position.y + position.height / 2);
      path.quadraticBezierTo(
        position.x - position.width / 2 + boderRadius * 0.2,
        position.y + position.height / 2 - boderRadius * 0.2,
        position.x - position.width / 2,
        position.y + position.height / 2 - boderRadius,
      );

      // Left top
      path.lineTo(position.x - position.width / 2, position.y - position.height / 2 + boderRadius);
      path.quadraticBezierTo(
        position.x - position.width / 2 + boderRadius * 0.2,
        position.y - position.height / 2 + boderRadius * 0.2,
        position.x - position.width / 2 + boderRadius,
        position.y - position.height / 2,
      );

      // Right top
      path.lineTo(widthScreen / 2 + position.width / 2 - boderRadius, position.y - position.height / 2);
      path.quadraticBezierTo(
        widthScreen / 2 + position.width / 2 - boderRadius * 0.2,
        position.y - position.height / 2 + boderRadius * 0.2,
        widthScreen / 2 + position.width / 2,
        position.y - position.height / 2 + boderRadius,
      );

      // Right bottom
      path.lineTo(position.x + position.width / 2, position.y + position.height / 2 - boderRadius);
      path.quadraticBezierTo(
        widthScreen / 2 + position.width / 2 - boderRadius * 0.2,
        position.y + position.height / 2 - boderRadius * 0.2,
        widthScreen / 2 + position.width / 2 - boderRadius,
        position.y + position.height / 2,
      );

      path.lineTo(widthScreen, position.y + position.height / 2);
      path.lineTo(widthScreen, 0);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class PositionIgnoreBlur {
  PositionIgnoreBlur({required this.height, required this.width, required this.x, required this.y});
  double height;
  double width;
  double x;
  double y;

  PositionIgnoreBlur zero() {
    return PositionIgnoreBlur(height: 0, width: 0, x: 0, y: 0);
  }
}

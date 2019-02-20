import 'dart:ui';

import 'package:movie_app/constants/api_secrets.dart';
import 'package:movie_app/navigation/router.dart';
import 'package:movie_app/ui/info_view/info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

Widget getDotSeparator() {
  return Text("·", style: TextStyle(fontSize: 23.0));
}

Widget getAppBar({title, context, tabController, myTabs}) {
  return AppBar(
      actions: buildActions(context),
      centerTitle: true,
      title: new Text(title),
      backgroundColor: Colors.transparent,
      elevation:
          0.0, // Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 3.0,
      bottom: TabBar(
        controller: tabController,
        tabs: myTabs,
        isScrollable: true,
        indicatorWeight: 1.0,
      ));
}

List<Widget> buildActions(context) {
  return <Widget>[
    searchAction(context),
    infoAction(context),
    playViedo(context)
  ];
}

IconButton searchAction(context) {
  return IconButton(
      icon: Icon(Icons.search),
      onPressed: () => Router.goToSearchScreen(context));
}

IconButton infoAction(context) {
  return IconButton(
      icon: Icon(Icons.info_outline),
      onPressed: () => showModalBottomSheet(
          context: context, builder: (BuildContext context) => InfoView()));
}

IconButton playViedo(context) {
  return IconButton(
      icon: Icon(Icons.play_arrow),
      onPressed: () {
        FlutterYoutube.playYoutubeVideoById(
            apiKey: YOUTUBE_API_KEY,
            videoId: "cGCduKl5q90",
            autoPlay: true, //default falase
            fullScreen: true //default false
            );
      });
}

Widget buildHorizontalDivider(
    {double height = 22.0, Color color = Colors.white}) {
  return Divider(
    height: height,
    color: color,
  );
}

Widget buildDetailSubtitle(String subtitle) {
  return Column(
    children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 30.0)),
      Text(
        subtitle,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

Widget MaterialIcon(String assetPath, [Function onPressedAction]) {
  return Material(
      color: Colors.transparent,
      child: IconButton(
        icon: Image(image: AssetImage(assetPath)),
        onPressed: () => onPressedAction(),
      ));
}

AnimatedCrossFade CrossFadeWidgets(
    {@required Widget childOne,
    @required Widget childTwo,
    @required bool showHappyPath}) {
  return AnimatedCrossFade(
    alignment: Alignment.center,
    firstChild: childOne,
    secondChild: childTwo,
    duration: Duration(milliseconds: 300),
    crossFadeState:
        showHappyPath ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  );
}

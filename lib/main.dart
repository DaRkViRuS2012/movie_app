import 'package:movie_app/bloc/app_bloc.dart';
import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/constants/api_constants.dart';
import 'package:movie_app/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final title = APP_NAME;

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc();
    return BlocProvider<AppBloc>(
      child: MaterialApp(
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          appBloc.deviceLocale = locale;
        },
        title: title,
        debugShowCheckedModeBanner: false,
        // theme: new ThemeData(
        //     dividerColor: Colors.white,
        //     brightness: Brightness.dark,
        //     primarySwatch: Colors.transparent,
        //     accentColor: Colors.transparent),
        home: HomePage(title: title),
      ),
      // home: MoviesPageView()),
      bloc: appBloc,
    );
  }
}

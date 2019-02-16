import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/bloc/person_bloc.dart';
import 'package:movie_app/models/tmdb_movie_details.dart';
import 'package:movie_app/ui/person_details/person_state.dart';
import 'package:movie_app/ui/person_details/person_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PersonScreen extends StatefulWidget {
  final Cast cast;

  PersonScreen(this.cast);

  @override
  PersonScreenState createState() {
    return new PersonScreenState();
  }
}

class PersonScreenState extends State<PersonScreen> {
  PersonBloc personBloc;

  @override
  Widget build(BuildContext context) {
    personBloc = BlocProvider.of<PersonBloc>(context);
    return Stack(
      children: <Widget>[
        Scaffold(
          body: StreamBuilder(
            stream: personBloc.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              return Column(children: <Widget>[
                Expanded(
                  child: Stack(
                    key: Key('content'),
                    children: <Widget>[
                      PersonWidget(
                          cast: this.widget.cast,
                          errorMessage: data is PersonFailed ? data.error : "",
                          showLoading: data is PersonLoading,
                          person:
                              data is PersonPopulated ? data.tmdbPerson : null)
                    ],
                  ),
                ),
              ]);
            },
          ),
        ),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    personBloc.dispose();
    super.dispose();
  }
}

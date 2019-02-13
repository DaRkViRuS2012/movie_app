import 'package:movie_app/bloc/app_bloc.dart';
import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/ui/common_widgets/common_widgets.dart';
import 'package:movie_app/ui/tabs/tab_object.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState(title);
}

class _MyTabbedPageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  TabBarView tabBarView;
  final String title;
  TabObject nowPlayingTab;
  TabObject popularTab;
  TabObject genresTab;
  TabObject topRatedTab;
  TabObject upcomingTab;

  bool hasBuiltTabs = false;

  _MyTabbedPageState(this.title);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //Moved init here because we need the device locale from the AppBloc for the upcoming movies
    //and can't call an inherited widget inside initState
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    buildTabs(appBloc.deviceLocale);
  }

  void buildTabs(Locale deviceLocale) {
    if (hasBuiltTabs) {
      return;
    }

    genresTab = TabObject(TabKey.kGenres, getGenresProvider());
    nowPlayingTab = TabObject(TabKey.kNowPlaying, getNowPlayingProvider());
    topRatedTab = TabObject(TabKey.kTopRated, getTopRatedProvider());
    popularTab = TabObject(TabKey.kPopular, getPopularProvider());
    upcomingTab = TabObject(
        TabKey.kUpcoming, getUpcomingProvider(deviceLocale.countryCode));

    _tabController = new TabController(vsync: this, length: tabs.length);
    _tabController.addListener(_handleTabSelection);

    tabBarView = TabBarView(
      controller: _tabController,
      children: [
        nowPlayingTab.provider,
        upcomingTab.provider,
        popularTab.provider,
        topRatedTab.provider,
        genresTab.provider,
      ],
    );
    hasBuiltTabs = true;
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      return;
    }
  }

  @override
  void dispose() {
    print('dispose home screen');
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
          gradient: AppColors.gradiant_decoration,
        )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: getAppBar(
              tabController: _tabController,
              title: title,
              myTabs: [
                nowPlayingTab.tab,
                upcomingTab.tab,
                popularTab.tab,
                topRatedTab.tab,
                genresTab.tab,
              ],
              context: context),
          body: tabBarView,
        ),
      ],
    );
  }
}

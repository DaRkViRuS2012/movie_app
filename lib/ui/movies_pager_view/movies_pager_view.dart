import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_app/bloc/app_bloc.dart';
import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:movie_app/ui/common_widgets/common_widgets.dart';
import 'package:movie_app/ui/tabs/tab_object.dart';
import 'package:movie_app/utils/app_colors.dart';
import 'package:movie_app/utils/helper_functions.dart';

class MoviesPageView extends StatefulWidget {
  final String title;
  const MoviesPageView({Key key, this.title}) : super(key: key);
  @override
  MoviesPageViewState createState() {
    return new MoviesPageViewState(title);
  }
}

class MoviesPageViewState extends State<MoviesPageView>
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

  MoviesPageViewState(this.title);

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

  Widget descriptionWidget() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        'Maya, a 40-year-old woman struggling with frustrations from unfulfilled dreams. Until that is, she gets the chance to prove to Madison Avenue that street smarts are as valuable as book smarts, and that it is never too late for a second act.',
        style: TextStyle(
            color: AppColors.lightWhite,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            shadows: [AppColors.shadow]),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget timeWidget() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('2018',
                style: TextStyle(
                    color: AppColors.lightWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [AppColors.shadow])),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('120 min',
                style: TextStyle(
                    color: AppColors.lightWhite,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [AppColors.shadow])),
          )
        ]);
  }

  Widget rateWidget(theme) {
    var stars = <Widget>[];
    stars.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '6.7',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColors.lightWhite,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            shadows: [AppColors.shadow]),
      ),
    ));
    for (var i = 1; i <= 5; i++) {
      var color = i <= 3 ? theme.accentColor : Colors.grey.shade400;
      var star = Icon(
        Icons.star,
        color: color,
      );
      stars.add(star);
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: stars);
  }

  Widget titleWidget() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Annihilation',
        style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'Robot',
            shadows: [AppColors.shadow]),
      ),
    );
  }

  Widget imageContainer() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/img.jpg'), fit: BoxFit.cover),
          boxShadow: [AppColors.shadow],
          borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget infoContriner(theme) {
    return Container(
      child: Column(
        children: <Widget>[
          titleWidget(),
          rateWidget(theme),
          timeWidget(),
          descriptionWidget()
        ],
      ),
    );
  }

  Widget swiperView(theme) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return null;
      },
      itemCount: 3,
      //  pagination: new SwiperPagination(),
      // control: new SwiperControl(),
      viewportFraction: 0.85,
      scale: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
            gradient: AppColors.gradiant_decoration,
          )),
          Scaffold(
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
            backgroundColor: Colors.transparent,
            body: swiperView(theme),
          ),
        ],
      ),
    );
  }
}

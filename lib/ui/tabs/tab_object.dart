import 'package:movie_app/bloc/bloc_provider.dart';
import 'package:flutter/material.dart';

enum TabKey {
  kNowPlaying,
  kUpcoming,
  kTopRated,
  kPopular,
  kGenres,
  kSearchMovies,
  kSearchPeople,
  kRecommindation
}

const Map<TabKey, String> tabs = {
  TabKey.kNowPlaying: "IN THEATERS",
  TabKey.kUpcoming: "UPCOMING",
  TabKey.kTopRated: "TOP RATED",
  TabKey.kPopular: "POPULAR",
  TabKey.kGenres: "GENRES",
  TabKey.kSearchMovies: "MOVIES",
  TabKey.kSearchPeople: "PEOPLE"
};

class TabObject {
  Tab tab;
  BlocProvider provider;

  TabObject(TabKey tabKey, BlocProvider blocProvider) {
    tab = Tab(text: tabs[tabKey]);
    provider = blocProvider;
  }
}

/// test

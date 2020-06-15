// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sneakershoottest/ui/views/home/home_view.dart';
import 'package:sneakershoottest/ui/views/detail_post/detail_post_view.dart';

abstract class Routes {
  static const homeViewRoute = '/';
  static const detailPostView = '/detail-post-view';
  static const all = {
    homeViewRoute,
    detailPostView,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeViewRoute:
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(),
          settings: settings,
        );
      case Routes.detailPostView:
        return MaterialPageRoute<dynamic>(
          builder: (context) => DetailPostView(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

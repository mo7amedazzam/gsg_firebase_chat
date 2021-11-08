import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteHelper {
  RouteHelper._();
  static RouteHelper routeHelper = RouteHelper._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

  goToPage(String routeName) {
    navKey.currentState.pushNamed(routeName);
  }

  goToPageWithReplacement(String routeName) {
    navKey.currentState.pushReplacementNamed(routeName);
  }

  back() {
    navKey.currentState.pop();
  }
}

library travel_planner_routing;

import 'package:angular/angular.dart';

void travelPlannerRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'view_default': ngRoute(
        defaultRoute : true,
        path: '/',
        view: 'view/overview.html'),
  });
}
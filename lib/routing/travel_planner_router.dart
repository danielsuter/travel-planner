library travel_planner_routing;

import 'package:angular/angular.dart';

void travelPlannerRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'add':ngRoute(
        path: '/add',
        view: 'view/add.html'),    
    'view_default': ngRoute(
        defaultRoute : true,
        view: 'view/overview.html'),
  });
}
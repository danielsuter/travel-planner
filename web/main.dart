import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:TravelPlanner/travel_planner.dart';
import 'package:TravelPlanner/routing/travel_planner_router.dart';


void main() {
  applicationFactory().addModule(new TravelPlannerModule()).run();
}

class TravelPlannerModule extends Module {
  TravelPlannerModule() {
    bind(TravelPlannerController);
    
    bind(RouteInitializerFn, toValue: travelPlannerRouteInitializer);
  }
}
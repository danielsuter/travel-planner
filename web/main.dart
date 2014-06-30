import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:TravelPlanner/travel_planner.dart';
import 'package:TravelPlanner/add_travel_plan.dart';
import 'package:TravelPlanner/routing/travel_planner_router.dart';
import 'package:logging/logging.dart';


void main() {
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });
  
  applicationFactory().addModule(new TravelPlannerModule()).run();
}

class TravelPlannerModule extends Module {
  TravelPlannerModule() {
    bind(TravelPlannerController);
    bind(AddTravelPlanController);
    
    bind(RouteInitializerFn, toValue: travelPlannerRouteInitializer);
    bind(NgRoutingUsePushState, toFactory: (_) => new NgRoutingUsePushState.value(false));
  }
}
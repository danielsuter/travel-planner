import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:TravelPlanner/travel_planner.dart';
import 'package:TravelPlanner/routing/travel_planner_router.dart';
import 'package:logging/logging.dart';
import 'package:TravelPlanner/travelstep/travel_step_component.dart';
import 'package:TravelPlanner/travelplan/travel_plan_component.dart';
import 'package:TravelPlanner/util/validator.dart';

void main() {
  Logger.root.level = Level.FINEST;
  Logger.root.onRecord.listen((LogRecord r) { print(r.message); });
  
  applicationFactory().addModule(new TravelPlannerModule()).run();
}

class TravelPlannerModule extends Module {
  TravelPlannerModule() {
    bind(TravelPlannerController);
    bind(TravelStepComponent);
    bind(TravelPlanComponent);
    
    bind(VsDateValidator);
    
    bind(RouteInitializerFn, toValue: travelPlannerRouteInitializer);
    bind(NgRoutingUsePushState, toFactory: (_) => new NgRoutingUsePushState.value(false));
  }
}
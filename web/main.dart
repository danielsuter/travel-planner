import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:TravelPlanner/travel_planner.dart';


void main() {
  applicationFactory().addModule(new TravelPlannerModule()).run();
}

class TravelPlannerModule extends Module {
  TravelPlannerModule() {
    bind(TravelPlannerController);
  }
}
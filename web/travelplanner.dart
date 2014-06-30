import 'dart:html';
import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';



void main() {
  applicationFactory().addModule(new TravelPlannerModule()).run();
}

class TravelPlannerModule extends Module {
  TravelPlannerModule() {
    bind(TravelPlannerController);
  }
}

@Controller(selector: '[todo-planner-controller]', publishAs: 'tp')
class TravelPlannerController {
  List<String> plans = ["Reise 1", "Reise 2"];
}

library add_travelplan_controller;

import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travelplan.dart';
import 'package:js/js.dart' as js;
import 'package:intl/intl.dart';
import 'package:TravelPlanner/model/travel_step.dart';

@Controller(selector: '[add-travelplan-controller]', publishAs: 'tp2')
class AddTravelPlanController {
  final plansFirebase = new js.Proxy(js.context.Firebase, 'https://travel-planner-dart.firebaseio.com/plans');
  final String datePattern = "dd.MM.yyyy";
  Router router;
  
  String name;
  String fromAsString;
  String toAsString;
  
  bool isValid = true;
  
  Function callback = () {
    print("it works!");
  };
  
  TravelPlan plan = new TravelPlan(null, null, null, null);
  
  AddTravelPlanController(this.router);
  
  void add() {
    
    DateTime from;
    DateTime to;
    try {
      from = new DateFormat(datePattern).parse(fromAsString);
      to = new DateFormat(datePattern).parse(toAsString);
    } on FormatException catch(e, stacktrace) {
      isValid = false;
    }
    
    if(isValid) {
      plan.name = name;
      plan.from = from.millisecondsSinceEpoch;
      plan.to = to.millisecondsSinceEpoch;
      
      print("Generated map: ${plan.toMap()}");
      
      plansFirebase.push(js.map(plan.toMap()));
      this.router.go('view_default', {});
    }
  }
  
  void removeStep(TravelStep step) {
    plan.steps.remove(step);
  }
  
  void addStep() {
    plan.steps.add(new TravelStep());
  }
}

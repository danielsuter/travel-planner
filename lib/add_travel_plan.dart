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
  
  TravelStep step = new TravelStep();
  
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
      TravelPlan plan = new TravelPlan(null, name, from.millisecondsSinceEpoch, to.millisecondsSinceEpoch);
      plansFirebase.push(js.map(plan.toMap()));
      this.router.go('view_default', {});
    }
  }
  
  void cancel() {
    
  }
}

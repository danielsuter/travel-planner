library travel_plan_component;

import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travelplan.dart';
import 'package:js/js.dart' as js;
import 'package:TravelPlanner/model/travel_step.dart';
import 'package:TravelPlanner/util/date_util.dart';

@Component(
    selector: 'travel-plan',
    templateUrl: 'packages/TravelPlanner/travelplan/travel_plan_component.html',
    useShadowDom: false,
    publishAs: 'cmp')
class TravelPlanComponent {
  final plansFirebase = new js.Proxy(js.context.Firebase, 'https://travel-planner-dart.firebaseio.com/plans');
  Router router;
  
  String name;
  String fromAsString;
  String toAsString;
  
  bool isValid = true;
  
  TravelPlan plan = new TravelPlan(null, null, null, null); 
  
  TravelPlanComponent(this.router);
  
  void add() {
    
    DateTime from;
    DateTime to;
    try {
      from = DateUtil.DATE_FORMAT.parse(fromAsString);
      to = DateUtil.DATE_FORMAT.parse(toAsString);
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

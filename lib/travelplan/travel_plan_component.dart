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
  Scope scope;
  
  bool isValid = true;
  
  // Deprecated but impossible to replace, since the new syntax is not ready
  @NgTwoWay('plan')
  TravelPlan plan;
  
  TravelPlanComponent(this.router, this.scope) {

  }
  
  void add() {
    isValid = DateUtil.isValidDate(plan.from) && DateUtil.isValidDate(plan.to);
    
    if(isValid) {
      print("Generated map: ${plan.toMap()}");
      
      if(plan.id == null) {
        // Insert
        plansFirebase.push(js.map(plan.toMap()));
      } else {
        // Update
        plansFirebase.child(plan.id).set(js.map(plan.toMap()));
      }
      
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

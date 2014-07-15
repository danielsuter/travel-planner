library travel_plan_component;

import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travelplan.dart';
import 'package:TravelPlanner/model/travel_step.dart';
import 'package:TravelPlanner/util/date_util.dart';
import 'package:firebase/firebase.dart';

@Component(
    selector: 'travel-plan',
    templateUrl: 'packages/TravelPlanner/travelplan/travel_plan_component.html',
    useShadowDom: false,
    publishAs: 'cmp')
class TravelPlanComponent {
  final Firebase plansFirebase = new Firebase('https://travel-planner-dart.firebaseio.com/plans');
  
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
        plansFirebase.push().set(plan.toMap());
      } else {
        // Update
        Firebase child = plansFirebase.child(plan.id);
        child.set(plan.toMap());
      }
      
      this.router.go('view_default', {});
    }
  }
  
  void removeStep(TravelStep step) {
    plan.steps.remove(step);
  }
  
  
  void addStep() {
    var travelStep = new TravelStep();
    
    if(plan.steps.isEmpty) {
      travelStep.from = plan.from;
    } else {
      TravelStep previous = plan.steps.last;
      travelStep.from = previous.to;
    }
    
    plan.steps.add(travelStep);
  }
}


library todo_planner_controller;

import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travelplan.dart';
import 'package:js/js.dart' as js;
import 'package:TravelPlanner/model/travel_step.dart';
import 'package:TravelPlanner/model/transport_type.dart';
import 'package:TravelPlanner/model/travel_type.dart';
import 'dart:async';

@Controller(selector: '[todo-planner-controller]', publishAs: 'tp')
class TravelPlannerController {
  final plansFirebase = new js.Proxy(js.context.Firebase, 'https://travel-planner-dart.firebaseio.com/plans');
  
  Router router;
  Scope scope;
  
  List<TravelPlan> plans = [];
  
  TravelPlan selectedPlan;
  
  TravelPlannerController(this.router, this.scope) {
    print("controller travel called");
    plansFirebase.on('child_added', (snapshot, String previousChildName) {
      handleChildAdded(snapshot);
    });
    
    plansFirebase.on('child_removed', (snapshot, String previousChildName) {
      String id = snapshot.name();
      plans.removeWhere((plan) => plan.id == id);
    }); 
    
    plansFirebase.on('child_changed', (snapshot, String previousChildName) {
      handleChildChanged(snapshot);
    }); 
  }

  void handleChildChanged(snapshot) {
    new Future(() {
      print("child changed");
      TravelPlan travelPlan = mapTravelPlan(snapshot);
      
      TravelPlan oldPlan = plans.firstWhere((plan) => plan.id == travelPlan.id);
      int index = plans.indexOf(oldPlan);
      plans[index] = travelPlan;
    }).then((value) {
      scope.apply();
    });
  }

  void handleChildAdded(snapshot) {
    new Future((){
      var travelPlan = mapTravelPlan(snapshot);
      
      plans.add(travelPlan);
    }).then((value) {
      scope.apply();
    });
  }

  TravelPlan mapTravelPlan(snapshot) {
    String id = snapshot.name();
    
    final message = snapshot.val();
    print("Converting id: ${id} name: ${message.name} from: ${message.from} : to: ${message.to}...");
        
    var travelPlan = new TravelPlan(id, message.name, message.from, message.to);
    
    if(js.hasProperty(message, "steps")) {
      var steps = message.steps;
      for(int index = 0; index < steps.length; index++) {
        var step = steps[index];
        TravelStep travelStep = new TravelStep();
        travelStep.location = step.location;
        travelStep.to = step.to;
        travelStep.from = step.from;
        travelStep.transportType = TransportType.from(step.transportType);
        travelStep.travelType = TravelType.from(step.travelType);
        travelPlan.steps.add(travelStep);
      }
    }
    return travelPlan;
  }
  
  void addNew() {
    selectedPlan = new TravelPlan(null, null, null, null);
    router.go("add", {});
  }
  
  void edit(TravelPlan plan) {
    selectedPlan = plan;
    router.go("add", {});
  }
  
  void delete(TravelPlan planToDelete) {
    plansFirebase.child(planToDelete.id).set(null);
  }
}

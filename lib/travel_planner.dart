library todo_planner_controller;

import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travelplan.dart';
import 'package:js/js.dart' as js;
import 'package:TravelPlanner/model/travel_step.dart';
import 'package:TravelPlanner/model/transport_type.dart';
import 'package:TravelPlanner/model/travel_type.dart';
import 'dart:async';
import 'package:firebase/firebase.dart';

@Controller(selector: '[todo-planner-controller]', publishAs: 'tp')
class TravelPlannerController {
  final Firebase plansFirebase = new Firebase('https://travel-planner-dart.firebaseio.com/plans');
  
  Router router;
  Scope scope;
  
  List<TravelPlan> plans = [];
  
  TravelPlan selectedPlan;
  
  TravelPlannerController(this.router, this.scope) {
    print("controller travel called");
    
    plansFirebase.onChildAdded.listen((Event e) => handleChildAdded(e.snapshot));
    plansFirebase.onChildChanged.listen((Event e) => handleChildChanged(e.snapshot)); 
    plansFirebase.onChildRemoved.listen((Event e) => handleChildRemoved(e.snapshot)); 
  }

  void handleChildRemoved(DataSnapshot snapshot) {
    new Future(() {
      String id = snapshot.name();
      plans.removeWhere((plan) => plan.id == id);
    }).then((value) {
      scope.apply("cmp.plans");
    });
  }

  void handleChildChanged(DataSnapshot snapshot) {
    new Future(() {
      TravelPlan travelPlan = mapTravelPlan(snapshot);
      
      TravelPlan oldPlan = plans.firstWhere((plan) => plan.id == travelPlan.id);
      int index = plans.indexOf(oldPlan);
      plans[index] = travelPlan;
    }).then((value) {
      scope.apply("cmp.plans");
    });
  }

  void handleChildAdded(DataSnapshot snapshot) {
    new Future((){
      var travelPlan = mapTravelPlan(snapshot);
      
      plans.add(travelPlan);
    }).then((value) {
      scope.apply("cmp.plans");
    });
  }

  TravelPlan mapTravelPlan(DataSnapshot snapshot) {
    String id = snapshot.name();
    
    final Map<String, dynamic> message = snapshot.val();
    print("Converting message: ${message} with id $id");
        
    var travelPlan = new TravelPlan(id, message['name'], message['from'], message['to']);
    
    if(message['steps'] != null) {
      var steps = message['steps'];
      for(int index = 0; index < steps.length; index++) {
        var step = steps[index];
        TravelStep travelStep = new TravelStep();
        travelStep.location = step['location'];
        travelStep.to = step['to'];
        travelStep.description = step['description'];
        travelStep.from = step['from'];
        travelStep.travelType = TravelType.from(step['travelType']);
        var transportType = step['transportType'];
        if(transportType != null) {
          travelStep.transportType = TransportType.from(transportType);
        }
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

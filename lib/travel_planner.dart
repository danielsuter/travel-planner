library todo_planner_controller;

import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travelplan.dart';
import 'package:js/js.dart' as js;

@Controller(selector: '[todo-planner-controller]', publishAs: 'tp')
class TravelPlannerController {
  final plansFirebase = new js.Proxy(js.context.Firebase, 'https://travel-planner-dart.firebaseio.com/plans');
  
  Router router;
  
  List<TravelPlan> plans = [];
  
  TravelPlan selectedPlan;
  
  TravelPlannerController(this.router) {
    print("controller travel called");
    plansFirebase.on('child_added', (snapshot, String previousChildName) {
      String id = snapshot.name();
      
      final message = snapshot.val();
      print("Converting id: ${id} name: ${message.name} from: ${message.from} : to: ${message.to}...");
      
      plans.add(new TravelPlan(id, message.name, message.from, message.to));
    });
    
    plansFirebase.on('child_removed', (snapshot, String previousChildName) {
      String id = snapshot.name();
      plans.removeWhere((plan) => plan.id == id);
      print('removed child $id');
    }); 
    
    plansFirebase.on('child_changed', (snapshot, String previousChildName) {
      print("child changed, todo implement");
    }); 
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

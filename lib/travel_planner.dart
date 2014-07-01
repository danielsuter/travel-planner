library todo_planner_controller;

import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travelplan.dart';
import 'package:js/js.dart' as js;

@Controller(selector: '[todo-planner-controller]', publishAs: 'tp')
class TravelPlannerController {
  var dayInMiliseconds = 86400000;
  final plansFirebase = new js.Proxy(js.context.Firebase, 'https://travel-planner-dart.firebaseio.com/plans');

  List<TravelPlan> plans = [];

  TravelPlannerController() {
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
  }
  
  void add() {
    var now = new DateTime.now();
    var nowInMiliseconds = now.millisecondsSinceEpoch;
    plansFirebase.push(js.map({"name": 'Reise ${nowInMiliseconds}' , "from": nowInMiliseconds, "to": nowInMiliseconds}));
  }
  
  void delete(TravelPlan planToDelete) {
    plansFirebase.child(planToDelete.id).set(null);
  }
}

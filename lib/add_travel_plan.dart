library add_travelplan_controller;

import 'package:angular/angular.dart';
//import 'package:TravelPlanner/model/travelplan.dart';
//import 'package:js/js.dart' as js;

@Controller(selector: '[add-travelplan-controller]', publishAs: 'tp2')
class AddTravelPlanController {
//  final plansFirebase = new js.Proxy(js.context.Firebase, 'https://travel-planner-dart.firebaseio.com/plans');
  
  String test = "test";

  TravelPlannerController() {
    
//    plansFirebase.on('child_added', (snapshot, String previousChildName) {
//      final message = snapshot.val();
//      
//    });
  }
  
  void add() {
//    var now = new DateTime.now();
//    var nowInMiliseconds = now.millisecondsSinceEpoch;
//    plansFirebase.push(js.map({"name": 'Reise ${nowInMiliseconds}' , "from": nowInMiliseconds, "to": nowInMiliseconds}));
  }
  
  void cancel() {
    
  }
}

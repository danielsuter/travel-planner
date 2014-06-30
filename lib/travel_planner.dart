import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travelplan.dart';

@Controller(selector: '[todo-planner-controller]', publishAs: 'tp')
class TravelPlannerController {
  var dayInMiliseconds = 86400000;
  
  List<TravelPlan> plans = [];
  
  TravelPlannerController() {
    for(int i = 0; i < 10; i++) {
      var travelPlan = new TravelPlan("Plan $i", 1351441456747 - i * dayInMiliseconds, 1351441456747 + i * 2 * dayInMiliseconds);
      plans.add(travelPlan);
    }
  }
}
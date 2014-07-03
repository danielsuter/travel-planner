library travel_plan;

import 'package:TravelPlanner/model/travel_step.dart';

class TravelPlan {
  
  TravelPlan (this.id, this.name, this.from, this.to);
  
  String id;
  String name;
  String from;
  String to;
  
  List<TravelStep> steps = new List();
  
  Map toMap() {
    List<Map> jsSteps = [];
    steps.forEach((step) => jsSteps.add(step.toMap()));
    
    return {"name": name, "from": from, "to": to, "steps": jsSteps};
  }
}
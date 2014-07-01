library travel_plan;

import 'package:intl/intl.dart';
import 'package:TravelPlanner/model/travel_step.dart';

class TravelPlan {
  
  TravelPlan (this.id, this.name, this.from, this.to);
  
  String id;
  String name;
  int from;
  int to;
  
  List<TravelStep> steps = new List();
  
  // TODO not null getter for steps
  
  String getFromAsDate() {
    var dateFormat = new DateFormat("dd.MM.yyyy");
    return dateFormat.format(new DateTime.fromMillisecondsSinceEpoch(from));
  }
  
  String getToAsDate() {
    var dateFormat = new DateFormat("dd.MM.yyyy");
    return dateFormat.format(new DateTime.fromMillisecondsSinceEpoch(to));
  }
  
  Map toMap() {
    List<Map> jsSteps = [];
    steps.forEach((step) => jsSteps.add(step.toMap()));
    
    return {"name": name, "from": from, "to": to, "steps": jsSteps};
  }
}
import 'package:intl/intl.dart';
import 'package:TravelPlanner/model/TravelStep.dart';

class TravelPlan {
  
  TravelPlan (this.id, this.name, this.from, this.to);
  
  String id;
  String name;
  int from;
  int to;
  
  List<TravelStep> steps;
  
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
    return {"name": name, "from": from, "to": to};
  }
}
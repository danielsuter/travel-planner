import 'package:intl/intl.dart';

class TravelPlan {
  
  TravelPlan (this.name, this.from, this.to);
  
  String name;
  int from;
  int to;
  
  String getFromAsDate() {
    var dateFormat = new DateFormat("dd.MM.yyyy");
    return dateFormat.format(new DateTime.fromMillisecondsSinceEpoch(from));
  }
  
  String getToAsDate() {
    var dateFormat = new DateFormat("dd.MM.yyyy");
    return dateFormat.format(new DateTime.fromMillisecondsSinceEpoch(to));
  }
}
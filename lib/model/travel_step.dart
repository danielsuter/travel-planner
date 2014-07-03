library travel_step;

import 'package:TravelPlanner/model/travel_type.dart';
import 'package:TravelPlanner/model/transport_type.dart';
import 'package:intl/intl.dart';

class TravelStep {
//  String name;
  String location;

  int from;
  int to;
  
  TravelType travelType;
  TransportType transportType;
  
  String description;
  
  String getToAsDate() {
    if(to == 0 || to == null) {
      return "";
    }
    var dateFormat = new DateFormat("dd.MM.yyyy");
    return dateFormat.format(new DateTime.fromMillisecondsSinceEpoch(to));
  }
  
  String getFromAsDate() {
    if(from == 0 || from == null) {
      return "";
    }
    var dateFormat = new DateFormat("dd.MM.yyyy");
    return dateFormat.format(new DateTime.fromMillisecondsSinceEpoch(from));
  }
  
  Map toMap() {
    return {"location": location, "from": from, "to": to, "travelType": travelType.name, "transportType": transportType.name, "description": description};
  }
}
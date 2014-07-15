library travel_step;

import 'package:TravelPlanner/model/travel_type.dart';
import 'package:TravelPlanner/model/transport_type.dart';

class TravelStep {
  String location;

  String from;
  String to;
  
  TravelType travelType;
  TransportType transportType;
  
  String description;
  
  Map toMap() {
    return {"location": location, 
      "from": from, 
      "to": to, 
      "travelType": travelType.name, 
      "transportType": transportType == null ? "" : transportType.name, 
      "description": description == null ? "" : description};
  }
}
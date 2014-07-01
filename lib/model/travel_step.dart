library travel_step;

import 'package:TravelPlanner/model/travel_type.dart';
import 'package:TravelPlanner/model/transport_type.dart';

class TravelStep {
  String name;
  int from;
  int to;
  
  TravelType travelType;
  TransportType transportType;
  
  String location;
  
  String description;
}
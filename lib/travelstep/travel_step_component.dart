library travel_step_component;

import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travel_step.dart';
import 'package:intl/intl.dart';
import 'package:TravelPlanner/model/travel_type.dart';
import 'package:TravelPlanner/model/transport_type.dart';

@Component(
    selector: 'travel-step',
    templateUrl: 'packages/TravelPlanner/travelstep/travel_step_component.html',
    useShadowDom: false,
    publishAs: 'cmp')
class TravelStepComponent {
  Scope scope;
  
  var dateFormat = new DateFormat("dd.MM.yyyy");
  
  String from; 
  String to;
  String type; 
  String transport;
  
  // Deprecated but impossible to replace, since the new syntax is not ready
  @NgTwoWay('step')
  TravelStep step;
  
  List<TransportType> transportTypes = TransportType.values;
  
  
  TravelStepComponent(this.scope) {
    print("constructor of TravelStepComponent called");
    
    scope.watch("cmp.from", (newValue, oldValue) {
      if(isValidDate(newValue)) {
        DateTime date = dateFormat.parseUTC(newValue);
        step.from = date.millisecondsSinceEpoch;
        print("step.from is now ${step.from}");
      }
    });

    scope.watch("cmp.to", (newValue, oldValue) {
      if(isValidDate(newValue)) {
        DateTime date = dateFormat.parseUTC(newValue);
        step.to = date.millisecondsSinceEpoch;
        print("step.to is now ${step.to}");
      }
    });
    
    scope.watch("cmp.type", (newValue, oldValue) {
      if(newValue != null) {
        List<TravelType> values = TravelType.values;
        TravelType foundType = values.firstWhere((value) => value.name == newValue);
        step.travelType = foundType;
      }
    });
    
    scope.watch("cmp.transport", (newValue, oldValue) {
      if(newValue != null) {
        List<TransportType> values = TransportType.values;
        TransportType foundType = values.firstWhere((value) => value.name == newValue);
        step.transportType = foundType;
      }
    });
  }
  
 bool isValidDate(String dateAsString) {
    try {
      dateFormat.parse(dateAsString);
    } on FormatException catch(e, stacktrace) {
      return false;
    }
    return true;
  }
}

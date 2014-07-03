library travel_step_component;

import 'package:angular/angular.dart';
import 'package:TravelPlanner/model/travel_step.dart';
import 'package:TravelPlanner/model/travel_type.dart';
import 'package:TravelPlanner/model/transport_type.dart';

@Component(
    selector: 'travel-step',
    templateUrl: 'packages/TravelPlanner/travelstep/travel_step_component.html',
    useShadowDom: false,
    publishAs: 'cmp')
class TravelStepComponent extends AttachAware {
  Scope scope;
  
  String type; 
  String transport;
  
  // Deprecated but impossible to replace, since the new syntax is not ready
  @NgTwoWay('step')
  TravelStep step;
  
  List<TransportType> transportTypes = TransportType.values;
  
  
  TravelStepComponent(this.scope) {
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

  @override
  void attach() {
    if(step != null) {
      type = step.travelType.name;
      transport = step.transportType.name;
    }
  }
}

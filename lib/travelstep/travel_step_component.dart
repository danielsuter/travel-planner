library travel_step_component;

import 'package:angular/angular.dart';

@Component(
    selector: 'travel-step',
    templateUrl: 'packages/TravelPlanner/travelstep/travel_step_component.html',
    useShadowDom: false,
    publishAs: 'cmp')
class TravelStepComponent {
  TravelStepComponent() {
    print("constructor of TravelStepComponent called");
  }
}
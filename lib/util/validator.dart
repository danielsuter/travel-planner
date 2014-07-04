import 'package:angular/angular.dart';
import 'package:TravelPlanner/util/date_util.dart';

@Decorator(selector: '[ng-model][vs-date]')
class VsDateValidator implements NgValidator {
  
  NgModel _model;
  String name = "vs-date";
  
  VsDateValidator(this._model) {
    _model.addValidator(this);
  }
  
  @override
  bool isValid(modelValue) {
    if(modelValue != null) {
      return DateUtil.isValidDate(modelValue);
    }
    return false;
  }

}
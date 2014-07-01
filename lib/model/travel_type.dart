library travel_type;

class TravelType {
  final _value;
  const TravelType._internal(this._value);
  toString() => 'Enum.$_value';
  
  static List<TravelType>  get values => [JOURNEY, STAY];
  String get name => _value;
  
  static TravelType from(String name) {
    return values.firstWhere((travelType) => travelType.name == name);
  }
  
  static const JOURNEY = const TravelType._internal('JOURNEY');
  static const STAY = const TravelType._internal('STAY');
}
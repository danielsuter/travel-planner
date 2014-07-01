library travel_type;

class TravelType {
  final _value;
  const TravelType._internal(this._value);
  toString() => 'Enum.$_value';

  static const JOURNEY = const TravelType._internal('JOURNEY');
  static const STAY = const TravelType._internal('STAY');
}
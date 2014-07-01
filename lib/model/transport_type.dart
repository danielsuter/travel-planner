library transport_type;

class TransportType {
  final _value;
  const TransportType._internal(this._value);
  toString() => 'Enum.$_value';
  String get name => _value;
  
  static List<TransportType>  get values => [FLIGHT, WALK, BYCYCLE, BUS, TRAIN, CAR];

  static TransportType from(String name) {
    return values.firstWhere((transportType) => transportType.name == name);
  }
  
  static const FLIGHT = const TransportType._internal('FLIGHT');
  static const WALK = const TransportType._internal('WALK');
  static const BYCYCLE = const TransportType._internal('BYCYCLE');
  static const BUS = const TransportType._internal('BUS');
  static const TRAIN = const TransportType._internal('TRAIN');
  static const CAR = const TransportType._internal('CAR');
}
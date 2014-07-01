library transport_type;

class TransportType {
  final _value;
  const TransportType._internal(this._value);
  toString() => 'Enum.$_value';

  static const FLIGHT = const TransportType._internal('FLIGHT');
  static const FEET = const TransportType._internal('FEET');
  static const BYCYCLE = const TransportType._internal('BYCYCLE');
  static const BUS = const TransportType._internal('BUS');
  static const TRAIN = const TransportType._internal('TRAIN');
    
}
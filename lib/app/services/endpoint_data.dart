import 'package:flutter/foundation.dart';

class EndpointData {
  EndpointData({@required this.value}) : assert(value != null);
  final int value;

  @override
  String toString() => 'value: $value';
}

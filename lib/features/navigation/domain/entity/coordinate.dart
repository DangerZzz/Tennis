import 'package:flutter/widgets.dart';

/// Factory for building coordinates.
typedef CoordinateBuilder = Widget Function(BuildContext context, Object? data);

/// Basic coordinate representation.
abstract class Coordinate {
  final String _value;
  final bool _inner;

  const Coordinate._(this._value, this._inner);

  @override
  String toString() => '$_value${_inner ? ' inner' : ''}';

  bool get isInner => _inner;

  String get name => _value;
}

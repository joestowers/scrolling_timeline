import 'package:flutter/foundation.dart';

abstract class Measurement implements Comparable<Measurement> {
  final num value;

  const Measurement({
    @required this.value,
  });

  double toDouble() => value.toDouble();

  int toInt() => value.toInt();

  int compareTo(Measurement other) {
    return value.compareTo(other?.value);
  }

  Measurement operator +(Measurement other);

  Measurement operator -(Measurement other);

  bool operator <(Measurement other);

  bool operator <=(Measurement other);

  bool operator >(Measurement other);

  bool operator >=(Measurement other);

  @override
  bool operator ==(Object other) {
    if (other is Measurement) {
      return value == other.value;
    }

    return false;
  }

  @override
  int get hashCode => value.hashCode;
}

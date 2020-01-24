import 'package:flutter/foundation.dart';

import 'measurement.dart';
import 'unit_system.dart';

class Volume extends Measurement {
  final UnitSystem system;

  const Volume({
    @required num value,
    this.system = UnitSystem.metric,
  })  : assert(value != null),
        assert(system != null),
        super(value: value);

  factory Volume.fromMetric(num value) => Volume(value: value);

  static Volume fromJson(num value) {
    if (value == null) return null;
    return Volume.fromMetric(value);
  }

  static final zero = Volume.fromMetric(0);

  Volume toMetric() {
    switch (system) {
      case UnitSystem.imperial:
        return Volume(
          system: UnitSystem.metric,
          value: value.gallonsToLiters(),
        );
      case UnitSystem.metric:
        return this;
      default:
        throw FallThroughError();
    }
  }

  Volume toImperial() {
    switch (system) {
      case UnitSystem.imperial:
        return this;
      case UnitSystem.metric:
        return Volume(
          system: UnitSystem.imperial,
          value: value.litersToGallons(),
        );
      default:
        throw FallThroughError();
    }
  }

  Volume toSystem(UnitSystem system) {
    switch (system) {
      case UnitSystem.imperial:
        return toImperial();
      case UnitSystem.metric:
        return toMetric();
      default:
        throw FallThroughError();
    }
  }

  num inMetric() {
    switch (system) {
      case UnitSystem.imperial:
        return value.gallonsToLiters();
      case UnitSystem.metric:
        return value;
      default:
        throw FallThroughError();
    }
  }

  num inImperial() {
    switch (system) {
      case UnitSystem.imperial:
        return value;
      case UnitSystem.metric:
        return value.litersToGallons();
      default:
        throw FallThroughError();
    }
  }

  num inSystem(UnitSystem system) {
    switch (system) {
      case UnitSystem.imperial:
        return inImperial();
      case UnitSystem.metric:
        return inMetric();
      default:
        throw FallThroughError();
    }
  }

  @override
  int compareTo(Measurement other) {
    if (other is Volume) {
      return super.compareTo(other.toSystem(system));
    } else {
      throw UnsupportedError('Cannot compare disparate measurements');
    }
  }

  Volume operator +(Measurement other) {
    if (other is Volume) {
      return Volume(value: value + other.inSystem(system));
    } else {
      throw UnsupportedError('Cannot operate disparate measurements');
    }
  }

  Volume operator -(Measurement other) {
    if (other is Volume) {
      return Volume(value: value - other.inSystem(system));
    } else {
      throw UnsupportedError('Cannot operate disparate measurements');
    }
  }

  bool operator <(Measurement other) {
    if (other is Volume) {
      return value < other.inSystem(system);
    } else {
      throw UnsupportedError('Cannot compare disparate measurements');
    }
  }

  bool operator <=(Measurement other) {
    if (other is Volume) {
      return value <= other.inSystem(system);
    } else {
      throw UnsupportedError('Cannot compare disparate measurements');
    }
  }

  bool operator >(Measurement other) {
    if (other is Volume) {
      return value > other.inSystem(system);
    } else {
      throw UnsupportedError('Cannot compare disparate measurements');
    }
  }

  bool operator >=(Measurement other) {
    if (other is Volume) {
      return value >= other.inSystem(system);
    } else {
      throw UnsupportedError('Cannot compare disparate measurements');
    }
  }

  @override
  bool operator ==(Object other) {
    if (other is Volume) {
      return super == other && system == other.system;
    }

    return false;
  }

  @override
  int get hashCode => value.hashCode ^ system.hashCode;
}

extension VolumeNum<T extends num> on T {
  static const gallonsMultiplier = 0.264172;
  static const litersMultiplier = 3.78541;

  double litersToGallons() {
    if (this == null) return null;

    return this * gallonsMultiplier;
  }

  double gallonsToLiters() {
    if (this == null) return null;

    return this * litersMultiplier;
  }
}

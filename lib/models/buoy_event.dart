import 'package:scrolling_timeline/models/volume.dart';

enum BuoyCategory { diswasher, toilet, bath, sink, gardenHose }

class BuoyEvent {
  DateTime start;
  Volume volume;
  BuoyCategory category;

  BuoyEvent({this.start, this.volume, this.category});
}

extension BuoyCategoryExt on BuoyCategory {
  String get label {
    switch (this) {
      case BuoyCategory.diswasher:
        return 'Dishwasher';
      case BuoyCategory.toilet:
        return 'Toilet';
      case BuoyCategory.bath:
        return 'Bath';
      case BuoyCategory.sink:
        return 'Sink';
      case BuoyCategory.gardenHose:
        return 'Garden Hose';
    }

    return '';
  }
}

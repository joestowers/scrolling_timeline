import 'dart:collection';
import 'package:meta/meta.dart';

typedef GroupedBy<K, V> = K Function(V);
typedef Sort<T> = int Function(T, T);

extension IterableExt<E> on Iterable<E> {
  SplayTreeMap<K, List<E>> groupedSortedListBy<K>({
    @required GroupedBy<K, E> groupByKey,
    Sort<K> groupSort,
    Sort<E> elementSort,
  }) {
    final _groupSort = groupSort ?? _defaultCompare();
    final _elementSort = elementSort ?? _defaultCompare();
    final map = SplayTreeMap<K, List<E>>(_groupSort);
    final list = List.of(this, growable: false);
    list.sort(_elementSort);
    list.forEach((v) {
      final key = groupByKey(v);
      final list = map.putIfAbsent(key, () => []);
      list.add(v);
    });
    return map;
  }

  Map<K, List<E>> groupedListBy<K>({@required GroupedBy<K, E> groupByKey}) {
    final map = Map<K, List<E>>();
    final list = List<E>.from(this, growable: false);
    list.forEach((v) {
      final key = groupByKey(v);
      final list = map.putIfAbsent(key, () => []);
      list.add(v);
    });
    return map;
  }
}

int _dynamicCompare(dynamic a, dynamic b) =>
    Comparable.compare(a as Comparable, b as Comparable);
Comparator<K> _defaultCompare<K>() {
  final compare = Comparable.compare;
  if (compare is Comparator<K>) {
    return compare as Comparator<K>;
  }
  return _dynamicCompare;
}

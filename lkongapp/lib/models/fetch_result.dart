import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'fetch_result.g.dart';

abstract class Identifiable {
  String get id;
}

abstract class FetchResult<T> {
  int get nexttime;
  int get curtime;
  BuiltList<T> get data;
}

abstract class FetchList<T>
    implements Built<FetchList<T>, FetchListBuilder<T>> {
  FetchList._();

  factory FetchList([updates(FetchListBuilder<T> b)]) =>
      _$FetchList<T>((FetchListBuilder<T> b) => b
        ..loading = false
        ..current = 0
        ..nexttime = 0
        ..newcount = 0
        ..update(updates));

  bool get loading;
  int get nexttime;
  int get current;
  int get newcount;

  @nullable
  String get lastError;

  BuiltList<T> get data;
}

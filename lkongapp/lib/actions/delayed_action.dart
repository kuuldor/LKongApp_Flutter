import 'package:meta/meta.dart';

class DelayedAction {
  final Duration delayed;
  final int key;
  DateTime fireTime;
  final dynamic action;

  DelayedAction({
    @required this.delayed,
    @required this.key,
    @required this.action,
  }) {
    fireTime = DateTime.now().add(delayed);
  }
}

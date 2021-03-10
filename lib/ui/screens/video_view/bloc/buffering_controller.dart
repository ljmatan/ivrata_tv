import 'dart:async';

abstract class BufferingController {
  static bool _buffering;
  static bool get buffering => _buffering;

  static StreamController _streamController;

  static void init() {
    _streamController = StreamController.broadcast();
    _buffering = false;
  }

  static Stream get stream => _streamController.stream;

  static void change(value) {
    _streamController.add(value);
    _buffering = value;
  }

  static void dispose() {
    _streamController.close();
    _buffering = null;
  }
}

import 'dart:async';

abstract class MainViewController {
  static StreamController _streamController;

  static void init() => _streamController = StreamController.broadcast();

  static Stream get stream => _streamController.stream;

  static void change(value) => _streamController.add(value);

  static void dispose() => _streamController.close();
}

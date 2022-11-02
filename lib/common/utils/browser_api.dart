// ignore_for_file: avoid_web_libraries_in_flutter

// Dart imports:
import 'dart:html';

final browserApi = BrowserApi._instance;

class BrowserApi {
  BrowserApi._();
  static final BrowserApi _instance = BrowserApi._();

  alert(String message) {
    window.alert(message);
  }

  final addEventListener = window.addEventListener;
  final removeEventListener = window.removeEventListener;

  static const kFocusEventType = 'focus';
  static const kBlurEventType = 'blur';
}

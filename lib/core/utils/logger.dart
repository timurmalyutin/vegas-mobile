import 'dart:developer' as dev;

abstract final class AppLogger {
  static void info(String message, {String tag = 'INFO'}) {
    dev.log('[$tag] $message');
  }

  static void warn(String message, {String tag = 'WARN'}) {
    dev.log('[$tag] $message');
  }

  static void error(Object error, {StackTrace? stackTrace, String tag = 'ERROR'}) {
    dev.log('[$tag] $error', stackTrace: stackTrace);
  }

  static void debug(String message, {String tag = 'DEBUG'}) {
    assert(() {
      dev.log('[$tag] $message');
      return true;
    }());
  }
}

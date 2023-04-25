import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final zkLogger = Logger();

void collectLog(String line) {
  //收集日志
}
void reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
  return FlutterErrorDetails(exception: "$obj $stack");
}

void zkRunZoneGuard(void Function() body) {
  final onError = FlutterError.onError;
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details);
    reportErrorAndLog(details);
  };
  runZonedGuarded(body, (error, stack) {
    zkLogger.e(" error = ${error.toString()}");
  },
      zoneSpecification: ZoneSpecification(
        //拦截应用内所有print
        print: (self, parent, zone, line) {
          parent.print(zone, "Intercepted: $line");
          collectLog(line);
        },
        //处理所有未被捕获的一场
        handleUncaughtError: (self, parent, zone, error, stackTrace) {
          parent.print(zone, '${error.toString()} $stackTrace');
          reportErrorAndLog(makeDetails(error, stackTrace));
        },
      ));
}

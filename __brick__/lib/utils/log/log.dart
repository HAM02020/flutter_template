import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// logger
final Logger zkLogger = Logger(printer: PrettyPrinter(colors: true,methodCount: 0,errorMethodCount: 8,lineLength: 120,printTime: false,printEmojis: true));

/// 收集日志
void collectLog(String line) {}

/// 上报错误和日志逻辑
void reportErrorAndLog(FlutterErrorDetails details) {}

/// 构建错误信息
FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  return FlutterErrorDetails(exception: "$obj $stack");
}

/// 错误处理方法
void _onError(Object error, StackTrace stackTrace) {
  zkLogger.e(" error = ${error.toString()}");
  reportErrorAndLog(makeDetails(error, stackTrace));
}

void zkRunZoneGuard(void Function() body) {
  final onError = FlutterError.onError;

  /// 接管Flutter Error
  FlutterError.onError = (FlutterErrorDetails details) {
    onError?.call(details);
    reportErrorAndLog(details);
  };

  runZonedGuarded(body, _onError,
      zoneSpecification: ZoneSpecification(
        //拦截应用内所有print
        print: (self, parent, zone, line) {
          parent.print(zone, line);
          collectLog(line);
        },
        //处理所有未被捕获的一场
        handleUncaughtError: (self, parent, zone, error, stackTrace) {
          parent.print(zone, '${error.toString()} $stackTrace');
          reportErrorAndLog(makeDetails(error, stackTrace));
        },
      ));
}

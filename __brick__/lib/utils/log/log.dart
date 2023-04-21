import 'dart:developer';

import 'package:flutter/foundation.dart';

void zkLog(Object? object) {
  if (kDebugMode) {
    log(object.toString());
  }
}

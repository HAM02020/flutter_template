import 'package:__brick__/pages/home.dart';
import 'package:__brick__/pages/second/second.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Routes {
  static FluroRouter router = FluroRouter();
  static String home = '/';
  static String second = '/second';

  static void configureRouters() {
    _define(home, handler: (context, paramaters) {
      return const MyHomePage(title: '');
    });

    _define(second, handler: (context, paramaters) {
      return const SecondPage();
    });

  }

  static void _define(String path,
      {required Widget? Function(BuildContext?, Map<String, List<String>>)
          handler,
      TransitionType transitionType = TransitionType.cupertino}) {
    router.define(path,
        handler: Handler(handlerFunc: handler), transitionType: transitionType);
  }
  
}

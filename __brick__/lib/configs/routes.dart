import 'package:{{name.snakeCase()}}/pages/home.dart';
import 'package:{{name.snakeCase()}}/pages/second.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

final GoRouter gRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage(
          title: '',
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'second',
          builder: (BuildContext context, GoRouterState state) {
            return const SecondPage();
          },
        ),
      ],
    ),
  ],
);

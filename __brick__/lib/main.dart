import 'dart:async';

import 'package:{{project_name.snakeCase()}}/app/app.dart';
import 'package:{{project_name.snakeCase()}}/app/bloc/app_bloc_oberver.dart';
import 'package:{{project_name.snakeCase()}}/app/bloc/user_settings/user_setting_bloc.dart';
import 'package:{{project_name.snakeCase()}}/app/route/routes.dart';
import 'package:{{project_name.snakeCase()}}/pages/demo/bloc/counter_bloc.dart';

import 'package:{{project_name.snakeCase()}}/utils/log/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  zkRunZoneGuard(() async {
    await init();
    runApp(const App());
  });
}

Future<void> init() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(const Duration(seconds: 3))
      .then((value) => FlutterNativeSplash.remove());
  await ScreenUtil.ensureScreenSize();
  Routes.configureRouters(Routes.router);
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  GetIt.I.registerSingleton<UserSettingCubit>(UserSettingCubit());
  GetIt.I.registerSingleton<CounterBloc>(CounterBloc());
  Bloc.observer = const AppBlocObserver();
}

import 'dart:async';

import 'package:__brick__/app/app.dart';
import 'package:__brick__/app/app_bloc_oberver.dart';
import 'package:__brick__/bloc/counter/counter_bloc.dart';
import 'package:__brick__/bloc/user_settings/user_setting_bloc.dart';
import 'package:__brick__/utils/log/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(const Duration(seconds: 3))
      .then((value) => FlutterNativeSplash.remove());
  await ScreenUtil.ensureScreenSize();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  GetIt.I.registerSingleton<UserSettingCubit>(UserSettingCubit());
  GetIt.I.registerSingleton<CounterBloc>(CounterBloc());
  Bloc.observer = const AppBlocObserver();

  zkRunZoneGuard(() => runApp(const App()));
}

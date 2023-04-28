import 'package:{{name.snakeCase()}}/app/app.dart';
import 'package:{{name.snakeCase()}}/app/app_bloc_oberver.dart';
import 'package:{{name.snakeCase()}}/bloc/counter/counter_bloc.dart';
import 'package:{{name.snakeCase()}}/bloc/user_settings/user_setting_bloc.dart';
import 'package:{{name.snakeCase()}}/utils/log/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  GetIt.I.registerSingleton<UserSettingCubit>(UserSettingCubit());
  GetIt.I.registerSingleton<CounterBloc>(CounterBloc());
  Bloc.observer = const AppBlocObserver();

  zkRunZoneGuard(() => runApp(const App()));
}

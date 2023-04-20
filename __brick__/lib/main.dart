import 'package:{{{name.snakeCase()}}}/bloc/app_bloc_oberver.dart';
import 'package:{{{name.snakeCase()}}}/configs/routes.dart';
import 'package:{{{name.snakeCase()}}}/cubit/user_setting_bloc.dart';
import 'package:{{{name.snakeCase()}}}/generated/l10n.dart';
import 'package:{{{name.snakeCase()}}}/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  GetIt.instance.registerSingleton<UserSettingCubit>(UserSettingCubit());
  Bloc.observer = const AppBlocObserver();
  runApp(BlocProvider(
    create: (context) => GetIt.instance.get<UserSettingCubit>(),
    child: BlocBuilder<UserSettingCubit, UserSettingState>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: state.themeData,
          routerConfig: gRouter,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: BlocProvider.of<UserSettingCubit>(context).state.locale,
          builder: EasyLoading.init(
            builder: (context, child) {
              ScreenUtil.init(context);
              return child!;
            },
          ),
        );
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

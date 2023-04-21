import 'package:{{name.snakeCase()}}/app/routes.dart';
import 'package:{{name.snakeCase()}}/bloc/user_settings/user_setting_bloc.dart';
import 'package:{{name.snakeCase()}}/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'color_schemes.g.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I.get<UserSettingCubit>(),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserSettingCubit, UserSettingState>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: state.themeMode,
          routerConfig: gRouter,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: state.locale,
          localeResolutionCallback: (locale, supportedLocales) {
            if (state.localMode == UserLocaleMode.system &&
                state.locale.languageCode != locale?.languageCode) {
              zkLog(
                  'locale?.languageCode=${locale?.languageCode}, state.local.languageCode=${state.locale.languageCode}, != ${locale?.languageCode != state.locale.languageCode}');
              BlocProvider.of<UserSettingCubit>(context).setLocale(locale!);
              return state.locale;
            }

            return locale!;
          },
          builder: EasyLoading.init(
            builder: (context, child) {
              ScreenUtil.init(context);
              return child!;
            },
          ),
        );
      },
    );
  }
}

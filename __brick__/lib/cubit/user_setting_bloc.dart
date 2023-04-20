import 'package:{{name.snakeCase()}}/configs/color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_setting_state.dart';

class UserSettingCubit extends Cubit<UserSettingState> with HydratedMixin {
  UserSettingCubit()
      : super(UserSettingState(
            themeData: lightTheme,
            locale: const Locale('zh'),
            key: "default key"));

  get isDarkMode => state.themeData == darkTheme;

  get isEnglish => state.locale.languageCode == 'en';

  void setKey(String key) {
    emit(UserSettingState(
        themeData: state.themeData, locale: state.locale, key: key));
  }

  void switchTheme() async {
    emit(UserSettingState(
        themeData: state.themeData == lightTheme ? darkTheme : lightTheme,
        locale: state.locale,
        key: state.key));
  }

  void switchLocale() {
    emit(UserSettingState(
        themeData: state.themeData,
        locale: state.locale.languageCode == 'en'
            ? const Locale('zh')
            : const Locale('en'),
        key: state.key));
  }

  @override
  UserSettingState? fromJson(Map<String, dynamic> json) {
    bool isDark = json["user_theme_isDark_value"];
    String locale = json["user_local_value"];
    String key = json["user_key_value"];
    return UserSettingState(
        themeData: isDark ? darkTheme : lightTheme,
        locale: Locale(locale),
        key: key);
  }

  @override
  Map<String, dynamic>? toJson(UserSettingState state) {
    return {
      "user_theme_isDark_value": state.themeData == darkTheme,
      "user_local_value": state.locale.languageCode,
      "user_key_value": state.key,
    };
  }
}

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_setting_state.dart';

class UserSettingCubit extends Cubit<UserSettingState> with HydratedMixin {
  Locale? systemLocale;

  UserSettingCubit() : super(UserSettingState(key: "default key"));

  @override
  void onChange(Change<UserSettingState> change) {
    //log('cur = ${change.currentState.localMode},next=${change.nextState.localMode}');
    super.onChange(change);
  }

  Locale? Function(Locale?, Iterable<Locale>)
      get handleLocaleResolutionCallback {
    return (locale, supportedLocales) {
      systemLocale = systemLocale ?? locale;
      if (state.localMode == UserLocaleMode.system &&
          systemLocale?.languageCode != state.locale.languageCode) {
        setLocale(systemLocale!);
      }
      return locale;
    };
  }

  void setKey(String key) {
    emit(UserSettingState(
        themeMode: state.themeMode,
        key: key,
        localMode: state.localMode,
        locale: state.locale));
  }

  void setLocaleMode(UserLocaleMode localeMode) {
    Locale locale = state.locale;
    switch (localeMode) {
      case UserLocaleMode.en:
        locale = const Locale('en');
        break;
      case UserLocaleMode.zh:
        locale = const Locale('zh');
        break;
      case UserLocaleMode.system:
        break;
      default:
        break;
    }
    emit(UserSettingState(
        themeMode: state.themeMode,
        key: state.key,
        localMode: localeMode,
        locale: locale));
  }

  void setLocale(Locale locale) {
    emit(UserSettingState(
        localMode: state.localMode,
        themeMode: state.themeMode,
        key: state.key,
        locale: locale));
  }

  void setTheme(ThemeMode theme) {
    emit(UserSettingState(
        localMode: state.localMode, themeMode: theme, key: state.key));
  }

  @override
  UserSettingState? fromJson(Map<String, dynamic> json) {
    UserLocaleMode localeMode = UserLocaleMode.system;
    switch (json["user_local_mode_value"]) {
      case 'zh':
        localeMode = UserLocaleMode.zh;
        break;
      case 'en':
        localeMode = UserLocaleMode.en;
        break;
      case 'system':
        localeMode = UserLocaleMode.system;
        break;
      default:
        localeMode = UserLocaleMode.system;
        break;
    }
    String key = json["user_key_value"];
    ThemeMode theMode = ThemeMode.system;
    switch (json["user_theme_mode_value"]) {
      case "ThemeMode.light":
        theMode = ThemeMode.light;
        break;
      case "ThemeMode.dark":
        theMode = ThemeMode.dark;
        break;
      case "ThemeMode.system":
        theMode = ThemeMode.system;
        break;
      default:
        break;
    }
    return UserSettingState(
      locale: Locale(json["user_locale_value"]),
      localMode: localeMode,
      themeMode: theMode,
      key: key,
    );
  }

  @override
  Map<String, dynamic>? toJson(UserSettingState state) {
    String localeModeStr = 'system';
    switch (state.localMode) {
      case UserLocaleMode.zh:
        localeModeStr = 'zh';
        break;
      case UserLocaleMode.en:
        localeModeStr = 'en';
        break;
      case UserLocaleMode.system:
        localeModeStr = 'system';
        break;
      default:
        localeModeStr = 'system';
        break;
    }
    return {
      "user_theme_mode_value": state.themeMode.toString(),
      "user_local_mode_value": localeModeStr,
      "user_locale_value": state.locale.languageCode.toString(),
      "user_key_value": state.key,
    };
  }
}

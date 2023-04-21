import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_setting_state.dart';

class UserSettingCubit extends Cubit<UserSettingState> with HydratedMixin {
  UserSettingCubit()
      : super(
            UserSettingState(userTheme: UserTheme.system, key: "default key"));

  @override
  void onChange(Change<UserSettingState> change) {
    //log('cur = ${change.currentState.localMode},next=${change.nextState.localMode}');
    super.onChange(change);
  }

  void setKey(String key) {
    emit(UserSettingState(userTheme: state.userTheme, key: key));
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
        userTheme: state.userTheme,
        key: state.key,
        localMode: localeMode,
        locale: locale));
  }

  void setLocale(Locale locale) {
    emit(UserSettingState(
        localMode: state.localMode,
        userTheme: state.userTheme,
        key: state.key,
        locale: locale));
  }

  void setTheme(UserTheme theme) {
    emit(UserSettingState(
        localMode: state.localMode, userTheme: theme, key: state.key));
  }

  @override
  UserSettingState? fromJson(Map<String, dynamic> json) {
    UserTheme userTheme = UserTheme.system;

    switch (json['user_theme_mode_value']) {
      case 'light':
        userTheme = UserTheme.light;
        break;
      case 'dark':
        userTheme = UserTheme.dark;
        break;
      default:
        userTheme = UserTheme.system;
        break;
    }
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

    return UserSettingState(
      localMode: localeMode,
      userTheme: userTheme,
      key: key,
    );
  }

  @override
  Map<String, dynamic>? toJson(UserSettingState state) {
    String themeModeStr = 'system';
    switch (state.userTheme) {
      case UserTheme.light:
        themeModeStr = 'light';
        break;
      case UserTheme.dark:
        themeModeStr = 'dark';
        break;
      case UserTheme.system:
        themeModeStr = 'system';
        break;
      default:
        themeModeStr = 'system';
        break;
    }
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
      "user_theme_mode_value": themeModeStr,
      "user_local_mode_value": localeModeStr,
      "user_key_value": state.key,
    };
  }
}

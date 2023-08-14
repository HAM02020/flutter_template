import 'dart:convert';

import 'package:{{project_name.snakeCase()}}/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_setting_state.dart';

class UserSettingCubit extends Cubit<UserSettingState> with HydratedMixin {
  Locale? _systemLocale;

  UserSettingCubit() : super(UserSettingState());

  @override
  void onChange(Change<UserSettingState> change) {
    //log('cur = ${change.currentState.localMode},next=${change.nextState.localMode}');
    super.onChange(change);
  }

  Locale? Function(Locale?, Iterable<Locale>)
      get handleLocaleResolutionCallback {
    return (locale, supportedLocales) {
      _systemLocale = _systemLocale ?? locale;
      if (state.localMode == UserLocaleMode.system &&
          _systemLocale?.languageCode != state.locale.languageCode &&
          S.delegate.supportedLocales.map((e) => e.languageCode).contains(_systemLocale!.languageCode)) {
        _setLocale(_systemLocale!);
      }
      return locale;
    };
  }

  void setLocaleMode(UserLocaleMode localeMode) {
    if (localeMode.name == "system"){
      emit(state.copyWith(localMode: localeMode));
    }else{
      emit(state.copyWith(localMode: localeMode, locale: Locale(localeMode.name)));
    }
    
  }

   void _setLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
    }

  void setTheme(ThemeMode theme) {
    emit(state.copyWith(themeMode: theme));
  }

  @override
  UserSettingState? fromJson(Map<String, dynamic> json) {
    return UserSettingState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserSettingState state) {
    return state.toMap();
  }
}

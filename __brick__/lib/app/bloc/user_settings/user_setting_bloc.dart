import 'dart:convert';

import 'package:__brick__/generated/l10n.dart';
import 'package:__brick__/utils/log/log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_setting_state.dart';

class UserSettingCubit extends Cubit<UserSettingState> with HydratedMixin {
  UserSettingCubit() : super(UserSettingState()){
    _observeLocale();
  }

  void setLocaleMode(UserLocaleMode localeMode) {
    zkLogger.d('setLocaleMode');
    if (localeMode == UserLocaleMode.system) {
      emit(state.copyWith(localMode: localeMode, locale: systemLocale));
    } else {
      emit(state.copyWith(
          localMode: localeMode, locale: Locale(localeMode.name)));
    }
  }

  void setThemeMode(ThemeMode theme) {
    emit(state.copyWith(themeMode: theme));
  }
  void setPrimaryColor(Color? color) {
    emit(state.copyWith(primary: () => color,));
  }

  void _observeLocale(){
    if (state.localMode == UserLocaleMode.system){
      setLocaleMode(UserLocaleMode.system);
    }
    PlatformDispatcher.instance.onLocaleChanged = (){
      if (state.localMode != UserLocaleMode.system) return;
      setLocaleMode(UserLocaleMode.system);
    };
  }

  Locale get systemLocale {
    final locales = PlatformDispatcher.instance.locales;
    late Locale supportLocale;
    try {
      supportLocale = locales
          .firstWhere((locale) => S.delegate.supportedLocales.contains(locale));
    } catch (_) {
      supportLocale = locales.firstWhere(
        (locale) => S.delegate.supportedLocales
            .map((e) => e.languageCode)
            .contains(locale.languageCode),
        orElse: () => const Locale('en'),
      );
    }
    return supportLocale;
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

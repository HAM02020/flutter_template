// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_setting_bloc.dart';

enum UserLocaleMode { en, zh, system }



class UserSettingState {
  final ThemeMode themeMode;
  final UserLocaleMode localMode;
  final Locale locale;

  UserSettingState({
    this.locale = const Locale('en'),
    this.localMode = UserLocaleMode.system,
    this.themeMode = ThemeMode.system,
  });

  UserSettingState copyWith({
    ThemeMode? themeMode,
    UserLocaleMode? localMode,
    Locale? locale,
  }) {
    return UserSettingState(
      themeMode: themeMode ?? this.themeMode,
      localMode: localMode ?? this.localMode,
      locale: locale ?? this.locale,
    );
  }
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'themeMode': themeMode.index,
      'localMode': localMode.index,
      'locale': locale.languageCode,
    };
  }

  factory UserSettingState.fromMap(Map<String, dynamic> map) {
    return UserSettingState(
      themeMode: ThemeMode.values[map["themeMode"]],
      localMode: UserLocaleMode.values[map["localMode"]],
      locale: Locale(map["locale"]),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSettingState.fromJson(String source) => UserSettingState.fromMap(json.decode(source) as Map<String, dynamic>);
}

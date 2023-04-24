part of 'user_setting_bloc.dart';

enum UserLocaleMode { en, zh, system }

class UserSettingState {
  final ThemeMode themeMode;
  final UserLocaleMode localMode;
  final String key;
  final Locale locale;

  UserSettingState(
      {this.locale = const Locale('en'),
      this.localMode = UserLocaleMode.system,
      this.themeMode = ThemeMode.system,
      required this.key});
}

part of 'user_setting_bloc.dart';

enum UserTheme { light, dark, system }

enum UserLocaleMode { en, zh, system }

class UserSettingState {
  final UserTheme userTheme;
  final UserLocaleMode localMode;
  final String key;
  final Locale locale;
  static Locale? systemLocale;

  ThemeMode get themeMode {
    switch (userTheme) {
      case UserTheme.light:
        return ThemeMode.light;
      case UserTheme.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  UserSettingState(
      {this.locale = const Locale('en'),
      this.localMode = UserLocaleMode.system,
      required this.userTheme,
      required this.key});
}

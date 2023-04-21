part of 'user_setting_bloc.dart';

enum UserTheme { light, dark, system }

enum UserLocaleMode { en, zh, system }

class UserSettingState {
  final UserTheme userTheme;
  final UserLocaleMode localMode;
  final Locale locale;
  final String key;

  // Locale get locale {
  //   switch (localMode) {
  //     case UserLocaleMode.zh:
  //       return const Locale('zh');
  //     case UserLocaleMode.en:
  //       return const Locale('en');
  //     default:
  //       return const Locale('en');
  //   }
  // }

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

  const UserSettingState(
      {this.localMode = UserLocaleMode.system,
      this.locale = const Locale('en'),
      required this.userTheme,
      required this.key});

  UserSettingState copyWith(
      {UserTheme? userTheme,
      Locale? locale,
      String? key,
      UserLocaleMode? userLocaleMode}) {
    return UserSettingState(
        userTheme: userTheme ?? this.userTheme,
        key: key ?? this.key,
        localMode: userLocaleMode ?? localMode);
  }
}

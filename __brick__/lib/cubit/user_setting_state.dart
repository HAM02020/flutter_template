part of 'user_setting_bloc.dart';

ThemeData darkTheme =
    ThemeData(useMaterial3: true, colorScheme: darkColorScheme);
ThemeData lightTheme =
    ThemeData(useMaterial3: true, colorScheme: lightColorScheme);

class UserSettingState {
  final ThemeData themeData;
  final String key;
  final Locale locale;
  const UserSettingState(
      {required this.themeData, required this.locale, required this.key});
}

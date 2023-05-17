import 'package:flutter/material.dart';

ThemeData darkTheme =
    ThemeData(useMaterial3: false, colorScheme: darkColorScheme);
ThemeData lightTheme =
    ThemeData(useMaterial3: false, colorScheme: lightColorScheme);

const Color kZKColorBlack = Color(0xFF292526);
const Color kZKColorGrey = Color(0xFFD9D9D6);
const Color kZKColorLogo1 = Color(0xFF7AC143);
const Color kZKColorLogo2 = Color(0xFF474B4F);
const Color kZKColorFirst = Color(0xFF6CB33F);
const Color kZKColorSecond = Color(0xFF50B88A);
const Color kZKColorThird = Color(0xFF47BCC6);

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: kZKColorFirst,
  onPrimary: Color(0xFFFFFFFF),
  //primaryContainer: Color(0xFFACF771),
  //onPrimaryContainer: Color(0xFF0B2000),
  secondary: kZKColorFirst,
  onSecondary: Color(0xFFFFFFFF),
  //secondaryContainer: Color(0xFFDAE7C9),
  //onSecondaryContainer: Color(0xFF141E0C),
  //tertiary: Color(0xFF386665),
  //onTertiary: Color(0xFFFFFFFF),
  //tertiaryContainer: Color(0xFFBBECEA),
  //onTertiaryContainer: Color(0xFF00201F),
  error: Color(0xFFBA1A1A),
  //errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  //onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFDFDF5),
  onBackground: Color(0xFF1A1C18),
  surface: Color(0xFFFDFDF5),
  onSurface: Color(0xFF1A1C18),
  //surfaceVariant: Color(0xFFE0E4D6),
  //onSurfaceVariant: Color(0xFF44483E),
  //outline: Color(0xFF74796D),
  //onInverseSurface: Color(0xFFF1F1EA),
  //inverseSurface: Color(0xFF2F312C),
  //inversePrimary: Color(0xFF91DA59),
  //shadow: Color(0xFF000000),
  //surfaceTint: Color(0xFF346B00),
  //outlineVariant: Color(0xFFC4C8BA),
  //scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: kZKColorFirst,
  onPrimary: Color(0xFF183800),
  primaryContainer: Color(0xFF265100),
  onPrimaryContainer: Color(0xFFACF771),
  secondary: kZKColorFirst,
  onSecondary: Color(0xFF29341F),
  secondaryContainer: Color(0xFF3F4A34),
  onSecondaryContainer: Color(0xFFDAE7C9),
  tertiary: Color(0xFFA0CFCE),
  onTertiary: Color(0xFF003736),
  tertiaryContainer: Color(0xFF1E4E4D),
  onTertiaryContainer: Color(0xFFBBECEA),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C18),
  onBackground: Color(0xFFE3E3DC),
  surface: Color(0xFF1A1C18),
  onSurface: Color(0xFFE3E3DC),
  surfaceVariant: Color(0xFF44483E),
  onSurfaceVariant: Color(0xFFC4C8BA),
  outline: Color(0xFF8E9286),
  onInverseSurface: Color(0xFF1A1C18),
  inverseSurface: Color(0xFFE3E3DC),
  inversePrimary: Color(0xFF346B00),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF91DA59),
  outlineVariant: Color(0xFF44483E),
  scrim: Color(0xFF000000),
);

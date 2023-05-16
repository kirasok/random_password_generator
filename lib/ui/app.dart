import 'package:dynamic_color/dynamic_color.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

import 'password_screen.dart';
import 'theme/colors.dart';

class MyApp extends StatelessWidget {
  ColorScheme _staticColorscheme(Brightness brightness) =>
      SeedColorScheme.fromSeeds(
          primaryKey: primaryColorSeed,
          secondaryKey: secondaryColorSeed,
          tertiaryKey: tertiaryColorSeed,
          brightness: brightness,
          tones: FlexTones.vivid(brightness));

  @override
  Widget build(BuildContext context) => DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) => MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightDynamic ?? _staticColorscheme(Brightness.light),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkDynamic ?? _staticColorscheme(Brightness.dark),
          ),
          home: PasswordPage(),
        ),
      );
}

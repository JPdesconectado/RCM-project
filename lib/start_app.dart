import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:random_color_generator/loading_screen.dart';
import 'package:random_color_generator/localization/language_configuration.dart';

/// Class to Generate Random Colors
class StartApp extends StatefulWidget {
  /// Generation for Screen
  const StartApp({super.key});

  /// function to update lang of app
  static void setLocale(BuildContext context, Locale locale) {
    final _StartAppState? state =
        context.findAncestorStateOfType<_StartAppState>();
    state?.setLocale(locale);
  }

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingScreen(),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: LanguageConfiguration.all,
    );
  }
}

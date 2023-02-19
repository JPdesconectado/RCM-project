import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color_generator/constants/number_const.dart';
import 'package:random_color_generator/features/random_generator/data/random_generator_repository.dart';
import 'package:random_color_generator/features/random_generator/domain/random_color_model.dart';
import 'package:random_color_generator/features/random_generator/widgets/screen_pattern_widget.dart';
import 'package:random_color_generator/localization/language_configuration.dart';
import 'package:random_color_generator/start_app.dart';
import 'package:random_color_generator/utils/providers/last_data_provider.dart';

/// Screen to control colors, lang and widgets
class RandomColorScreen extends StatefulWidget {
  /// constructor
  const RandomColorScreen({super.key});

  @override
  State<RandomColorScreen> createState() => _RandomColorState();
}

class _RandomColorState extends State<RandomColorScreen> {
  List<Color> _color = [];
  List<Color> _textColor = [];
  Locale lang = const Locale('en');
  List<Locale> locales = LanguageConfiguration.all;
  int _clicked = 0;

  Map<String, List<Color>> generateColors(int number) {
    final List<Color> colors = [];
    final List<Color> textColors = [];
    for (int i = 0; i < number; i++) {
      colors.add(
        Color((math.Random().nextDouble() * NumberConst.hexId).toInt())
            .withOpacity(1.0),
      );

      textColors.add(
        (ThemeData.estimateBrightnessForColor(colors[i]) == Brightness.dark)
            ? Colors.white
            : Colors.black,
      );
    }

    return {
      "colors": colors,
      "text_colors": textColors,
    };
  }

  Future<void> _randomColor() async {
    final Map<String, List<Color>> getColors =
        (_clicked % 5 == 0) ? generateColors(5) : generateColors(1);
    lang = locales[math.Random().nextInt(locales.length)];
    StartApp.setLocale(context, lang);
    setState(() {
      _clicked++;
      _color = getColors['colors']!;
      _textColor = getColors['text_colors']!;
    });

    final RandomColorModel rcm = RandomColorModel(
      lastLocale: lang,
      lastColor: _color.first,
      lastTextColor: _textColor.first,
    );

    await RandomGeneratorRepository().registerLastData(rcm);
  }

  @override
  void initState() {
    final RandomColorModel? rcm =
        Provider.of<LastDataProvider>(context, listen: false).rcm;

    if (rcm != null) {
      _color = [rcm.lastColor];
      _textColor = [rcm.lastTextColor];
      lang = rcm.lastLocale;
    } else {
      final Map<String, List<Color>> getColors = generateColors(1);
      _color = getColors['colors']!;
      _textColor = getColors['text_colors']!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _randomColor,
      child: ScreenPatternWidget(colors: _color, textColors: _textColor),
    );
  }
}

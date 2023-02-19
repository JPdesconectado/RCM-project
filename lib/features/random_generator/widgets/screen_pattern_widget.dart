import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:random_color_generator/constants/number_const.dart';

/// When the user clicks more than 10 times, this variation will be showed
class ScreenPatternWidget extends StatelessWidget {
  /// possible colors for containers
  final List<Color> colors;

  /// colors for text
  final List<Color> textColors;

  /// constructor
  const ScreenPatternWidget({
    super.key,
    required this.colors,
    required this.textColors,
  });

  @override
  Widget build(BuildContext context) {
    final List<AlignmentDirectional?> aligns = [
      null,
      null,
      AlignmentDirectional.topEnd,
      AlignmentDirectional.bottomEnd,
      AlignmentDirectional.bottomStart
    ];

    final List<double> heightList = [
      MediaQuery.of(context).size.height,
      MediaQuery.of(context).size.height,
      MediaQuery.of(context).size.height / NumberConst.spw2,
      MediaQuery.of(context).size.height / NumberConst.spw3,
      MediaQuery.of(context).size.height / NumberConst.spw2,
    ];

    final List<double> widthList = [
      0,
      0,
      MediaQuery.of(context).size.width / NumberConst.spw3,
      MediaQuery.of(context).size.width * NumberConst.spw2 / NumberConst.spw3,
      MediaQuery.of(context).size.width / NumberConst.spw3,
    ];

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            for (int i = 0; i < colors.length; i++)
              if (i < NumberConst.spw2) ...[
                Container(
                  color: colors.elementAt(i),
                  height: heightList.elementAt(i),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)?.heyThere ?? "Error",
                      style: TextStyle(
                        color: textColors.elementAt(i),
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Align(
                  alignment: aligns.elementAt(i) ?? AlignmentDirectional.topEnd,
                  child: Container(
                    color: colors.elementAt(i),
                    width: widthList.elementAt(i),
                    height: heightList.elementAt(i),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)?.heyThere ?? "Error",
                        style: TextStyle(
                          color: textColors.elementAt(i),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
          ],
        ),
      ),
    );
  }
}

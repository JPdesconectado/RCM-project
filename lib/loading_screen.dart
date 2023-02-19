import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color_generator/constants/number_const.dart';
import 'package:random_color_generator/features/random_generator/domain/random_color_model.dart';
import 'package:random_color_generator/features/random_generator/screen/random_color_screen.dart';
import 'package:random_color_generator/start_app.dart';
import 'package:random_color_generator/utils/providers/last_data_provider.dart';

/// screen to reload last data when the user has closed the app,
/// with this they can continue where stopped
class LoadingScreen extends StatefulWidget {
  /// constructor
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    verifyConnectionAndGetData().whenComplete(() {
      Navigator.of(context).push<RandomColorScreen>(_createRoute());
    });
    super.initState();
  }

  Route<RandomColorScreen> _createRoute() {
    return PageRouteBuilder<RandomColorScreen>(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RandomColorScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              "RCG",
              style: TextStyle(
                color: Colors.white,
                fontSize: 100,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyConnectionAndGetData() async {
    await Provider.of<LastDataProvider>(context, listen: false)
        .loadValues()
        .whenComplete(() {
      final RandomColorModel? rcm =
          Provider.of<LastDataProvider>(context, listen: false).rcm;

      if (rcm != null) {
        final Locale lang = rcm.lastLocale;
        StartApp.setLocale(context, lang);
      }
    });

    await Future<void>.delayed(
      const Duration(milliseconds: NumberConst.milisec),
    );
  }
}

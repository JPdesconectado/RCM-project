import 'package:random_color_generator/features/random_generator/domain/random_color_model.dart';

/// interface to describe functions to work on models
abstract class RandomGeneratorRepositoryInterface {
  /// return last save data when the app are closed
  Future<RandomColorModel?> getLastData();

  /// method to register data when the app is to be closed
  Future<void> registerLastData(RandomColorModel rcm);
}

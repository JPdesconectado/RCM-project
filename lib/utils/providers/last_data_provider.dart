import 'package:flutter/material.dart';
import 'package:random_color_generator/features/random_generator/data/random_generator_repository.dart';
import 'package:random_color_generator/features/random_generator/domain/random_color_model.dart';

/// Provider to load last data stored in local storage
class LastDataProvider with ChangeNotifier {
  RandomColorModel? _rcm;

  /// Random Color Model getter
  RandomColorModel? get rcm => _rcm;

  /// method to load data
  Future<void> loadValues() async {
    _rcm = await RandomGeneratorRepository().getLastData();
    notifyListeners();
  }
}

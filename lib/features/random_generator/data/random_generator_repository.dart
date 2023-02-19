import 'package:flutter/cupertino.dart';
import 'package:random_color_generator/features/random_generator/data/random_generator_repository_interface.dart';
import 'package:random_color_generator/features/random_generator/domain/random_color_model.dart';
import 'package:random_color_generator/utils/services/storage_service.dart';

/// class to access model and storage to get and store information
class RandomGeneratorRepository implements RandomGeneratorRepositoryInterface {
  @override
  Future<RandomColorModel?> getLastData() async {
    final StorageService storageService = StorageService();

    final String locale =
        await storageService.readSecureData('language') ?? 'en';

    final String color =
        await storageService.readSecureData('color') ?? "0xff0000ff";
    final String textColor =
        await storageService.readSecureData('textColor') ?? "0xff000000";

    final RandomColorModel rcm = RandomColorModel(
      lastLocale: Locale(locale),
      lastColor: Color(int.parse(color)),
      lastTextColor: Color(int.parse(textColor)),
    );

    return rcm;
  }

  @override
  Future<void> registerLastData(RandomColorModel rcm) async {
    final StorageService storageService = StorageService();
    await storageService.writeSecureData(rcm);
  }
}

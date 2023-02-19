import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_color_generator/start_app.dart';
import 'package:random_color_generator/utils/providers/last_data_provider.dart';

void main() {
  runApp(
    ListenableProvider(
      create: (_) => LastDataProvider(),
      child: const StartApp(),
    ),
  );
}

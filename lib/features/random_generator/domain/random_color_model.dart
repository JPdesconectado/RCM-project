import 'package:flutter/material.dart';

/// Model to work on storage
class RandomColorModel {
  /// last locale changed
  final Locale lastLocale;

  /// last color showed
  final Color lastColor;

  /// last text color showed
  final Color lastTextColor;

  /// constructor
  const RandomColorModel({
    required this.lastLocale,
    required this.lastColor,
    required this.lastTextColor,
  });
}

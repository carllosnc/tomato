import 'package:flutter/material.dart';

extension ColorsExtension on BuildContext {
  Color get pageBackground => Theme.of(this).colorScheme.surfaceContainer;
}

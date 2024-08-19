import 'package:flutter/material.dart';

extension TypographyExtension on String {
  Text get pageTitle => Text(
        toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      );

  Text get formLabel => Text(
        this,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      );

  Text get buttonLabel => Text(
        toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
          color: Colors.black,
        ),
      );
}

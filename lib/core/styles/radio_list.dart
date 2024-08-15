import 'package:flutter/material.dart';

extension RadioListStyle on BuildContext {
  dynamic get radioListShape => RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(this).colorScheme.onSurface.withOpacity(0.3),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(100),
      );
}

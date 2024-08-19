import 'package:flutter/cupertino.dart';

extension PaddingExtension on BuildContext {
  EdgeInsets get formPadding => const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      );
}

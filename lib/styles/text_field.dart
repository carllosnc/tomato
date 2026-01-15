import 'package:flutter/material.dart';

textFieldDecoration({
  required hintText,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white.withValues(alpha: 0.4),
      fontWeight: FontWeight.normal,
    ),
    fillColor: Colors.white.withValues(alpha: 0.1),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    suffixIcon: Icon(
      Icons.edit_outlined,
      color: Colors.white.withValues(alpha: 0.3),
    ),
  );
}

textFieldStyle() {
  return const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

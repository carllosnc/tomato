import 'package:flutter/material.dart';

textFieldDecoration({
  required hintText,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(0.4),
      fontWeight: FontWeight.normal,
    ),
    fillColor: Colors.white.withOpacity(0.1),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: BorderSide.none,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
    ),
  );
}

textFieldStyle() {
  return const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

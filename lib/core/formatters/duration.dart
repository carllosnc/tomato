extension DurationExtension on Duration {
  String formatToHHMM() {
    String twoDigitMinutes = inMinutes.remainder(60).toString();
    String twoDigitSeconds = inSeconds.remainder(60).toString().padLeft(2, '0');

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

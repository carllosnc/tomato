part of './pomo.dart';

extension PomoHeader on PomoState {
  Column header() {
    return Column(
      children: [
        Text(
          showStatus(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 30),
        Text(
          widget.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white54,
          ),
        ),
        const SizedBox(height: 5),
        Wrap(
          spacing: 10,
          children: [
            Text(
              "Focus: ${formatDurationDescription(widget.workDuration)}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
              ),
            ),
            const Text("•"),
            Text(
              "Relax: ${formatDurationDescription(widget.relaxDuration)}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

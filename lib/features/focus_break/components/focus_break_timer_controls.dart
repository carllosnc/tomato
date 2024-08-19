import '/imports.dart';
import 'package:flutter/material.dart';

class FocusBreakControls extends StatefulWidget {
  const FocusBreakControls({super.key});

  @override
  State<FocusBreakControls> createState() => _FocusBreakControlsState();
}

class _FocusBreakControlsState extends State<FocusBreakControls>
    with SharedState {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: "Autoplay",
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              focusBreakState.autoplay
                  ? Colors.yellowAccent
                  : Colors.white.withOpacity(0.20),
            ),
          ),
          icon: Icon(
            Icons.loop,
            color: focusBreakState.autoplay ? Colors.black : Colors.white,
          ),
          iconSize: 25,
          onPressed: () {
            focusBreakState.toggleAutoplay(context);
          },
        ),
        IconButton(
          tooltip: focusBreakState.isRunning ? "Pause" : "Play",
          icon: Icon(
            focusBreakState.isRunning ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          iconSize: 80,
          onPressed: () {
            focusBreakState.toggleAction();
          },
        ),
        IconButton(
          tooltip: "Reset timer",
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              Colors.white.withOpacity(0.20),
            ),
          ),
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          iconSize: 25,
          onPressed: () {
            focusBreakState.resetAll(context: context);
          },
        ),
      ],
    );
  }
}

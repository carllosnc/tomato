import 'package:flutter/material.dart';
import '/imports.dart';

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
        //autoplay button
        IconButton(
          tooltip: "Autoplay",
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              timerFocusState.autoplay
                  ? Colors.yellowAccent
                  : Colors.white.withOpacity(0.20),
            ),
          ),
          icon: Icon(
            Icons.loop,
            color: timerFocusState.autoplay ? Colors.black : Colors.white,
          ),
          iconSize: 25,
          onPressed: () {
            timerFocusState.toggleAutoplay(context);
          },
        ),

        IconButton(
          tooltip: timerFocusState.isRunning ? "Pause" : "Play",
          icon: Icon(
            timerFocusState.isRunning ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          iconSize: 80,
          onPressed: () {
            timerFocusState.toggleAction();
          },
        ),

        //reset button
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
            timerFocusState.resetAll(context: context);
          },
        ),
      ],
    );
  }
}

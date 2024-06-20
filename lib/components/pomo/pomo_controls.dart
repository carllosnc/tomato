import 'package:flutter/material.dart';
import '/imports/app.dart';

class PomoControls extends StatefulWidget {
  const PomoControls({super.key});

  @override
  State<PomoControls> createState() => _PomoControlsState();
}

class _PomoControlsState extends State<PomoControls> with TimerMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //autoplay button
        IconButton(
          tooltip: "Autoplay",
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              timer.autoplay ? Colors.yellowAccent : Colors.white.withOpacity(0.20),
            ),
          ),
          icon: Icon(
            Icons.loop,
            color: timer.autoplay ? Colors.black : Colors.white,
          ),
          iconSize: 25,
          onPressed: () {
            timer.toggleAutoplay(context);
          },
        ),

        IconButton(
          tooltip: timer.isRunning ? "Pause" : "Play",
          icon: Icon(
            timer.isRunning ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          iconSize: 80,
          onPressed: () {
            timer.toggleAction();
          },
        ),

        //reset button
        IconButton(
          tooltip: "Reset timer",
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.white.withOpacity(0.20),
            ),
          ),
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          iconSize: 25,
          onPressed: () {
            timer.resetAll(context: context);
          },
        ),
      ],
    );
  }
}

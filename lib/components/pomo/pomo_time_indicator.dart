import 'package:flutter/material.dart';
import '/imports/app.dart';

class PomoTimerIndicator extends StatefulWidget {
  const PomoTimerIndicator({super.key});

  @override
  State<PomoTimerIndicator> createState() => _PomoTimerIndicatorState();
}

class _PomoTimerIndicatorState extends State<PomoTimerIndicator>
    with TimerMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: timer.percent.toDouble()),
              duration: const Duration(seconds: 1),
              builder: (context, double value, child) {
                return CircularProgressIndicator(
                  value: value,
                  strokeWidth: 3,
                  backgroundColor: Colors.white.withOpacity(0.20),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    timer.formatDuration(timer.currentDuration),
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight:
                          timer.isRunning ? FontWeight.w900 : FontWeight.w100,
                      color: timer.isRunning
                          ? Colors.yellowAccent
                          : Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

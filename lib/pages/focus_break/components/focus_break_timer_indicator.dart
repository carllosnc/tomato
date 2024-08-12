import 'package:flutter/material.dart';
import '/imports.dart';

class FocusBreakIndicator extends StatefulWidget {
  const FocusBreakIndicator({super.key});

  @override
  State<FocusBreakIndicator> createState() => _FocusBreakIndicatorState();
}

class _FocusBreakIndicatorState extends State<FocusBreakIndicator>
    with SharedState {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: focusBreakState.percent.toDouble()),
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
                    focusBreakState
                        .formatDuration(focusBreakState.currentDuration),
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: focusBreakState.isRunning
                          ? FontWeight.w900
                          : FontWeight.w100,
                      color: focusBreakState.isRunning
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

part of './pomo.dart';

extension PomoControls on PomoState {
  Row controls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //autoplay button
        IconButton(
          tooltip: "Autoplay",
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              autoplay ? Colors.yellowAccent : Colors.white.withOpacity(0.20),
            ),
          ),
          icon: Icon(
            Icons.loop,
            color: autoplay ? Colors.black : Colors.white,
          ),
          iconSize: 25,
          onPressed: toggleAutoplay,
        ),

        IconButton(
          tooltip: isRunning ? "Pause" : "Play",
          icon: Icon(
            isRunning ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
          ),
          iconSize: 80,
          onPressed: () {
            toggleAction();
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
            resetAll();
          },
        ),
      ],
    );
  }
}

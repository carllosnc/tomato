import 'package:flutter/material.dart';
import '/imports/app.dart';

class Welcome extends StatelessWidget {
  final Function onPressed;

  const Welcome({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.extendedLogo),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 65,
                  child: Image(
                    image: AssetImage(Assets.logo),
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Hora de focar.',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Tomato é o que você precisa para organizar seu tempo e focar no que importa.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      SharedPrefs().prefs.setBool('welcome', false);
                      onPressed();
                    },
                    child: const Text(
                      "COMEÇAR!",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

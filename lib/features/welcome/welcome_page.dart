import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vw/vw_column.dart';
import '/imports.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.extendedLogo),
            fit: BoxFit.cover,
          ),
        ),
        child: VWColumn(
          gap: 20,
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 40),
          verticalAlignment: MainAxisAlignment.end,
          horizontalAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              child: Image(
                image: AssetImage(Assets.logo),
              ),
            ),
            Column(
              children: [
                const Text(
                  'Time to focus.',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "It's simple: Focus. Break. Repeat.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () {
                sharedPreferences.prefs.setBool('welcome', false);
                context.go('/home');
              },
              child: const Text(
                "LET'S GO",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

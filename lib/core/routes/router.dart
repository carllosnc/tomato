import 'package:go_router/go_router.dart';
import '/imports.dart';

bool firstTime = sharedPreferences.prefs.getBool('welcome') ?? true;

String homePath = firstTime ? '/home' : '';

final router = GoRouter(
  routes: [
    if (firstTime)
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const WelcomePage();
        },
      ),
    GoRoute(
      path: firstTime ? '/home' : '/',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/focus_break',
      builder: (context, state) {
        return const FocusBreakPage();
      },
    ),
    GoRoute(
      path: '/multiple_timers',
      builder: (context, state) {
        return const MultipleTimersPage();
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) {
        return const SettingsPage();
      },
    ),
  ],
);

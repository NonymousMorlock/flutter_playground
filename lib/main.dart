import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  redirect: (_, state) {
    // Idk how you check but you can do it here, for me I'll just pass a
    // redirect extra
    final needsLocalAuth = state.extra == 'locked';
    if (needsLocalAuth) {
      return Uri(
        path: '/lock-screen',
        queryParameters: {'redirect': state.fullPath},
      ).toString();
      // OR
      // return '/lock-screen?redirect=${state.fullPath}';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/lock-screen',
      builder: (_, state) =>
          LockScreen(redirect: state.uri.queryParameters['redirect'] as String),
    ),
    GoRoute(
      path: '/',
      builder: (_, state) => const Home(),
    ),
    GoRoute(
      path: Screen2.path,
      builder: (_, state) => const Screen2(),
    ),
    ShellRoute(
      builder: (_, state, child) => SizedBox.shrink(),
      routes: [],
    ),
  ],
);

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}

class LockScreen extends StatelessWidget {
  const LockScreen({required this.redirect, super.key});

  final String redirect;

  @override
  Widget build(BuildContext context) {
    debugPrint(redirect);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () => context.go(redirect),
            child: Text('Auth Done User Verified'),
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  static const path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              context.go(Screen2.path, extra: 'locked');
            },
            child: Text('Go to screen2'),
          ),
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  static const path = '/screen-2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Screen 2')));
  }
}

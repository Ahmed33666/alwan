import 'package:go_router/go_router.dart';
import '../features/common/placeholder_screen.dart';
import '../features/home/home_screen.dart';
import '../features/shell/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(location: state.uri.path, child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/colours', builder: (_, __) => const PlaceholderScreen(title: 'Colours')),
        GoRoute(path: '/products', builder: (_, __) => const PlaceholderScreen(title: 'Products')),
        GoRoute(path: '/projects', builder: (_, __) => const PlaceholderScreen(title: 'My Projects')),
      ],
    ),
    // Full-screen, outside the shell (no bottom nav), like the reference app.
    GoRoute(path: '/visualize', builder: (_, __) => const PlaceholderScreen(title: 'Visualizer', dark: true)),
    GoRoute(path: '/finder', builder: (_, __) => const PlaceholderScreen(title: 'Colour Finder')),
    GoRoute(path: '/picker', builder: (_, __) => const PlaceholderScreen(title: 'Colour Picker', dark: true)),
    GoRoute(path: '/wall', builder: (_, __) => const PlaceholderScreen(title: 'Colour Wall')),
  ],
);

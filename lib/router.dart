import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'screens/book_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_shell_screen.dart';
import 'screens/my_books_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/reserve_screen.dart';
import 'screens/select_date_screen.dart';
import 'state/library_state.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/catalog',
  refreshListenable: libraryState,
  redirect: (context, state) {
    final uri = state.uri;

    // Нормалізація custom deep link: library://app/catalog/book/2 -> /catalog/book/2
    if (uri.scheme == 'library' && uri.host == 'app') {
      final targetPath = uri.path.isEmpty ? '/catalog' : uri.path;
      return uri.hasQuery ? '$targetPath?${uri.query}' : targetPath;
    }

    final location = uri.toString();
    final matchedLocation = state.matchedLocation;
    final isLoggingIn = matchedLocation == '/login';
    final isProtected = matchedLocation.endsWith('/reserve');

    if (isProtected && !libraryState.isLoggedIn) {
      return '/login?from=${Uri.encodeComponent(location)}';
    }

    if (isLoggingIn && libraryState.isLoggedIn) {
      final from = uri.queryParameters['from'];
      if (from != null && from.startsWith('/')) {
        return from;
      }
      return '/catalog';
    }

    return null;
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/catalog',
              builder: (context, state) {
                final genre = state.uri.queryParameters['genre'];
                return CatalogScreen(selectedGenre: genre);
              },
              routes: [
                GoRoute(
                  path: 'book/:bookId',
                  builder: (context, state) {
                    final bookId = state.pathParameters['bookId']!;
                    return BookScreen(bookId: bookId);
                  },
                  routes: [
                    GoRoute(
                      path: 'reserve',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final bookId = state.pathParameters['bookId']!;
                        return ReserveScreen(bookId: bookId);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/my-books',
              builder: (context, state) => const MyBooksScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final from = state.uri.queryParameters['from'];
        return LoginScreen(redirectTo: from);
      },
    ),
    GoRoute(
      path: '/select-date',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final initialDate = (state.extra as DateTime?) ??
            DateTime.now().add(const Duration(days: 14));
        return SelectDateScreen(initialDate: initialDate);
      },
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сторінку не знайдено (404)')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Маршрут "${state.uri}" не існує.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/catalog'),
                child: const Text('Повернутися до каталогу'),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
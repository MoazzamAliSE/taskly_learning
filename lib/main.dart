import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/tasks/presentation/pages/tasks_page.dart';
import 'features/stats/presentation/pages/stats_page.dart';
import 'features/settings/presentation/pages/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'app.title'.tr(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      themeMode: themeMode,
      routerConfig: _router,
      localizationsDelegates: context.localizationDelegates +
          [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _calculateSelectedIndex(state),
            onDestinationSelected: (index) {
              final currentLocation = state.uri.path;
              switch (index) {
                case 0:
                  context.go('/', extra: {'from': currentLocation});
                  break;
                case 1:
                  context.go('/tasks', extra: {'from': currentLocation});
                  break;
                case 2:
                  context.go('/stats', extra: {'from': currentLocation});
                  break;
                case 3:
                  context.go('/settings', extra: {'from': currentLocation});
                  break;
              }
            },
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: 'navigation.home'.tr(),
              ),
              NavigationDestination(
                icon: const Icon(Icons.task_outlined),
                selectedIcon: const Icon(Icons.task),
                label: 'navigation.tasks'.tr(),
              ),
              NavigationDestination(
                icon: const Icon(Icons.bar_chart_outlined),
                selectedIcon: const Icon(Icons.bar_chart),
                label: 'navigation.stats'.tr(),
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: 'navigation.settings'.tr(),
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const HomePage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: '/tasks',
          pageBuilder: (context, state) {
            final currentIndex = _calculateSelectedIndex(state);
            final previousIndex = _getPreviousIndex(state);
            return CustomTransitionPage(
              key: state.pageKey,
              child: const TasksPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final isForward = currentIndex > previousIndex;
                return SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: Offset(isForward ? 1.0 : -1.0, 0.0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeInOut)),
                  ),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: '/stats',
          pageBuilder: (context, state) {
            final currentIndex = _calculateSelectedIndex(state);
            final previousIndex = _getPreviousIndex(state);
            return CustomTransitionPage(
              key: state.pageKey,
              child: const StatsPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final isForward = currentIndex > previousIndex;
                return SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: Offset(isForward ? 1.0 : -1.0, 0.0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeInOut)),
                  ),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) {
            final currentIndex = _calculateSelectedIndex(state);
            final previousIndex = _getPreviousIndex(state);
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SettingsPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                final isForward = currentIndex > previousIndex;
                return SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: Offset(isForward ? 1.0 : -1.0, 0.0),
                      end: Offset.zero,
                    ).chain(CurveTween(curve: Curves.easeInOut)),
                  ),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Error: ${state.error}'),
    ),
  ),
);

int _calculateSelectedIndex(GoRouterState state) {
  final String location = state.uri.path;
  if (location.startsWith('/tasks')) return 1;
  if (location.startsWith('/stats')) return 2;
  if (location.startsWith('/settings')) return 3;
  return 0;
}

int _getPreviousIndex(GoRouterState state) {
  final String location = state.uri.path;
  final String previousLocation = state.uri.queryParameters['from'] ?? '/';
  if (previousLocation.startsWith('/tasks')) return 1;
  if (previousLocation.startsWith('/stats')) return 2;
  if (previousLocation.startsWith('/settings')) return 3;
  return 0;
}

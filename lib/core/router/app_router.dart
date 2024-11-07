import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:raptor/core/router/static_app_routes.dart';
import 'package:raptor/features/auth/presentation/pages/login_screen.dart';
import 'package:raptor/features/auth/presentation/pages/signup_screen.dart';

import '../../features/home/layout/layout_scaffold.dart';
import '../../features/home/layout/models/user.dart';
import '../../features/home/presentation/pages/explore_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/profile_page.dart';
import '../../features/home/presentation/pages/settings_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.signupScreen,
  routes: [
    GoRoute(path: Routes.loginScreen, pageBuilder: (context , state) => MaterialPage(child: LoginScreen())),
    GoRoute(path: Routes.signupScreen, pageBuilder: (context , state) => MaterialPage(child: SignUpScreen())),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutScaffold(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.homePage,
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.explorePage,
              builder: (context, state) => const ExplorePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settingsPage,
              builder: (context, state) => const SettingsPage(),
              routes: [
                GoRoute(
                    path: Routes.profilePage,
                    builder: (context, state) => ProfilePage(
                      user: state.extra as User,
                    )
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/auth/account_login/login_page.dart';
import 'pages/home_page.dart';
import 'pages/low_admin/low_admin_home.dart';
import 'pages/low_admin/settings.dart';
import 'pages/low_admin/user_v2.dart';
import 'pages/low_admin/users_list.dart';
import 'version_page.dart';

/// 使用 go_router 的路由器实例
final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) =>
          const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/version',
      name: 'version',
      builder: (context, state) => const VersionPage(),
    ),
    GoRoute(
      path: '/low_admin',
      name: 'low_admin',
      builder: (context, state) => const LowAdminHomePage(),
    ),
    GoRoute(
      path: '/low_admin/users',
      name: 'low_admin_users',
      builder: (context, state) => const UsersListPage(),
    ),
    GoRoute(
      path: '/low_admin/settings',
      name: 'low_admin_settings',
      builder: (context, state) => const LowAdminSettingsPage(),
    ),
    GoRoute(
      path: '/low_admin/user_v2/:id',
      name: 'user_v2',
      builder: (context, state) {
        // Use typed access to avoid dynamic invocation of a missing `params` on some go_router versions
        final idStr = state.pathParameters['id'];
        final id = int.tryParse(idStr?.toString() ?? '');
        if (id == null) {
          return const Scaffold(body: Center(child: Text('invalid id')));
        }
        return UserV2Page(userId: id);
      },
    ),
  ],
  errorBuilder: (context, state) {
    final dynamic s = state;
    final loc =
        (s.location is String
                ? s.location
                : (s.uri != null ? s.uri.toString() : '<unknown>'))
            ?.toString();
    return Scaffold(
      appBar: AppBar(title: Text(state.error?.toString() ?? 'Error')),
      body: Center(child: Text('找不到 $loc')),
    );
  },
);

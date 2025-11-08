import 'package:fl_app1/component/layout/simple_layout_with_menu_component.dart';
import 'package:fl_app1/page/system/settings/system_local_time_page.dart';
import 'package:fl_app1/page/system/settings/system_settings_page.dart';
import 'package:go_router/go_router.dart';

final RouteBase SystemShellRoute = ShellRoute(
  builder: (context, state, child) {
    return SimpleLayoutWithMenuComponent(title: '首页菜单栏', child: child);
  },
  routes: [
    GoRoute(
      path: '/system/settings',
      name: 'system_settings',
      builder: (context, state) => const SystemSettingsPage(),
    ),
    GoRoute(
      path: '/system/settings/local_time',
      name: 'system_local_time',
      builder: (context, state) => const SystemLocalTimePage(),
    ),
  ],
);

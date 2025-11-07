import 'package:fl_app1/pages/low_admin/low_admin_home.dart';
import 'package:fl_app1/pages/low_admin/settings.dart';
import 'package:fl_app1/pages/low_admin/user_bought_list.dart';
import 'package:fl_app1/pages/low_admin/user_pay_list.dart';
import 'package:fl_app1/pages/low_admin/user_v2.dart';
import 'package:fl_app1/pages/low_admin/users_list.dart';
import 'package:fl_app1/pages/system/system_view_default_const_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/simple_layout_with_menu.dart';

final aa = (
  builder: (context, state, child) {
    return SimpleLayoutWithMenu(title: '首页菜单栏', child: child);
  },
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) =>
          const SystemViewDefaultConst(),
    ),
  ],
);

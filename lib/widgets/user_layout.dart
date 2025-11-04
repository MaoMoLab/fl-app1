import 'package:flutter/material.dart';

import 'user_sidebar.dart';

class UserLayout extends StatelessWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;

  const UserLayout({super.key, required this.child, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? '用户中心'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        actions: actions,
      ),
      drawer: const UserSidebar(),
      body: child,
    );
  }
}

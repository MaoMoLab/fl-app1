import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LowAdminHomePage extends StatefulWidget {
  const LowAdminHomePage({super.key});

  @override
  State<LowAdminHomePage> createState() => _LowAdminHomePageState();
}

class _LowAdminHomePageState extends State<LowAdminHomePage> {
  int _selectedIndex = 0;

  final List<NavigationItem> _navItems = [
    NavigationItem(icon: Icons.dashboard, label: '仪表盘', route: '/low_admin'),
    NavigationItem(
      icon: Icons.people,
      label: '用户管理',
      route: '/low_admin/users',
    ),
    NavigationItem(
      icon: Icons.settings,
      label: '设置',
      route: '/low_admin/settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth >= 768;

        return Scaffold(
          appBar: AppBar(
            title: const Text('低权限管理后台'),
            leading: isLargeScreen
                ? null
                : IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
          ),
          drawer: isLargeScreen ? null : _buildDrawer(context),
          body: Row(
            children: [
              if (isLargeScreen) _buildNavigationRail(),
              Expanded(child: _buildContent()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.admin_panel_settings,
                  size: 48,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(height: 8),
                Text(
                  '管理后台',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ..._navItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return ListTile(
              leading: Icon(item.icon),
              title: Text(item.label),
              selected: _selectedIndex == index,
              onTap: () {
                setState(() => _selectedIndex = index);
                Navigator.pop(context);
                if (item.route != null) {
                  context.go(item.route!);
                }
              },
            );
          }),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('返回主页'),
            onTap: () {
              context.go('/');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() => _selectedIndex = index);
        final item = _navItems[index];
        if (item.route != null) {
          context.go(item.route!);
        }
      },
      labelType: NavigationRailLabelType.all,
      leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Icon(
          Icons.admin_panel_settings,
          size: 48,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      destinations: _navItems.map((item) {
        return NavigationRailDestination(
          icon: Icon(item.icon),
          label: Text(item.label),
        );
      }).toList(),
      trailing: Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: IconButton(
              icon: const Icon(Icons.home),
              tooltip: '返回主页',
              onPressed: () {
                context.go('/');
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard,
              size: 120,
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 32),
            Text(
              '欢迎使用低权限管理后台',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '请从左侧菜单选择功能',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              children: [
                _buildQuickActionCard(
                  context: context,
                  icon: Icons.people,
                  title: '用户管理',
                  description: '查看和编辑用户信息',
                  onTap: () {
                    setState(() => _selectedIndex = 1);
                    context.go('/low_admin/users');
                  },
                ),
                _buildQuickActionCard(
                  context: context,
                  icon: Icons.person_search,
                  title: '查看用户详情',
                  description: '输入用户ID查看详情',
                  onTap: () => _showUserIdDialog(context),
                ),
                _buildQuickActionCard(
                  context: context,
                  icon: Icons.settings,
                  title: '系统设置',
                  description: '配置系统参数',
                  onTap: () {
                    setState(() => _selectedIndex = 2);
                    context.go('/low_admin/settings');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showUserIdDialog(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    final router = GoRouter.of(context);

    final result = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('输入用户ID'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: '用户ID',
            hintText: '例如: 123',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final id = int.tryParse(controller.text.trim());
              Navigator.pop(context, id);
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (result != null) {
      if (!mounted) return;
      router.go('/low_admin/user_v2/$result');
    }
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String? route;

  NavigationItem({required this.icon, required this.label, this.route});
}

import 'package:fl_app1/component/bought_records/bought_records_list_component.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LowAdminUserBoughtListPage extends StatefulWidget {
  const LowAdminUserBoughtListPage({super.key});

  @override
  State<LowAdminUserBoughtListPage> createState() =>
      _LowAdminUserBoughtListPageState();
}

class _LowAdminUserBoughtListPageState
    extends State<LowAdminUserBoughtListPage> {
  final TextEditingController _userIdController = TextEditingController();
  String? _queryString;

  @override
  void initState() {
    super.initState();
    // 延迟读取URL参数，确保GoRouter已经初始化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadQueryFromUrl();
    });
  }

  void _loadQueryFromUrl() {
    final uri = GoRouterState.of(context).uri;
    final qParam = uri.queryParameters['q'];
    if (qParam != null && qParam.isNotEmpty) {
      // 解析 user_id:xxx 格式
      if (qParam.startsWith('user_id:')) {
        final userId = qParam.substring('user_id:'.length);
        _userIdController.text = userId;
      }
      setState(() {
        _queryString = qParam;
      });
    }
  }

  @override
  void dispose() {
    _userIdController.dispose();
    super.dispose();
  }

  void _searchByUserId() {
    final text = _userIdController.text.trim();
    setState(() {
      if (text.isEmpty) {
        _queryString = null;
      } else {
        final userId = int.tryParse(text);
        if (userId != null) {
          _queryString = 'user_id:$userId';
        } else {
          _queryString = null;
        }
      }
    });
  }

  void _clearFilter() {
    _userIdController.clear();
    setState(() {
      _queryString = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(
                    labelText: '用户ID',
                    hintText: '输入用户ID搜索，留空查询所有记录',
                    prefixIcon: const Icon(Icons.person_search),
                    suffixIcon: _userIdController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _userIdController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _searchByUserId(),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _searchByUserId,
                icon: const Icon(Icons.search),
                label: const Text('搜索'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _clearFilter,
                icon: const Icon(Icons.refresh),
                label: const Text('全部'),
              ),
            ],
          ),
        ),
        Expanded(
          child: BoughtRecordsListComponent(
            key: ValueKey(_queryString),
            q: _queryString,
            isShowActions: false,
            isEnableUserIdNavigation: true,
          ),
        ),
      ],
    );
  }
}

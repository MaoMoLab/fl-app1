import 'package:fl_app1/store/local_time_store.dart';
import 'package:flutter/material.dart';

class SystemLocalTimePage extends StatefulWidget {
  const SystemLocalTimePage({super.key});

  @override
  State<SystemLocalTimePage> createState() => _SystemLocalTimePageState();
}

class _SystemLocalTimePageState extends State<SystemLocalTimePage> {
  final LocalTimeStore _store = LocalTimeStore();
  final TextEditingController _controller = TextEditingController();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _ensureInit();
  }

  Future<void> _ensureInit() async {
    await _store.init();
    _controller.text = _store.fixedTimeZone ?? '';
    setState(() {
      _initialized = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() async {
    final val = _controller.text.trim();
    await _store.setFixedTimeZone(val.isEmpty ? null : val);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('已保存时区设置')));
  }

  void _clear() async {
    await _store.setFixedTimeZone(null);
    _controller.text = '';
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('已清除时区设置')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('本地时区设置')),
      body: _initialized
          ? Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('固定本软件使用的本地时区 (时区数据库标识，例如: UTC, Asia/Shanghai)'),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '时区标识',
                      hintText: '例如: Asia/Shanghai 或 UTC',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(onPressed: _save, child: const Text('保存')),
                      const SizedBox(width: 12),
                      TextButton(onPressed: _clear, child: const Text('清除')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('说明'),
                  const SizedBox(height: 6),
                  const Text('1) 如果不设置(为空)，应用将使用设备本地时间显示。'),
                  const SizedBox(height: 6),
                  const Text(
                    '2) 设置后应用会将此时区视为本地时区用于显示/比较/格式化（不改变API提交时间，仍请按 UTC 规则转换）。',
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

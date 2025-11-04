import 'package:fl_app1/api/models/admin_old_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef OnFieldUpdate = Future<bool> Function(String field, dynamic value);

class EditableUserOldServiceCard extends StatefulWidget {
  final AdminOldService? serviceData;
  final OnFieldUpdate onFieldUpdate;

  const EditableUserOldServiceCard({
    super.key,
    required this.serviceData,
    required this.onFieldUpdate,
  });

  @override
  State<EditableUserOldServiceCard> createState() =>
      _EditableUserOldServiceCardState();
}

class _EditableUserOldServiceCardState
    extends State<EditableUserOldServiceCard> {
  final Map<String, bool> _editingFields = {};
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, DateTime> _dateTimeValues = {};

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final localDateTime = dateTime.toLocal();
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(localDateTime);
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  int _parseBytes(String text) {
    final regex = RegExp(r'([\d.]+)\s*([KMGT]?B)');
    final match = regex.firstMatch(text.toUpperCase());
    if (match == null) return 0;

    final value = double.tryParse(match.group(1) ?? '0') ?? 0;
    final unit = match.group(2);

    switch (unit) {
      case 'B':
        return value.toInt();
      case 'KB':
        return (value * 1024).toInt();
      case 'MB':
        return (value * 1024 * 1024).toInt();
      case 'GB':
        return (value * 1024 * 1024 * 1024).toInt();
      case 'TB':
        return (value * 1024 * 1024 * 1024 * 1024).toInt();
      default:
        return value.toInt();
    }
  }

  double _calculateUsagePercent() {
    if (widget.serviceData == null ||
        widget.serviceData!.ssBandwidthTotalSize == 0) {
      return 0.0;
    }
    final used =
        widget.serviceData!.ssUploadSize + widget.serviceData!.ssDownloadSize;
    return (used / widget.serviceData!.ssBandwidthTotalSize).clamp(0.0, 1.0);
  }

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    if (widget.serviceData == null) return;

    final service = widget.serviceData!;
    _controllers['ssUploadSize'] = TextEditingController(
      text: _formatBytes(service.ssUploadSize),
    );
    _controllers['ssDownloadSize'] = TextEditingController(
      text: _formatBytes(service.ssDownloadSize),
    );
    _controllers['ssBandwidthTotalSize'] = TextEditingController(
      text: _formatBytes(service.ssBandwidthTotalSize),
    );
    _controllers['ssBandwidthYesterdayUsedSize'] = TextEditingController(
      text: _formatBytes(service.ssBandwidthYesterdayUsedSize),
    );
    _controllers['userLevel'] = TextEditingController(
      text: service.userLevel.toString(),
    );
    _controllers['nodeConnector'] = TextEditingController(
      text: service.nodeConnector.toString(),
    );
    _controllers['nodeSpeedLimit'] = TextEditingController(
      text: service.nodeSpeedLimit?.toString() ?? '',
    );
    _controllers['autoResetDay'] = TextEditingController(
      text: service.autoResetDay.toString(),
    );
    _controllers['autoResetBandwidth'] = TextEditingController(
      text: _formatBytes(service.autoResetBandwidth.toInt()),
    );
    _dateTimeValues['userLevelExpireIn'] = service.userLevelExpireIn;
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _toggleEdit(String field) async {
    if (_editingFields[field] == true) {
      setState(() {
        _editingFields[field] = false;
      });

      dynamic value;
      if (_dateTimeValues.containsKey(field)) {
        value = _dateTimeValues[field];
      } else if (_controllers.containsKey(field)) {
        final text = _controllers[field]!.text;
        if (field.contains('Size') || field == 'autoResetBandwidth') {
          value = _parseBytes(text);
        } else if (field == 'nodeSpeedLimit' && text.isEmpty) {
          value = null;
        } else {
          value = int.tryParse(text) ?? 0;
        }
      }

      final success = await widget.onFieldUpdate(field, value);

      if (success) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('数据修改成功: $field'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('数据修改失败: $field'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
          _initializeControllers();
          setState(() {});
        }
      }
    } else {
      setState(() {
        _editingFields[field] = true;
      });
    }
  }

  Future<void> _selectDateTime(String field) async {
    final currentDate = _dateTimeValues[field] ?? DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && mounted) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentDate),
      );

      if (pickedTime != null) {
        setState(() {
          _dateTimeValues[field] = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.serviceData == null) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Text('暂无服务信息', style: TextStyle(color: Colors.grey[600])),
          ),
        ),
      );
    }

    final service = widget.serviceData!;
    final usedBytes = service.ssUploadSize + service.ssDownloadSize;
    final usagePercent = _calculateUsagePercent();

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.cloud_circle, color: Theme.of(context).primaryColor),
                const SizedBox(width: 8),
                Text(
                  '服务信息',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(height: 24),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '流量使用情况',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '${(usagePercent * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: usagePercent > 0.9 ? Colors.red : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: usagePercent,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      usagePercent > 0.9
                          ? Colors.red
                          : usagePercent > 0.7
                          ? Colors.orange
                          : Colors.blue,
                    ),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '已用: ${_formatBytes(usedBytes)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        '总量: ${_formatBytes(service.ssBandwidthTotalSize)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildEditableInfoRow(
              'ssUploadSize',
              '上传流量',
              _formatBytes(service.ssUploadSize),
            ),
            _buildEditableInfoRow(
              'ssDownloadSize',
              '下载流量',
              _formatBytes(service.ssDownloadSize),
            ),
            _buildEditableInfoRow(
              'ssBandwidthTotalSize',
              '总流量',
              _formatBytes(service.ssBandwidthTotalSize),
            ),
            _buildEditableInfoRow(
              'ssBandwidthYesterdayUsedSize',
              '昨日使用',
              _formatBytes(service.ssBandwidthYesterdayUsedSize),
            ),
            _buildEditableInfoRow(
              'userLevel',
              '用户等级',
              'Level ${service.userLevel}',
            ),
            _buildDateTimeInfoRow(
              'userLevelExpireIn',
              '等级过期时间',
              _dateTimeValues['userLevelExpireIn']!,
            ),
            _buildInfoRow('最后使用时间', _formatDateTime(service.ssLastUsedTime)),
            _buildInfoRow('最后签到时间', _formatDateTime(service.lastCheckInTime)),
            _buildEditableInfoRow(
              'nodeConnector',
              '在线设备数',
              service.nodeConnector.toString(),
            ),
            _buildEditableInfoRow(
              'nodeSpeedLimit',
              '节点速率限制',
              service.nodeSpeedLimit != null
                  ? '${service.nodeSpeedLimit} Mbps'
                  : '无限制',
            ),
            _buildEditableInfoRow(
              'autoResetDay',
              '自动重置日',
              service.autoResetDay > 0 ? '每月 ${service.autoResetDay} 日' : '未设置',
            ),
            _buildEditableInfoRow(
              'autoResetBandwidth',
              '重置流量值',
              service.autoResetBandwidth > 0
                  ? _formatBytes(service.autoResetBandwidth.toInt())
                  : '未设置',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor,
                fontWeight: valueColor != null ? FontWeight.w500 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableInfoRow(String field, String label, String value) {
    final isEditing = _editingFields[field] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: isEditing
                ? TextField(
                    controller: _controllers[field],
                    decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType:
                        field.contains('Size') ||
                            field.contains('Level') ||
                            field.contains('Connector') ||
                            field.contains('Day')
                        ? TextInputType.number
                        : TextInputType.text,
                  )
                : Text(value),
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit, size: 20),
            onPressed: () => _toggleEdit(field),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeInfoRow(String field, String label, DateTime value) {
    final isEditing = _editingFields[field] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: isEditing
                ? InkWell(
                    onTap: () => _selectDateTime(field),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(_formatDateTime(_dateTimeValues[field])),
                    ),
                  )
                : Text(
                    _formatDateTime(value),
                    style: TextStyle(
                      color: value.isBefore(DateTime.now())
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit, size: 20),
            onPressed: () => _toggleEdit(field),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}

// filepath: /Users/inprtx/git/hub/InPRTx/fl_app1/lib/widgets/dashboard/subscription_card.dart

import 'package:fl_app1/utils/clipboard_utils.dart';
import 'package:flutter/material.dart';

/// 订阅卡片组件
class SubscriptionCard extends StatefulWidget {
  const SubscriptionCard({
    super.key,
    required this.subLinks,
    required this.shadowsocksPassword,
    required this.vmessPassword,
  });

  final List<String> subLinks;
  final String shadowsocksPassword;
  final String vmessPassword;

  @override
  State<SubscriptionCard> createState() => _SubscriptionCardState();
}

class _SubscriptionCardState extends State<SubscriptionCard> {
  int _selectedLinkIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasLinks = widget.subLinks.isNotEmpty;
    final selectedLink = hasLinks
        ? widget.subLinks[_selectedLinkIndex]
        : '暂无订阅链接';

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.vpn_key, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                const Text(
                  '订阅配置',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 订阅链接选择
                if (hasLinks && widget.subLinks.length > 1) ...[
                  const Text(
                    '选择订阅链接',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: List.generate(widget.subLinks.length, (index) {
                      return ChoiceChip(
                        label: Text('链接 ${index + 1}'),
                        selected: _selectedLinkIndex == index,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => _selectedLinkIndex = index);
                          }
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                ],

                // 订阅链接显示
                const Text(
                  '订阅链接',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          selectedLink,
                          style: const TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      if (hasLinks)
                        IconButton(
                          icon: const Icon(Icons.copy, size: 20),
                          onPressed: () =>
                              copyToClipboard(context, selectedLink),
                          tooltip: '复制链接',
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),

                // 配置密码信息
                const Text(
                  '配置信息',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),

                // Shadowsocks 密码
                _buildPasswordRow(
                  'Shadowsocks 密码',
                  widget.shadowsocksPassword,
                  Icons.security,
                ),
                const SizedBox(height: 12),

                // VMess UUID
                _buildPasswordRow(
                  'VMess UUID',
                  widget.vmessPassword,
                  Icons.fingerprint,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordRow(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : '暂无数据',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          if (value.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.copy, size: 18),
              onPressed: () => copyToClipboard(context, value),
              tooltip: '复制',
            ),
        ],
      ),
    );
  }
}

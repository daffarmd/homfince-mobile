import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationItem> _todayNotifications = [
    NotificationItem(
      icon: Icons.account_balance_wallet_rounded,
      iconColor: const Color(0xFF3B82F6),
      iconBgColor: const Color(0xFF1E293B),
      title: 'Salary Received',
      description: 'Your paycheck of \$3,200 arrived.',
      highlightText: '\$3,200',
      time: '10:00 AM',
      isUnread: true,
    ),
    NotificationItem(
      icon: Icons.warning_rounded,
      iconColor: const Color(0xFFF59E0B),
      iconBgColor: const Color(0xFFF59E0B).withOpacity(0.15),
      title: 'Budget Exceeded',
      description: 'Shopping category is 110% over budget.',
      highlightText: '110%',
      highlightColor: const Color(0xFF3B82F6),
      time: '2h ago',
      isUnread: true,
    ),
  ];

  final List<NotificationItem> _earlierNotifications = [
    NotificationItem(
      icon: Icons.receipt_long_rounded,
      iconColor: const Color(0xFF94A3B8),
      iconBgColor: const Color(0xFF1E293B),
      title: 'New Expense Added',
      description: 'Mom added \'Utilities\' - \$120.00',
      highlightText: '\$120.00',
      time: 'Yesterday',
      isUnread: false,
    ),
    NotificationItem(
      icon: Icons.lock_rounded,
      iconColor: const Color(0xFF94A3B8),
      iconBgColor: const Color(0xFF1E293B),
      title: 'Password Changed',
      description: 'Your account security was updated.',
      time: '2 days ago',
      isUnread: false,
    ),
    NotificationItem(
      icon: Icons.sync_rounded,
      iconColor: const Color(0xFF94A3B8),
      iconBgColor: const Color(0xFF1E293B),
      title: 'Recurring Transfer',
      description: 'Weekly savings transfer complete.',
      time: 'Oct 24',
      isUnread: false,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notification in _todayNotifications) {
        notification.isUnread = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Today Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: _markAllAsRead,
                    child: const Text(
                      'Mark all as read',
                      style: TextStyle(
                        color: Color(0xFF3B82F6),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Today Notifications
              ...List.generate(
                _todayNotifications.length,
                (index) => _buildNotificationTile(_todayNotifications[index]),
              ),
              const SizedBox(height: 24),
              // Earlier Section Header
              const Text(
                'Earlier',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Earlier Notifications
              ...List.generate(
                _earlierNotifications.length,
                (index) => _buildNotificationTile(_earlierNotifications[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTile(NotificationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: item.isUnread
            ? Border.all(color: const Color(0xFF3B82F6).withOpacity(0.2))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: item.iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (item.isUnread) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3B82F6),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                _buildDescriptionText(item),
              ],
            ),
          ),
          // Time
          Text(
            item.time,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionText(NotificationItem item) {
    if (item.highlightText == null) {
      return Text(
        item.description,
        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14, height: 1.4),
      );
    }

    final parts = item.description.split(item.highlightText!);
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14, height: 1.4),
        children: [
          if (parts.isNotEmpty) TextSpan(text: parts[0]),
          TextSpan(
            text: item.highlightText,
            style: TextStyle(
              color: item.highlightColor ?? const Color(0xFF3B82F6),
              fontWeight: FontWeight.bold,
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }
}

class NotificationItem {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String description;
  final String? highlightText;
  final Color? highlightColor;
  final String time;
  bool isUnread;

  NotificationItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.description,
    this.highlightText,
    this.highlightColor,
    required this.time,
    required this.isUnread,
  });
}

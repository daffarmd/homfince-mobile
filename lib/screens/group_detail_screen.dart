import 'package:flutter/material.dart';

class GroupDetailScreen extends StatelessWidget {
  const GroupDetailScreen({super.key});

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
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.home_rounded, color: Color(0xFF3B82F6), size: 20),
            SizedBox(width: 8),
            Text(
              'Family Finance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shared Balance Card
              _buildBalanceCard(),
              const SizedBox(height: 16),

              // Income & Expense Row
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Income', r'$4,200', '+12%', Icons.arrow_downward_rounded, const Color(0xFF22C55E)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard('Expense', r'$1,850', '-5%', Icons.arrow_upward_rounded, const Color(0xFFEF4444)),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Members Section
              _buildSectionHeader('Members', 'Manage'),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildMemberAvatar('https://api.dicebear.com/7.x/avataaars/svg?seed=Alice', 'Alice', isOnline: true),
                    const SizedBox(width: 16),
                    _buildMemberAvatar('https://api.dicebear.com/7.x/avataaars/svg?seed=Bob', 'Bob'),
                    const SizedBox(width: 16),
                    _buildMemberAvatar('https://api.dicebear.com/7.x/avataaars/svg?seed=Charlie', 'Charlie'),
                    const SizedBox(width: 16),
                    _buildInviteButton(),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Recent Activity Section
              _buildSectionHeader('Recent Activity', 'See all'),
              const SizedBox(height: 16),
              _buildActivityItem('Grocery Store', 'Alice • Today, 10:23 AM', r'-$124.50', Icons.shopping_cart_outlined, const Color(0xFFF97316)),
              _buildActivityItem('Netflix', 'Bob • Yesterday', r'-$15.99', Icons.movie_outlined, const Color(0xFFA855F7)),
              _buildActivityItem('Utility Bill', 'Alice • Oct 24', r'-$150.00', Icons.bolt_rounded, const Color(0xFF3B82F6)),
              _buildActivityItem('Refund', 'Charlie • Oct 22', r'+$45.00', Icons.money_rounded, const Color(0xFF22C55E), isPositive: true),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF3B82F6),
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.account_balance_wallet_outlined, color: Color(0xFF64748B), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Shared Balance',
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF334155),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'USD',
                  style: TextStyle(color: Color(0xFF3B82F6), fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            r'$12,450.00',
            style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                width: 40,
                height: 24,
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: Color(0xFF1E293B),
                      child: CircleAvatar(radius: 10, backgroundColor: Color(0xFFE2E8F0)),
                    ),
                    Positioned(
                      left: 14,
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFF1E293B),
                        child: CircleAvatar(radius: 10, backgroundColor: Color(0xFFCBD5E1)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Updated just now',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Analytics',
                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.bar_chart_rounded, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String amount, String distinct, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            amount,
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            distinct,
            style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          action,
          style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildMemberAvatar(String url, String name, {bool isOnline = false}) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: const Color(0xFF1E293B),
              child: const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFF334155),
                child: Icon(Icons.person, color: Colors.white70, size: 30),
              ),
            ),
            if (isOnline)
              Positioned(
                right: 0,
                bottom: 4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF0F172A), width: 2),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildInviteButton() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF334155), width: 1, style: BorderStyle.none),
          ),
          child: CustomPaint(
            painter: DashedCirclePainter(),
            child: const Center(
              child: Icon(Icons.add, color: Color(0xFF3B82F6), size: 28),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Invite',
          style: TextStyle(color: Color(0xFF3B82F6), fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
      String title, String subtitle, String amount, IconData icon, Color iconBgColor,
      {bool isPositive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor.withOpacity(0.2), // Transparent bg for icon
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconBgColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (!subtitle.contains('•')) ...[
                      // If no dot, assume it is simpler. But here we have avatar + Text for "Alice • Today..."
                      // Let's just parse logic for specific UI if needed
                      CircleAvatar(radius: 8, backgroundColor: Colors.grey[700], child: const Icon(Icons.person, size: 10, color: Colors.white)),
                      const SizedBox(width: 4),
                    ],
                     Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF94A3B8),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isPositive ? const Color(0xFF22C55E) : Colors.white, // Green for positive/redund/income
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double dashWidth = 5;
    final double dashSpace = 5;
    final paint = Paint()
      ..color = const Color(0xFF334155)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    final double circumference = 2 * 3.14159 * radius;
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();
    final double anglePerDash = 2 * 3.14159 / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final double startAngle = i * anglePerDash;
      final double sweepAngle = anglePerDash * (dashWidth / (dashWidth + dashSpace));
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

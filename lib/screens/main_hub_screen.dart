import 'package:flutter/material.dart';
import 'package:homfince/screens/notifications_screen.dart';
import 'package:homfince/screens/daily_summary_screen.dart';

import 'package:homfince/screens/monthly_summary_screen.dart';
import 'package:homfince/screens/activity_screen.dart';
import 'package:homfince/screens/add_transaction_screen.dart';
import 'package:homfince/screens/shared_finances_screen.dart';

class MainHubScreen extends StatefulWidget {
  const MainHubScreen({super.key});

  @override
  State<MainHubScreen> createState() => _MainHubScreenState();
}

class _MainHubScreenState extends State<MainHubScreen> {
  int _selectedIndex = 0;

  void _openNotifications() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const NotificationsScreen()),
    );
  }
  
  void _openDailySummary() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const DailySummaryScreen()),
    );
  }
  
  void _openMonthlySummary() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const MonthlySummaryScreen()),
    );
  }
  
  void _openAddTransaction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTransaction,
        backgroundColor: const Color(0xFF3B82F6),
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 1) {
      return const ActivityScreen();
    } else if (_selectedIndex == 2) {
      return const SharedFinancesScreen();
    }
    
    // Index 0 (Home) and others
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
                _buildHeader(),
                const SizedBox(height: 24),
                
                // Date & Report Buttons
                _buildActionBar(),
                const SizedBox(height: 24),
                
                // Total Balance Card
                _buildBalanceCard(),
                const SizedBox(height: 16),
                
                // Income & Expense Row
                Row(
                  children: [
                    Expanded(child: _buildSummaryCard('INCOME', r'$4,250', Icons.arrow_downward_rounded, const Color(0xFF22C55E))),
                    const SizedBox(width: 16),
                    Expanded(child: _buildSummaryCard('EXPENSE', r'$1,280', Icons.arrow_upward_rounded, const Color(0xFFEF4444))),
                  ],
                ),

                const SizedBox(height: 16),
                
                // Shared Finances Card
                _buildSharedFinancesCard(),
                const SizedBox(height: 32),
                
                // Recent Transactions Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Recent Transactions',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Row(
                        children: [
                          Text('See All', style: TextStyle(color: Color(0xFF3B82F6))),
                          Icon(Icons.chevron_right_rounded, color: Color(0xFF3B82F6), size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Transaction List
                _buildTransactionItem('Netflix', 'Entertainment', 'Sep 24', r'-$15.00', Icons.movie_outlined, const Color(0xFFEF4444)),
                _buildTransactionItem('Whole Foods', 'Groceries', 'Sep 22', r'-$85.50', Icons.shopping_cart_outlined, const Color(0xFFF59E0B)),
                _buildTransactionItem('Freelance Payment', 'Income', 'Sep 20', r'+$500.00', Icons.wallet_rounded, const Color(0xFF22C55E), isPositive: true),
                _buildTransactionItem('Uber', 'Transport', 'Sep 18', r'-$24.20', Icons.directions_car_outlined, const Color(0xFF3B82F6)),
                const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: const Color(0xFF1E293B),
          child: const Icon(Icons.person_rounded, color: Color(0xFF3B82F6), size: 28),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back,', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
            Text('Hello, John! 👋', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: _openNotifications,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.notifications_rounded, color: Colors.white, size: 24),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(color: const Color(0xFFEF4444), shape: BoxShape.circle, border: Border.all(color: const Color(0xFF0F172A), width: 2)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: _openDailySummary,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(100)),
            child: const Row(
              children: [
                Text('September 2023', style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
                SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF3B82F6)),
              ],
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: _openMonthlySummary,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(100)),
            child: const Row(
              children: [
                Icon(Icons.auto_graph_rounded, color: Color(0xFF3B82F6), size: 18),
                SizedBox(width: 8),
                Text('Laporan Keuangan', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFF1E293B), const Color(0xFF1E293B).withOpacity(0.8)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Balance', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
          const SizedBox(height: 8),
          const Text('\$14,235.00', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF22C55E).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.trending_up_rounded, color: Color(0xFF22C55E), size: 16),
                SizedBox(width: 4),
                Text('+2.4%', style: TextStyle(color: Color(0xFF22C55E), fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Text('vs last month', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String label, String amount, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 16),
          Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(amount, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSharedFinancesCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF3B82F6).withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF3B82F6)]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.people_alt_rounded, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Shared Finances', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 2),
              Text('Family Pool • \$2,450 avail', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(String title, String category, String date, String amount, IconData icon, Color iconColor, {bool isPositive = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1E293B).withOpacity(0.6), borderRadius: BorderRadius.circular(18)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('$category • $date', style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isPositive ? const Color(0xFF22C55E) : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      color: const Color(0xFF0F172A),
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_rounded, 'Home'),
            _buildNavItem(1, Icons.analytics_outlined, 'Activity'),
            const SizedBox(width: 40), // Space for FAB
            _buildNavItem(2, Icons.folder_open_rounded, 'Shared'),
            _buildNavItem(3, Icons.person_outline_rounded, 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8), size: 24),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8), fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

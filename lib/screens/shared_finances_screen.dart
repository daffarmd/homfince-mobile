import 'package:flutter/material.dart';
import 'package:homfince/screens/group_detail_screen.dart';

class SharedFinancesScreen extends StatelessWidget {
  const SharedFinancesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        automaticallyImplyLeading: false, 
        leading: Navigator.canPop(context) 
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: const Text(
          'Shared Finances',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFF3B82F6),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 16, color: Colors.white),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Filter Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _buildFilterTab('Active', isSelected: true),
                const SizedBox(width: 12),
                _buildFilterTab('Archived'),
                const SizedBox(width: 12),
                _buildFilterTab('Highest Balance'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Your Groups Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Groups',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.sort_rounded, color: const Color(0xFF94A3B8).withOpacity(0.8)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Groups List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildGroupCard(
                  context,
                  'Family Finance',
                  '4 Members • Active 2m ago',
                  r'$12,450.00',
                  Icons.home_rounded,
                  const Color(0xFF1E293B),
                  const Color(0xFF3B82F6),
                  [
                    'https://api.dicebear.com/7.x/avataaars/svg?seed=Alice',
                    'https://api.dicebear.com/7.x/avataaars/svg?seed=Bob',
                    'https://api.dicebear.com/7.x/avataaars/svg?seed=Charlie',
                  ],
                  extraCount: 1,
                ),
                _buildGroupCard(
                  context,
                  'With Partner',
                  '2 Members • Active 1h ago',
                  r'$3,200.50',
                  Icons.favorite_rounded,
                  const Color(0xFF3B1E29), // Darker pink bg
                  const Color(0xFFEC4899), // Pink icon
                  [
                     'https://api.dicebear.com/7.x/avataaars/svg?seed=Diana',
                     'https://api.dicebear.com/7.x/avataaars/svg?seed=Evan',
                  ],
                ),
                _buildGroupCard(
                  context,
                  'Apt 4B Roommates',
                  '3 Members • Active 1d ago',
                  r'-$150.00',
                  Icons.groups_rounded,
                  const Color(0xFF2E1E3B), // Darker purple bg
                  const Color(0xFFA855F7), // Purple icon
                  [
                     'https://api.dicebear.com/7.x/avataaars/svg?seed=Fiona',
                  ],
                  extraCount: 2,
                  isNegative: true,
                ),
                const SizedBox(height: 80), // Bottom padding
              ],
            ),
          ),
          
          // Create New Group Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Create New Group',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF94A3B8),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildGroupCard(
    BuildContext context,
    String title,
    String subtitle,
    String amount,
    IconData icon,
    Color iconBgColor,
    Color iconColor,
    List<String> avatarUrls, {
    int extraCount = 0,
    bool isNegative = false,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const GroupDetailScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconBgColor == const Color(0xFF1E293B) ? const Color(0xFF0F172A) : iconBgColor, // Slight adjustment for contrast if needed
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
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
                      // Quick fix for the subtitle coloring
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 12),
                          children: [
                            TextSpan(
                              text: subtitle.split('•')[0],
                              style: const TextStyle(color: Color(0xFF94A3B8)),
                            ),
                            const TextSpan(
                              text: ' • ',
                              style: TextStyle(color: Color(0xFF94A3B8)),
                            ),
                            TextSpan(
                              text: subtitle.split('•').length > 1 ? subtitle.split('•')[1] : '',
                              style: const TextStyle(color: Color(0xFF22C55E)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: Color(0xFF94A3B8)),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF334155), thickness: 1),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Avatars
                  SizedBox(
                    height: 36,
                    width: 100, // Fixed width to contain avatars
                    child: Stack(
                      children: [
                        for (int i = 0; i < avatarUrls.length; i++)
                          Positioned(
                            left: i * 24.0,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFF1E293B),
                              child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: const Color(0xFF334155),
                                  child: const Icon(Icons.person, size: 20, color: Colors.white70), // Placeholder for URL
                              ),
                            ),
                          ),
                        if (extraCount > 0)
                          Positioned(
                            left: avatarUrls.length * 24.0,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFF1E293B),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: const Color(0xFF334155),
                                child: Text(
                                  '+$extraCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                  // Balance
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        amount,
                        style: TextStyle(
                          color: isNegative ? const Color(0xFFEF4444) : const Color(0xFF3B82F6),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

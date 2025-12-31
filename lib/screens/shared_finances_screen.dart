import 'package:flutter/material.dart';
import 'package:homfince/screens/group_detail_screen.dart';
import 'package:homfince/screens/create_group_screen.dart';

class SharedFinancesScreen extends StatefulWidget {
  const SharedFinancesScreen({super.key});

  @override
  State<SharedFinancesScreen> createState() => _SharedFinancesScreenState();
}

enum SortOption { name, balanceHighToLow, balanceLowToHigh }

class GroupData {
  final String title;
  final String subtitle;
  final String amountStr;
  final double amountValue; // Helper for sorting
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final List<String> avatarUrls;
  final int extraCount;
  final bool isNegative;
  // Use a datetime or just an index for default order?
  // For 'Recent', we can rely on existing subtitle text parsing or just add a field.
  // I'll add a simple timestamp simulation
  final int lastActiveMinutesAgo;

  GroupData({
    required this.title,
    required this.subtitle,
    required this.amountStr,
    required this.amountValue,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.avatarUrls,
    this.extraCount = 0,
    this.isNegative = false,
    required this.lastActiveMinutesAgo,
  });
}

class _SharedFinancesScreenState extends State<SharedFinancesScreen> {
  String _selectedFilter = 'Active';
  SortOption _currentSortOption = SortOption.name; // Default

  // Initial Data
  final List<GroupData> _allGroups = [
    GroupData(
      title: 'Family Finance',
      subtitle: '4 Members • Active 2m ago',
      amountStr: r'$12,450.00',
      amountValue: 12450.00,
      icon: Icons.home_rounded,
      iconBgColor: const Color(0xFF1E293B),
      iconColor: const Color(0xFF3B82F6),
      avatarUrls: [
        'https://api.dicebear.com/7.x/avataaars/svg?seed=Alice',
        'https://api.dicebear.com/7.x/avataaars/svg?seed=Bob',
        'https://api.dicebear.com/7.x/avataaars/svg?seed=Charlie',
      ],
      extraCount: 1,
      lastActiveMinutesAgo: 2,
    ),
    GroupData(
      title: 'With Partner',
      subtitle: '2 Members • Active 1h ago',
      amountStr: r'$3,200.50',
      amountValue: 3200.50,
      icon: Icons.favorite_rounded,
      iconBgColor: const Color(0xFF3B1E29),
      iconColor: const Color(0xFFEC4899),
      avatarUrls: [
        'https://api.dicebear.com/7.x/avataaars/svg?seed=Diana',
        'https://api.dicebear.com/7.x/avataaars/svg?seed=Evan',
      ],
      lastActiveMinutesAgo: 60,
    ),
    GroupData(
      title: 'Apt 4B Roommates',
      subtitle: '3 Members • Active 1d ago',
      amountStr: r'-$150.00',
      amountValue: -150.00,
      icon: Icons.groups_rounded,
      iconBgColor: const Color(0xFF2E1E3B),
      iconColor: const Color(0xFFA855F7),
      avatarUrls: ['https://api.dicebear.com/7.x/avataaars/svg?seed=Fiona'],
      extraCount: 2,
      isNegative: true,
      lastActiveMinutesAgo: 1440,
    ),
  ];

  List<GroupData> get _filteredAndSortedGroups {
    List<GroupData> list = List.from(_allGroups);

    // Filter logic (Stub implementation since we don't really have archived status in data model yet)
    // "Highest Balance" tab acts like a preset sort?
    // Let's treat tabs as filters and Sort Icon as Sort.
    // If "Highest Balance" tab is selected, we override sort to Balance HighToLow?

    if (_selectedFilter == 'Highest Balance') {
      list.sort((a, b) => b.amountValue.compareTo(a.amountValue));
    } else {
      // Apply manual sort
      switch (_currentSortOption) {
        case SortOption.name:
          list.sort((a, b) => a.title.compareTo(b.title));
          break;
        case SortOption.balanceHighToLow:
          list.sort((a, b) => b.amountValue.compareTo(a.amountValue));
          break;
        case SortOption.balanceLowToHigh:
          list.sort((a, b) => a.amountValue.compareTo(b.amountValue));
          break;
      }
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final groups = _filteredAndSortedGroups;

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
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateGroupScreen(),
                ),
              );
            },
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
                _buildFilterTab('Active'),
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
                PopupMenuButton<SortOption>(
                  icon: Icon(
                    Icons.sort_rounded,
                    color: const Color(0xFF94A3B8).withValues(alpha: 0.8),
                  ),
                  color: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: SortOption.name,
                      child: Text(
                        'Name (A-Z)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const PopupMenuItem(
                      value: SortOption.balanceHighToLow,
                      child: Text(
                        'Balance (High-Low)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const PopupMenuItem(
                      value: SortOption.balanceLowToHigh,
                      child: Text(
                        'Balance (Low-High)',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  onSelected: (option) {
                    setState(() {
                      _currentSortOption = option;
                      // If user picks a sort manually, maybe switch filter to Active so it's obvious?
                      if (_selectedFilter == 'Highest Balance') {
                        _selectedFilter = 'Active';
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Groups List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: groups.length + 1, // +1 for extra padding at bottom
              itemBuilder: (context, index) {
                if (index == groups.length) {
                  return const SizedBox(height: 80);
                }
                final group = groups[index];
                return _buildGroupCard(context, group);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String label) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
          // If Highest Balance is clicked, auto-sort? The logical requirement is handled in getter
        });
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildGroupCard(BuildContext context, GroupData group) {
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
                    color: group.iconBgColor == const Color(0xFF1E293B)
                        ? const Color(0xFF0F172A)
                        : group.iconBgColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(group.icon, color: group.iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 12),
                          children: [
                            TextSpan(
                              text: group.subtitle.split('•')[0],
                              style: const TextStyle(color: Color(0xFF94A3B8)),
                            ),
                            const TextSpan(
                              text: ' • ',
                              style: TextStyle(color: Color(0xFF94A3B8)),
                            ),
                            TextSpan(
                              text: group.subtitle.split('•').length > 1
                                  ? group.subtitle.split('•')[1]
                                  : '',
                              style: const TextStyle(color: Color(0xFF22C55E)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF94A3B8)),
                  color: const Color(0xFF1E293B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text(
                            'Edit Group',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'archive',
                          child: Text(
                            'Archive Group',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'leave',
                          child: Text(
                            'Leave Group',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                  onSelected: (String value) {},
                ),
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
                    width: 100,
                    child: Stack(
                      children: [
                        for (int i = 0; i < group.avatarUrls.length; i++)
                          Positioned(
                            left: i * 24.0,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFF1E293B),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: const Color(0xFF334155),
                                child: const Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ),
                        if (group.extraCount > 0)
                          Positioned(
                            left: group.avatarUrls.length * 24.0,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFF1E293B),
                              child: CircleAvatar(
                                radius: 16,
                                backgroundColor: const Color(0xFF334155),
                                child: Text(
                                  '+${group.extraCount}',
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
                        group.amountStr,
                        style: TextStyle(
                          color: group.isNegative
                              ? const Color(0xFFEF4444)
                              : const Color(0xFF3B82F6),
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

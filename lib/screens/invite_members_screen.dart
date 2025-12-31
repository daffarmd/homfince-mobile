import 'package:flutter/material.dart';

class InviteMembersScreen extends StatelessWidget {
  final String groupName;
  final IconData groupIcon;

  const InviteMembersScreen({
    super.key,
    this.groupName = 'Family Finance',
    this.groupIcon = Icons.home_rounded, // Default icon if none passed
  });

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
          'Invite Members',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Logic to complete the process or go back to home
              // For now, maybe pop until home or push replacement
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text(
              'Done',
              style: TextStyle(
                color: Color(0xFF3B82F6),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Invite to',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  groupIcon,
                  size: 28,
                  color: const Color(0xFFEAB308),
                ), // Example color: Yellow/Orange per image somewhat? Actually image shows a house icon with colors. Let's stick to theme or passed icon.
                // In image it looks like a specific asset/emoji "House". I'll use the passed IconData but maybe color it or wrap it.
                // The image shows "Family Finance" in Blue.
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    groupName,
                    style: const TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Manage access and permissions for your shared finance group.',
              style: TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),

            // Email Address Input
            const Text(
              'Email Address',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF334155)),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'name@example.com',
                        hintStyle: TextStyle(
                          color: const Color(0xFF94A3B8).withOpacity(0.5),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF1E293B,
                    ), // Or lighter? Image shows input box with icon inside?
                    // Wait, image shows input box and the icon is inside the box on the right?
                    // "name@example.com [MailIcon]" - looks like it's inside the same row or a suffix icon.
                    // Let's use suffix icon for cleaner look.
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF334155)),
                  ),
                  child: const Icon(
                    Icons.mail_outline,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),

            // Correction: Image shows [Input field spanning full width? No wait.]
            // Image: "name@example.com" inside a box with a mail icon on the right inside a separate box?
            // Actually it looks like: [ Input Field ................ [Icon] ]
            // My default implementation above separates them.
            // Let's re-examine image.
            // Image shows: [     name@example.com        ] [Envelope Icon Button] - NO.
            // Image shows: [     name@example.com        |  [Envelope]  ] - looks like one container maybe?
            // Actually, let's look closer. "name@example.com" is in a big box. There is a vertical line separator? No.
            // The envelope icon is on the right.
            // I'll stick to a standard TextField with suffixIcon logic or a separate button if it's "Add from contacts".
            // The image has a separate small box for the icon. See the gap? It's small.
            // It looks like: [ TextField ] gap [ IconBox ].
            // I'll stick to what I wrote: Row(Expanded(TextField), SizedBox, Container(Icon)).
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Send Invitation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Divider(
                    color: const Color(0xFF334155).withOpacity(0.5),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'OR SHARE VIA LINK',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: const Color(0xFF334155).withOpacity(0.5),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Share Link Copier
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.link,
                      color: Color(0xFF3B82F6),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Invite Link',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'family-finance.app/invite/x8j9...',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF334155),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Copy',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Pending Invitations
            Row(
              children: [
                const Text(
                  'Pending Invitations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF334155),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Color(0xFF3B82F6),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildMemberTile(
              initials: 'SJ',
              color: const Color(0xFF4F46E5), // Indigo
              title: 'sarah.j@example.com',
              subtitle: 'Sent 2 days ago',
              trailingAction: TextButton(
                onPressed: () {},
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFFEF4444)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildMemberTile(
              initials: 'MT',
              color: const Color(0xFF10B981), // Emerald
              title: 'mike.t@example.com',
              subtitle: 'Sent yesterday',
              trailingAction: TextButton(
                onPressed: () {},
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFFEF4444)),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Current Members
            const Text(
              'Current Members',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildMemberTile(
              imageUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=You',
              title: 'You',
              subtitle: 'Owner',
              isYou: true,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberTile({
    String? initials,
    String? imageUrl,
    Color? color,
    required String title,
    required String subtitle,
    Widget? trailingAction,
    bool isYou = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: imageUrl != null
                  ? Colors.transparent
                  : (color ?? Colors.grey),
              border: Border.all(
                color: isYou ? const Color(0xFF3B82F6) : Colors.transparent,
                width: 2,
              ),
            ),
            child: imageUrl != null
                ? CircleAvatar(backgroundImage: NetworkImage(imageUrl))
                : Center(
                    child: Text(
                      initials ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isYou) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'ADMIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (trailingAction != null) trailingAction,
        ],
      ),
    );
  }
}

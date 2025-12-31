import 'package:flutter/material.dart';
import 'package:homfince/screens/invite_members_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // List of available icons for the group
  final List<IconData> _availableIcons = [
    Icons.flight,
    Icons.home,
    Icons.shopping_cart,
    Icons.pets,
    Icons.restaurant,
    Icons.directions_car,
    Icons.face,
    Icons.add, // Represents custom/more
  ];

  int _selectedIconIndex = 0; // Default to first icon (flight)

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
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
          'Create Shared Group',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // Big Icon Avatar
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF3B82F6).withOpacity(0.5),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF3B82F6).withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                        color: const Color(0xFF1E293B),
                      ),
                      child: Icon(
                        _availableIcons[_selectedIconIndex],
                        size: 48,
                        color: const Color(0xFF3B82F6),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF3B82F6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Group Name Input
              const Text(
                'Group Name',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'e.g. Family Trip',
                  hintStyle: TextStyle(
                    color: const Color(0xFF94A3B8).withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Description Input
              const Text(
                'Description (optional)',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'What is this group for?',
                  hintStyle: TextStyle(
                    color: const Color(0xFF94A3B8).withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1E293B),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Choose an Icon Label
              const Text(
                'Choose an Icon',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Icons Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: List.generate(_availableIcons.length, (index) {
                      final isSelected = _selectedIconIndex == index;
                      final isAddButton =
                          index ==
                          _availableIcons.length - 1; // Last one is '+'

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (!isAddButton) {
                              // only select if not the 'add' placeholder
                              _selectedIconIndex = index;
                            }
                            // If it's the add button, we might want to show a picker, but for now we'll just leave it.
                          });
                        },
                        child: Container(
                          width:
                              (constraints.maxWidth - (3 * 16)) /
                              4, // 4 items per row
                          height: (constraints.maxWidth - (3 * 16)) / 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(16),
                            border: isSelected
                                ? Border.all(
                                    color: const Color(0xFF3B82F6),
                                    width: 2,
                                  )
                                : isAddButton
                                ? Border.all(
                                    color: const Color(0xFF334155),
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ) // Dashed border is complex in basic flutter container
                                : null,
                          ),
                          // Determine the child. Specialized rendering for the 'Add' button if we want dashed border aesthetics.
                          child: isAddButton
                              ? CustomPaint(
                                  painter: DashedBorderPainter(),
                                  child: const Center(
                                    child: Icon(Icons.add, color: Colors.white),
                                  ),
                                )
                              : Center(
                                  child: Icon(
                                    _availableIcons[index],
                                    color: isSelected
                                        ? const Color(0xFF3B82F6)
                                        : const Color(0xFF94A3B8),
                                    size: 24,
                                  ),
                                ),
                        ),
                      );
                    }),
                  );
                },
              ),

              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Invite members in the next step',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
                ),
              ),

              const SizedBox(height: 16),

              // Create Group Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to create group
                    // Navigator.pop(context); // Go back for now
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InviteMembersScreen(
                          groupName: _nameController.text.isNotEmpty
                              ? _nameController.text
                              : 'New Group',
                          groupIcon: _availableIcons[_selectedIconIndex],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Create Group',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// Simple Painter for dashed border on the "Add" button
class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF334155)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(16),
    );

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

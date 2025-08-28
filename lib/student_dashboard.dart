import 'package:flutter/material.dart';
import 'department_screen.dart';
import 'profile_screen.dart';
import 'select_year_screen_student.dart'; // ✅ Added import

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard>
    with TickerProviderStateMixin {
  int _currentIndex = 2;
  final List<AnimationController> _controllers = [];
  final List<Animation<Offset>> _animations = [];
  final List<bool> _pressed = [];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.notifications_none, 'label': 'Alerts'},
    {'icon': Icons.explore, 'label': 'Explore'},
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.calendar_today, 'label': 'Activities'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  final List<Map<String, dynamic>> _tiles = [
    {"icon": Icons.menu_book, "title": "Departments", "subtitle": "Explore All"},
    {"icon": Icons.group, "title": "Faculty", "subtitle": "View Members"},
    {"icon": Icons.event, "title": "Events", "subtitle": "5 Upcoming"},
    {"icon": Icons.star, "title": "Results", "subtitle": "8.5 CGPA"},
    {"icon": Icons.check_box, "title": "Attendance", "subtitle": "92%"},
    {"icon": Icons.library_books, "title": "Library", "subtitle": "3 Issued"},
  ];

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startStaggeredAnimations();
  }

  void _initAnimations() {
    for (int i = 0; i < _tiles.length; i++) {
      final controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      final animation = Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
      _controllers.add(controller);
      _animations.add(animation);
      _pressed.add(false);
    }
  }

  void _startStaggeredAnimations() async {
    for (int i = 0; i < _controllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      _controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E00FF),
        title: const Text(
          "Student Dashboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProfileCard(),
            const SizedBox(height: 20),
            _buildDashboardGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navItems.length, (index) {
          final isSelected = index == _currentIndex;
          return GestureDetector(
            onTap: () {
              if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              } else {
                setState(() {
                  _currentIndex = index;
                });
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF7E00FF) : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _navItems[index]['icon'],
                    color: isSelected ? Colors.white : const Color(0xFF7E00FF),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _navItems[index]['label'],
                  style: TextStyle(
                    fontSize: 11,
                    color: const Color(0xFF7E00FF),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF7E00FF),
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Welcome to SNJB",
                style: TextStyle(color: Color(0xFF7E00FF), fontSize: 14),
              ),
              Text(
                "Jay Bagdane",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "75 | Computer Science | BE",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.bookmark_border, color: Color(0xFF7E00FF)),
        ],
      ),
    );
  }

  Widget _buildDashboardGrid() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _tiles.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return SlideTransition(
          position: _animations[index],
          child: GestureDetector(
            onTapDown: (_) {
              setState(() {
                _pressed[index] = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _pressed[index] = false;
              });
            },
            onTapCancel: () {
              setState(() {
                _pressed[index] = false;
              });
            },
            onTap: () {
              String title = _tiles[index]['title'];
              if (title == "Departments") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DepartmentScreen()),
                );
              } else if (title == "Attendance") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const select_year_screen_student()),
                );
              } else {
                debugPrint("Tapped on: $title");
              }
            },
            child: AnimatedScale(
              duration: const Duration(milliseconds: 150),
              scale: _pressed[index] ? 0.97 : 1.0,
              child: _buildDashboardTile(
                _tiles[index]['icon'],
                _tiles[index]['title'],
                _tiles[index]['subtitle'],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboardTile(IconData icon, String title, String subtitle) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF7E00FF), size: 36),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

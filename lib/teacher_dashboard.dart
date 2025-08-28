import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'select_year_screen_dept.dart';
import 'select_year_screen_teacher.dart'; // ✅ make sure file name matches this

class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard>
    with TickerProviderStateMixin {
  int _currentIndex = 2;
  late final AnimationController _animationController;
  late final List<Animation<Offset>> _slideAnimations;

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.notifications_none, 'label': 'Alerts'},
    {'icon': Icons.explore, 'label': 'Explore'},
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.calendar_today, 'label': 'Activities'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  final List<Map<String, dynamic>> _cardData = [
    {'icon': Icons.class_, 'title': 'My Classes', 'subtitle': '6 Classes'},
    {'icon': Icons.check_box, 'title': 'Attendance', 'subtitle': 'Mark Today'},
    {'icon': Icons.person, 'title': 'Student', 'subtitle': 'View All'},
    {'icon': Icons.assignment, 'title': 'Assignment', 'subtitle': '4 Pending'},
    {'icon': Icons.star, 'title': 'Results', 'subtitle': '8.5 CGPA'},
    {'icon': Icons.event_rounded, 'title': 'Time Table', 'subtitle': 'View Schedule'},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimations = List.generate(_cardData.length, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.4),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            1.0,
            curve: Curves.easeOut,
          ),
        ),
      );
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E00FF),
        title: const Text(
          "Teacher Dashboard",
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
            Container(
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
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFF7E00FF),
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Welcome to SNJB",
                        style: TextStyle(
                          color: Color(0xFF7E00FF),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Jay Bagdane",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Assistant Professor | CS",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.bookmark_border, color: Color(0xFF7E00FF)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1,
              children: List.generate(_cardData.length, (index) {
                final data = _cardData[index];
                return SlideTransition(
                  position: _slideAnimations[index],
                  child: AnimatedDashboardTile(
                    icon: data['icon'] as IconData,
                    title: data['title'] as String,
                    subtitle: data['subtitle'] as String,
                    onTap: () {
                      if (data['title'] == 'Attendance') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => select_year_screen_teacher(),
                          ),
                        );
                      } else {
                        debugPrint("${data['title']} tapped");
                      }
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
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
      ),
    );
  }
}

class AnimatedDashboardTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const AnimatedDashboardTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  State<AnimatedDashboardTile> createState() => _AnimatedDashboardTileState();
}

class _AnimatedDashboardTileState extends State<AnimatedDashboardTile> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0;
    });
    widget.onTap();
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeOut,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Container(
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
              Icon(widget.icon, color: const Color(0xFF7E00FF), size: 36),
              const SizedBox(height: 12),
              Text(widget.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(widget.subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:snjb_college/subject_attendance_student.dart'; // keep the same import path you use

class select_year_screen_student extends StatelessWidget {
  const select_year_screen_student({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E00FF),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Year',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Select Academic Year',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7E00FF)),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose your current academic year',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: const [
                  YearCard(title: 'First Year', shortForm: 'FE', icon: Icons.school),
                  YearCard(title: 'Second Year', shortForm: 'SE', icon: Icons.school),
                  YearCard(title: 'Third Year', shortForm: 'TE', icon: Icons.school),
                  YearCard(title: 'Final Year', shortForm: 'BE', icon: Icons.auto_stories),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class YearCard extends StatefulWidget {
  final String title;
  final String shortForm;
  final IconData icon;

  const YearCard({
    super.key,
    required this.title,
    required this.shortForm,
    required this.icon,
  });

  @override
  State<YearCard> createState() => _YearCardState();
}

class _YearCardState extends State<YearCard> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) => setState(() => _scale = 0.95);
  void _onTapUp(TapUpDetails details) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        // Navigate to attendance screen and pass the selected year (shortForm)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyAttendanceScreen(selectedYear: widget.shortForm),
          ),
        );
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(2, 2),
                blurRadius: 6,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, size: 40, color: const Color(0xFF7E00FF)),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.shortForm,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'stud_view_attendance_screen.dart'; // ✅ Import the second screen

void main() {
  runApp(const MyAttendanceApp());
}

class MyAttendanceApp extends StatelessWidget {
  const MyAttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyAttendanceScreen(selectedYear: 'BE'),
    );
  }
}

class MyAttendanceScreen extends StatelessWidget {
  final String selectedYear;

  const MyAttendanceScreen({super.key, required this.selectedYear});

  @override
  Widget build(BuildContext context) {
    // All subjects data
    final theorySubjects = [
      {'code': "310241", 'type': "Theory", 'title': "Theory of Computation", 'attended': 38, 'total': 45, 'percentage': 84.4},
      {'code': "310242", 'type': "Theory", 'title': "Software Engineering", 'attended': 32, 'total': 40, 'percentage': 80.0},
      {'code': "310243", 'type': "Theory", 'title': "Computer Networks", 'attended': 28, 'total': 35, 'percentage': 80.0},
      {'code': "310244", 'type': "Theory", 'title': "Database Management Systems", 'attended': 35, 'total': 42, 'percentage': 83.3},
      {'code': "310245", 'type': "Theory", 'title': "Design and Analysis of Algorithms", 'attended': 30, 'total': 38, 'percentage': 78.9},
      {'code': "310246", 'type': "Theory", 'title': "Web Technology", 'attended': 29, 'total': 36, 'percentage': 80.6},
    ];

    final practicalSubjects = [
      {'code': "310241", 'type': "Practical", 'title': "Theory of Computation", 'attended': 20, 'total': 22, 'percentage': 90.9},
      {'code': "310242", 'type': "Practical", 'title': "Software Engineering", 'attended': 18, 'total': 20, 'percentage': 90.0},
      {'code': "310243", 'type': "Practical", 'title': "Computer Networks", 'attended': 16, 'total': 18, 'percentage': 88.9},
      {'code': "310244", 'type': "Practical", 'title': "Database Management Systems", 'attended': 19, 'total': 21, 'percentage': 90.5},
      {'code': "310245", 'type': "Practical", 'title': "Design and Analysis of Algorithms", 'attended': 17, 'total': 19, 'percentage': 89.5},
      {'code': "310246", 'type': "Practical", 'title': "Web Technology", 'attended': 16, 'total': 18, 'percentage': 88.9},
    ];

    // Combine for overall calculation
    final allSubjects = [...theorySubjects, ...practicalSubjects];
    int totalAttended = allSubjects.fold(0, (sum, s) => sum + (s['attended'] as int));
    int totalClasses = allSubjects.fold(0, (sum, s) => sum + (s['total'] as int));
    double overallPercentage = totalClasses == 0 ? 0 : (totalAttended / totalClasses) * 100;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: const Color(0xFF7E00FF),
          elevation: 2,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "My Attendance - $selectedYear",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: "Theory"),
              Tab(text: "Practical"),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildOverallAttendanceCard(
                context,
                percentage: overallPercentage,
                attended: totalAttended,
                total: totalClasses,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildSubjectList(context, theorySubjects),
                  _buildSubjectList(context, practicalSubjects),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSubjectList(BuildContext context, List<Map<String, dynamic>> subjects) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          for (var s in subjects) ...[
            GestureDetector(
              onTap: () {
                // ✅ Navigate to ViewAttendanceScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewAttendanceScreen(
                      code: s['code'],
                      title: s['title'],
                      type: s['type'],
                    ),
                  ),
                );
              },
              child: _buildSubjectCard(
                code: s['code'],
                type: s['type'],
                title: s['title'],
                attended: s['attended'],
                total: s['total'],
                percentage: s['percentage'],
                color: const Color(0xFF7E00FF),
              ),
            ),
            const SizedBox(height: 12),
          ]
        ],
      ),
    );
  }

  static Widget _buildOverallAttendanceCard(BuildContext context,
      {required double percentage, required int attended, required int total}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: percentage),
            duration: const Duration(seconds: 1),
            builder: (context, value, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: CircularProgressIndicator(
                      value: value / 100,
                      strokeWidth: 8,
                      backgroundColor: Colors.grey.shade300,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade700),
                    ),
                  ),
                  Text(
                    "${value.toStringAsFixed(1)}%",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.green.shade800,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overall Attendance",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "$attended / $total classes attended",
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildSubjectCard({
    required String code,
    required String type,
    required String title,
    required int attended,
    required int total,
    required double percentage,
    required Color color,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                code,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF7E00FF),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF7E00FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  type,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "$attended/$total classes",
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: percentage / 100),
                  duration: const Duration(seconds: 1),
                  builder: (context, value, _) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: value,
                        minHeight: 6,
                        backgroundColor: Colors.grey.shade300,
                        color: const Color(0xFF7E00FF),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "${percentage.toStringAsFixed(1)}%",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF7E00FF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

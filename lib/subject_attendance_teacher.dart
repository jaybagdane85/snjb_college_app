import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mark_attendance_screen.dart'; // Your existing screen

class SubjectAttendance extends StatefulWidget {
  final String selectedYear;

  const SubjectAttendance({super.key, required this.selectedYear});

  @override
  State<SubjectAttendance> createState() => _SubjectAttendanceState();
}

class _SubjectAttendanceState extends State<SubjectAttendance>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<Map<String, String>>> yearWiseSubjects = {
    'FE': [
      {"code": "310241", "name": "Theory of Computation", "type": "Theory", "students": "60"},
      {"code": "310242", "name": "Software Engineering", "type": "Theory", "students": "60"},
      {"code": "310243", "name": "Computer Networks", "type": "Theory", "students": "60"},
      {"code": "310244", "name": "Database Management Systems", "type": "Theory", "students": "60"},
      {"code": "310245", "name": "Design and Analysis of Algorithms", "type": "Theory", "students": "60"},
      {"code": "310246", "name": "Web Technology", "type": "Theory", "students": "60"},
      {"code": "310241P", "name": "Theory of Computation", "type": "Practical", "students": "30"},
      {"code": "310242P", "name": "Software Engineering", "type": "Practical", "students": "30"},
      {"code": "310243P", "name": "Computer Networks", "type": "Practical", "students": "30"},
      {"code": "310244P", "name": "Database Management Systems", "type": "Practical", "students": "30"},
      {"code": "310245P", "name": "Design and Analysis of Algorithms", "type": "Practical", "students": "30"},
      {"code": "310246P", "name": "Web Technology", "type": "Practical", "students": "30"},
    ],
    'SE': [
      {"code": "310241", "name": "Theory of Computation", "type": "Theory", "students": "60"},
      {"code": "310242", "name": "Software Engineering", "type": "Theory", "students": "60"},
      {"code": "310243", "name": "Computer Networks", "type": "Theory", "students": "60"},
      {"code": "310244", "name": "Database Management Systems", "type": "Theory", "students": "60"},
      {"code": "310245", "name": "Design and Analysis of Algorithms", "type": "Theory", "students": "60"},
      {"code": "310246", "name": "Web Technology", "type": "Theory", "students": "60"},
      {"code": "310241P", "name": "Theory of Computation", "type": "Practical", "students": "30"},
      {"code": "310242P", "name": "Software Engineering", "type": "Practical", "students": "30"},
      {"code": "310243P", "name": "Computer Networks", "type": "Practical", "students": "30"},
      {"code": "310244P", "name": "Database Management Systems", "type": "Practical", "students": "30"},
      {"code": "310245P", "name": "Design and Analysis of Algorithms", "type": "Practical", "students": "30"},
      {"code": "310246P", "name": "Web Technology", "type": "Practical", "students": "30"},
    ],
    'TE': [
      {"code": "310241", "name": "Theory of Computation", "type": "Theory", "students": "60"},
      {"code": "310242", "name": "Software Engineering", "type": "Theory", "students": "60"},
      {"code": "310243", "name": "Computer Networks", "type": "Theory", "students": "60"},
      {"code": "310244", "name": "Database Management Systems", "type": "Theory", "students": "60"},
      {"code": "310245", "name": "Design and Analysis of Algorithms", "type": "Theory", "students": "60"},
      {"code": "310246", "name": "Web Technology", "type": "Theory", "students": "60"},
      {"code": "310241P", "name": "Theory of Computation", "type": "Practical", "students": "30"},
      {"code": "310242P", "name": "Software Engineering", "type": "Practical", "students": "30"},
      {"code": "310243P", "name": "Computer Networks", "type": "Practical", "students": "30"},
      {"code": "310244P", "name": "Database Management Systems", "type": "Practical", "students": "30"},
      {"code": "310245P", "name": "Design and Analysis of Algorithms", "type": "Practical", "students": "30"},
      {"code": "310246P", "name": "Web Technology", "type": "Practical", "students": "30"},
    ],
    'BE': [
      {"code": "310241", "name": "Theory of Computation", "type": "Theory", "students": "60"},
      {"code": "310242", "name": "Software Engineering", "type": "Theory", "students": "60"},
      {"code": "310243", "name": "Computer Networks", "type": "Theory", "students": "60"},
      {"code": "310244", "name": "Database Management Systems", "type": "Theory", "students": "60"},
      {"code": "310245", "name": "Design and Analysis of Algorithms", "type": "Theory", "students": "60"},
      {"code": "310246", "name": "Web Technology", "type": "Theory", "students": "60"},
      {"code": "310241P", "name": "Theory of Computation", "type": "Practical", "students": "30"},
      {"code": "310242P", "name": "Software Engineering", "type": "Practical", "students": "30"},
      {"code": "310243P", "name": "Computer Networks", "type": "Practical", "students": "30"},
      {"code": "310244P", "name": "Database Management Systems", "type": "Practical", "students": "30"},
      {"code": "310245P", "name": "Design and Analysis of Algorithms", "type": "Practical", "students": "30"},
      {"code": "310246P", "name": "Web Technology", "type": "Practical", "students": "30"},
    ]
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Refresh UI on tab change for animation
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subjects = yearWiseSubjects[widget.selectedYear] ?? [];

    final theorySubjects = subjects.where((sub) => sub["type"] == "Theory").toList();
    final practicalSubjects = subjects.where((sub) => sub["type"] == "Practical").toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F9),
      appBar: AppBar(
        title: Text(
          'Mark Attendance - ${widget.selectedYear}',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color(0xFF7E00FF),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: List.generate(2, (index) {
              final isSelected = _tabController.index == index;
              final label = index == 0 ? 'Theory' : 'Practical';

              return TweenAnimationBuilder<double>(
                tween: Tween(begin: isSelected ? 1.0 : 0.9, end: isSelected ? 1.0 : 0.9),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                      color: isSelected ? Colors.white : Colors.white70,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSubjectList(theorySubjects),
          _buildSubjectList(practicalSubjects),
        ],
      ),
    );
  }

  Widget _buildSubjectList(List<Map<String, String>> subjectList) {
    return ListView.builder(
      itemCount: subjectList.length,
      itemBuilder: (context, index) {
        final subject = subjectList[index];
        return SubjectCard(
          code: subject["code"]!,
          name: subject["name"]!,
          type: subject["type"]!,
          students: subject["students"]!,
          year: widget.selectedYear,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MarkAttendanceScreen(
                  subjectCode: subject["code"]!,
                  subjectName: subject["name"]!,
                  subjectType: subject["type"]!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class SubjectCard extends StatefulWidget {
  final String code;
  final String name;
  final String type;
  final String students;
  final String year;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.code,
    required this.name,
    required this.type,
    required this.students,
    required this.onTap,
    required this.year,
  });

  @override
  State<SubjectCard> createState() => _SubjectCardState();
}

class _SubjectCardState extends State<SubjectCard> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        color: Colors.white,
        elevation: _isTapped ? 8 : 4,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            setState(() => _isTapped = true);
            Future.delayed(const Duration(milliseconds: 150), () {
              setState(() => _isTapped = false);
              widget.onTap();
            });
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.code,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: const Color(0xFF7E00FF),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7E00FF),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        widget.type,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "${widget.year} Computer",
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Students: ${widget.students}",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF7E00FF),
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Mark Attendance →",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF7E00FF),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

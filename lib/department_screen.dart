import 'package:flutter/material.dart';
import 'select_year_screen_dept.dart'; // Make sure this file exists in the same directory

class DepartmentScreen extends StatelessWidget {
  final List<Map<String, dynamic>> departments = [
    {
      'icon': Icons.computer,
      'title': 'Computer Engineering',
      'description': 'Software Development,\nProgramming, Data Structures',
      'students': 'Students: 480+ | Faculty: 25+',
      'color': Colors.blue,
    },
    {
      'icon': Icons.build,
      'title': 'Mechanical Engineering',
      'description': 'Thermodynamics,\nManufacturing, Design',
      'students': 'Students: 420+ | Faculty: 22+',
      'color': Colors.red,
    },
    {
      'icon': Icons.location_city,
      'title': 'Civil Engineering',
      'description': 'Construction, Structural\nAnalysis, Transportation',
      'students': 'Students: 380+ | Faculty: 20+',
      'color': Colors.green,
    },
    {
      'icon': Icons.flag,
      'title': 'AIDS Engineering',
      'description': 'Deep Learning, Data Science',
      'students': 'Students: 360+ | Faculty: 18+',
      'color': Colors.lightBlue,
    },
    {
      'icon': Icons.flash_on,
      'title': 'Electrical Engineering',
      'description': 'Power Systems, Control\nSystems, Machines',
      'students': 'Students: 340+ | Faculty: 17+',
      'color': Colors.orange,
    },
    {
      'icon': Icons.laptop_mac,
      'title': 'Information Technology',
      'description': 'Web Development,\nDatabase, Networking',
      'students': 'Students: 400+ | Faculty: 20+',
      'color': Colors.teal,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Select Department',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Your Department',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  final dept = departments[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(
                        dept['icon'],
                        size: 36,
                        color: dept['color'],
                      ),
                      title: Text(
                        dept['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dept['description']),
                          const SizedBox(height: 4),
                          Text(
                            dept['students'],
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SelectYearScreen(departmentName: dept['title']),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

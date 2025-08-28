import 'package:flutter/material.dart';
import 'DepartmentOverviewScreen.dart';


class SelectYearScreen extends StatelessWidget {
  final String departmentName;

  const SelectYearScreen({super.key, required this.departmentName});

  final List<Map<String, String>> years = const [
    {
      'title': 'First Year Engineering (FE)',
      'short': 'FE',
      'subtitle': 'Foundation courses and basic engineering',
      'students': 'Students: 450+',
    },
    {
      'title': 'Second Year Engineering (SE)',
      'short': 'SE',
      'subtitle': 'Core engineering subjects by branch',
      'students': 'Students: 380+',
    },
    {
      'title': 'Third Year Engineering (TE)',
      'short': 'TE',
      'subtitle': 'Advanced engineering and specialization',
      'students': 'Students: 320+',
    },
    {
      'title': 'Final Year Engineering (BE)',
      'short': 'BE',
      'subtitle': 'Projects and industry preparation',
      'students': 'Students: 280+',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Select Year - $departmentName',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Your Academic Year',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: years.length,
                itemBuilder: (context, index) {
                  final year = years[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.school, size: 36, color: Colors.blue),
                      title: Text(
                        year['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(year['subtitle']!),
                          const SizedBox(height: 4),
                          Text(
                            year['students']!,
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 12),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        final shortYear = year['short']!;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepartmentOverviewScreen(
                              yearTitle: shortYear,
                              departmentName: departmentName,
                            ),
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

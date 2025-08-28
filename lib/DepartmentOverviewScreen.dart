import 'package:flutter/material.dart';

class DepartmentOverviewScreen extends StatelessWidget {
  final String departmentName;
  final String yearTitle;

  const DepartmentOverviewScreen({
    super.key,
    required this.departmentName,
    required this.yearTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          '$yearTitle - $departmentName',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                _buildStatCard('45', 'Total Teachers'),
                const SizedBox(width: 16),
                _buildStatCard('320', 'Total Students'),
              ],
            ),
            const SizedBox(height: 24),
            _buildInfoCard(
              title: 'Teachers Details',
              description:
              'View detailed information about all faculty members including their qualifications, experience, and contact details',
              buttonText: 'Browse Faculty →',
              onPressed: () {
                // TODO: Navigate to Teachers page
              },
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Students Details',
              description:
              'Access student information, academic records, and departmental statistics for all $yearTitle students',
              buttonText: 'View Students →',
              onPressed: () {
                // TODO: Navigate to Students page
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String count, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/snjblogo1.png',
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onPressed,
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

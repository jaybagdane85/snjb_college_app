import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MarkAttendanceScreen extends StatefulWidget {
  final String subjectCode;
  final String subjectName;
  final String subjectType;

  const MarkAttendanceScreen({
    super.key,
    required this.subjectCode,
    required this.subjectName,
    required this.subjectType,
  });

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  DateTime selectedDate = DateTime.now();
  Set<String> presentRolls = {};
  late List<Map<String, String>> students;

  @override
  void initState() {
    super.initState();
    students = List.generate(78, (index) {
      const data = [
        {"roll": "1", "name": "Parth Nanaji Ahire"},
        {"roll": "2", "name": "Vedant Dhiraj Shrishrimal"},
        {"roll": "3", "name": "Manasi Ramprasad Pawar"},
        {"roll": "4", "name": "Arohi Yashwant Wani"},
        {"roll": "5", "name": "Srushti Anand Lalwani"},
        {"roll": "6", "name": "Prasad Pankaj Lodha"},
        {"roll": "7", "name": "Sanhita Bramhesh Kadam"},
        {"roll": "8", "name": "Arpan Rahul Jain"},
        {"roll": "9", "name": "Chirag Rahul Bafna"},
        {"roll": "10", "name": "Chirag Ghansham Shah"},
        {"roll": "11", "name": "Ved Sunil Patil"},
        {"roll": "12", "name": "Samiksha Ujwal Jain"},
        {"roll": "13", "name": "Dipak Sunil Mane"},
        {"roll": "14", "name": "Ganesh Namdev Khairnar"},
        {"roll": "15", "name": "Harsh Dilip Tatiya"},
        {"roll": "16", "name": "Bhumi Hemant Mutha"},
        {"roll": "17", "name": "Divya Narendra Patil"},
        {"roll": "18", "name": "Rushikesh Sanjiv Awatare"},
        {"roll": "19", "name": "Anushka Sharad Shewale"},
        {"roll": "20", "name": "Tushar Ghewarchand Nahata"},
        {"roll": "21", "name": "Manasi Mangesh Wani"},
        {"roll": "22", "name": "Samkit Rahul Jain"},
        {"roll": "23", "name": "Yash Satishchand Surana"},
        {"roll": "24", "name": "Shrenik Nitin Jain"},
        {"roll": "25", "name": "Daksh Mahendra Gadiya"},
        {"roll": "26", "name": "Nirmal Satish Chatur"},
        {"roll": "27", "name": "Shraddha Giridhar Mandawade"},
        {"roll": "28", "name": "Premsagar Rajesh Deshmane"},
        {"roll": "29", "name": "Pratik Ravindra Jeughale"},
        {"roll": "30", "name": "Khushnoor Shahid Patel"},
        {"roll": "31", "name": "Abhijeet Arun Gore"},
        {"roll": "32", "name": "Nilesh Kisan Jadhav"},
        {"roll": "33", "name": "Nishant Balkrishna Dhanwate"},
        {"roll": "34", "name": "Divya Anil Patil"},
        {"roll": "35", "name": "Shraddha Somnath Jadhav"},
        {"roll": "36", "name": "Anuja Naval Dahale"},
        {"roll": "37", "name": "Suryaprakash Yadav"},
        {"roll": "38", "name": "Pankaj Balasaheb Bhalerao"},
        {"roll": "39", "name": "Siddhesh Nitin Nikumb"},
        {"roll": "40", "name": "Tejas Rajendra Bhansali"},
        {"roll": "41", "name": "Pratiksha Shahaji Thakare"},
        {"roll": "42", "name": "Aditi Sanjeev Bagate"},
        {"roll": "43", "name": "Sujal Sunil Mehta"},
        {"roll": "44", "name": "Ovi Dhananjay Nimbhorkar"},
        {"roll": "45", "name": "Aayush Prashant Jain"},
        {"roll": "46", "name": "Abhay Pravin Bari"},
        {"roll": "47", "name": "Vaibhavi Vivek Jain"},
        {"roll": "48", "name": "Jagruti Upendra Sonawane"},
        {"roll": "49", "name": "Harsh Atul Pardeshi"},
        {"roll": "50", "name": "Tejas Chandrakiran Chandankar"},
        {"roll": "51", "name": "Harsh Mahesh Sharma"},
        {"roll": "52", "name": "Pushpak Pramod Aher"},
        {"roll": "53", "name": "Om Deepak Shrawge"},
        {"roll": "54", "name": "Rishita Jibhau Khatal"},
        {"roll": "55", "name": "Abhinav Suresh Savakhande"},
        {"roll": "56", "name": "Mitali Pramod Jawale"},
        {"roll": "57", "name": "Rohan Pratap Bhavsar"},
        {"roll": "58", "name": "Harshad Jaywant More"},
        {"roll": "59", "name": "Bhakti Sachin Raut"},
        {"roll": "60", "name": "Sakshi Narayan Gachale"},
        {"roll": "61", "name": "Heramb Bhagwan Daghale"},
        {"roll": "62", "name": "Sanjana Chandrakant Halde"},
        {"roll": "63", "name": "Rajkumar Bhausaheb Patil"},
        {"roll": "64", "name": "Piyush Ramesh Jain"},
        {"roll": "65", "name": "Harshal Ravindra Kadam"},
        {"roll": "66", "name": "Harsh Ashok Shah"},
        {"roll": "67", "name": "Akshara Rajendra Bargal"},
        {"roll": "68", "name": "Tejas Vitthal Burkul"},
        {"roll": "69", "name": "Vaibhav Kailas Jadhav"},
        {"roll": "70", "name": "Diya Sahebrao Sonawane"},
        {"roll": "71", "name": "Charushila Daulat Pawar"},
        {"roll": "72", "name": "Disha Jitendrea Jain"},
        {"roll": "73", "name": "Harsha Sandeep Bhandari"},
        {"roll": "74", "name": "Suhani Virendra Jain"},
        {"roll": "75", "name": "Jay Sudhakar Bagdane"},
        {"roll": "76", "name": "Kaveri Chandrakant Nikam"},
        {"roll": "77", "name": "Sakshi Mahavir Gitaje"},
        {"roll": "78", "name": "Komal Ashok Dhange"},
      ];
      return data[index];
    });
  }

  void _toggleAll(bool present) {
    setState(() {
      presentRolls = present ? students.map((e) => e['roll']!).toSet() : {};
    });
  }

  void _submitAttendance() {
    final formattedDate = DateFormat('dd MMM yyyy').format(selectedDate);
    final attendanceData = {
      'subject': '${widget.subjectCode} - ${widget.subjectName}',
      'date': formattedDate,
      'present': presentRolls.toList(),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Attendance submitted for ${presentRolls.length} students!'),
        backgroundColor: Colors.green,
      ),
    );

    print("Submitted Attendance: $attendanceData");
  }

  void _showAddStudentDialog() {
    String roll = '';
    String name = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("➕ Add Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Roll Number"),
                keyboardType: TextInputType.number,
                onChanged: (value) => roll = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Full Name"),
                onChanged: (value) => name = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (roll.isNotEmpty && name.isNotEmpty) {
                  setState(() {
                    students.add({"roll": roll, "name": name});
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("ADD"),
            ),
          ],
        );
      },
    );
  }

  void _showRemoveStudentDialog() {
    String rollToRemove = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("➖ Remove Student"),
          content: TextField(
            decoration: const InputDecoration(labelText: "Roll Number to remove"),
            keyboardType: TextInputType.number,
            onChanged: (value) => rollToRemove = value,
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  students.removeWhere((student) => student['roll'] == rollToRemove);
                  presentRolls.remove(rollToRemove);
                });
                Navigator.pop(context);
              },
              child: const Text("REMOVE"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Mark Attendance"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'add') {
                _showAddStudentDialog();
              } else if (value == 'remove') {
                _showRemoveStudentDialog();
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'add', child: Text('Add Student')),
              PopupMenuItem(value: 'remove', child: Text('Remove Student')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildSubjectCard(),
            const SizedBox(height: 10),
            _buildCounters(),
            const SizedBox(height: 10),
            _buildToggleButtons(),
            const SizedBox(height: 10),
            Expanded(child: _buildStudentList()),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard() {
    final formattedDate = DateFormat('dd MMM yyyy').format(selectedDate);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.subjectCode} - ${widget.subjectName} (${widget.subjectType})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today,color: Colors.purple,),
                const SizedBox(width: 8),
                const Text("Select Date:"),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => selectedDate = picked);
                    }
                  },
                  child: Text(formattedDate),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text("Present: ${presentRolls.length}", style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
        Text("Absent: ${students.length - presentRolls.length}", style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
        Text("Total: ${students.length}", style: const TextStyle(color: Colors.purple,fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildToggleButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => _toggleAll(true),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.green),
            child: const Text("SELECT ALL"),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: () => _toggleAll(false),
            style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("DESELECT ALL"),
          ),
        ),
      ],
    );
  }

  Widget _buildStudentList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mark Student Attendance",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              final isPresent = presentRolls.contains(student['roll']);

              return StatefulBuilder(
                builder: (context, setLocalState) {
                  bool isHovered = false;
                  return MouseRegion(
                    onEnter: (_) => setLocalState(() => isHovered = true),
                    onExit: (_) => setLocalState(() => isHovered = false),
                    child: Card(
                      color: Colors.white,
                      elevation: isHovered ? 8 : 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {},
                        child: CheckboxListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          value: isPresent,
                          title: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${student['roll']}. ",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF7E00FF),
                                  ),
                                ),
                                TextSpan(
                                  text: student['name'],
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                presentRolls.add(student['roll']!);
                              } else {
                                presentRolls.remove(student['roll']);
                              }
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _submitAttendance,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple.shade800,
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 8,
        ),
        child: const Text(
          "Submit Attendance",
          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

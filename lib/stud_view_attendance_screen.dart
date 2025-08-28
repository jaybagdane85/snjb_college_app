import 'package:flutter/material.dart';

class ViewAttendanceScreen extends StatefulWidget {
  final String code;
  final String title;
  final String type;

  const ViewAttendanceScreen({
    super.key,
    required this.code,
    required this.title,
    required this.type,
  });

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  final List<Map<String, String>> allAttendanceData = [
    {'date': '07-Jul-2025', 'status': 'A'},
    {'date': '08-Jul-2025', 'status': 'P'},
    {'date': '14-Jul-2025', 'status': 'P'},
    {'date': '08-Jul-2025', 'status': 'P'},
    {'date': '16-Jul-2025', 'status': 'P'},
    {'date': '16-Jul-2025', 'status': 'P'},
    {'date': '17-Jul-2025', 'status': 'P'},
  ];

  List<Map<String, String>> filteredAttendance = [];
  String? selectedFilter;

  @override
  void initState() {
    super.initState();
    filteredAttendance = List.from(allAttendanceData);
  }

  void applyFilter() {
    setState(() {
      if (selectedFilter == null) {
        filteredAttendance = List.from(allAttendanceData);
      } else {
        filteredAttendance = allAttendanceData
            .where((e) => e['status'] == selectedFilter)
            .toList();
      }
    });
  }

  void clearFilter() {
    setState(() {
      selectedFilter = null;
      filteredAttendance = List.from(allAttendanceData);
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalPresent =
        filteredAttendance.where((e) => e['status'] == 'P').length;
    int totalAbsent =
        filteredAttendance.where((e) => e['status'] == 'A').length;
    double percent = filteredAttendance.isEmpty
        ? 0
        : (totalPresent / (totalPresent + totalAbsent)) * 100;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E00FF),
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "View Attendance",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFDFF4FB),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "${widget.code}: ${widget.title}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.type.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7E00FF)),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Attendance: (${percent.toStringAsFixed(2)}%)",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF7E00FF)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Attendance List",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF7E00FF)),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list_alt),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return FadeTransitionWrapper(
                          child: AttendanceFilterBottomSheet(
                            selectedFilter: selectedFilter,
                            onSelect: (filter) {
                              setState(() {
                                selectedFilter = filter;
                              });
                            },
                            onClearFilter: () {
                              clearFilter();
                              Navigator.pop(context);
                            },
                            onApplyFilter: () {
                              applyFilter();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    selectedFilter == null
                                        ? "Showing all records"
                                        : selectedFilter == 'P'
                                        ? "Showing Present only"
                                        : "Showing Absent only",
                                  ),
                                  backgroundColor: const Color(0xFF7E00FF),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),

          // Records Found count
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Records Found: ${filteredAttendance.length}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          const Divider(),
          Expanded(
            child: filteredAttendance.isEmpty
                ? const Center(
                child: Text(
                  "No records found",
                  style: TextStyle(color: Colors.grey),
                ))
                : ListView.builder(
              itemCount: filteredAttendance.length,
              itemBuilder: (context, index) {
                final item = filteredAttendance[index];
                final isPresent = item['status'] == 'P';
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 300 + index * 50),
                  child: ListTile(
                    title: Text("${index + 1}. ${item['date']}"),
                    trailing: CircleAvatar(
                      radius: 16,
                      backgroundColor: isPresent
                          ? Colors.green[800]
                          : Colors.red[700],
                      child: Text(
                        item['status']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFDFF4FB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Present= $totalPresent",
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold)),
                  Text("Total Absent= $totalAbsent",
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AttendanceFilterBottomSheet extends StatefulWidget {
  final String? selectedFilter;
  final Function(String?) onSelect;
  final VoidCallback onClearFilter;
  final VoidCallback onApplyFilter;

  const AttendanceFilterBottomSheet({
    super.key,
    required this.selectedFilter,
    required this.onSelect,
    required this.onClearFilter,
    required this.onApplyFilter,
  });

  @override
  State<AttendanceFilterBottomSheet> createState() =>
      _AttendanceFilterBottomSheetState();
}

class _AttendanceFilterBottomSheetState
    extends State<AttendanceFilterBottomSheet> {
  final filterOptions = [
    {
      'label': 'Show All',
      'icon': Icons.clear_all,
      'color': Colors.grey,
      'value': null,
    },
    {
      'label': 'Show Absent Only',
      'icon': Icons.cancel_rounded,
      'color': Colors.red,
      'value': 'A',
    },
    {
      'label': 'Show Present Only',
      'icon': Icons.check_circle_rounded,
      'color': Colors.green,
      'value': 'P',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          )
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Filter Attendance",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF7E00FF),
            ),
          ),
          const SizedBox(height: 16),
          ...filterOptions.map((item) {
            final isSelected = widget.selectedFilter == item['value'];
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  widget.onSelect(item['value'] as String?);
                });
                widget.onApplyFilter(); // Apply immediately on tap
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: isSelected
                      ? LinearGradient(
                    colors: [
                      (item['color'] as Color).withOpacity(0.2),
                      Colors.white,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                      : null,
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF7E00FF)
                        : Colors.grey.shade300,
                    width: 1.5,
                  ),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: (item['color'] as Color).withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ]
                      : [],
                ),
                child: Row(
                  children: [
                    AnimatedScale(
                      scale: isSelected ? 1.2 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        item['icon'] as IconData,
                        color: item['color'] as Color,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        item['label'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: Colors.blue),
                  ],
                ),
              ),
            );
          }).toList(),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.onClearFilter,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF7E00FF), width: 1.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "Clear",
                    style: TextStyle(
                        color: Color(0xFF7E00FF), fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              // Removed Apply button here completely
            ],
          ),
        ],
      ),
    );
  }
}

class FadeTransitionWrapper extends StatefulWidget {
  final Widget child;
  const FadeTransitionWrapper({super.key, required this.child});

  @override
  State<FadeTransitionWrapper> createState() => _FadeTransitionWrapperState();
}

class _FadeTransitionWrapperState extends State<FadeTransitionWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

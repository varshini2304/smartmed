import 'package:flutter/material.dart';
import 'package:smartmed/screens/auth/role_selection_screen.dart';
import 'package:smartmed/screens/shared/profile_screen.dart';


class DashboardStats {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String change;
  final bool isPositive;

  DashboardStats({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.change,
    required this.isPositive,
  });
}

class QuickAction {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  QuickAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class RecentActivity {
  final String title;
  final String subtitle;
  final DateTime time;
  final IconData icon;
  final Color color;

  RecentActivity({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
  });
}

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({super.key});

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
  String doctorName = "Dr. Sarah Johnson";
  String currentTime = "";

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    final now = DateTime.now();
    final hour = now.hour;
    String greeting;

    if (hour < 12) {
      greeting = "Good Morning";
    } else if (hour < 17) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Evening";
    }

    setState(() {
      currentTime = greeting;
    });
  }

  List<DashboardStats> get dashboardStats => [
    DashboardStats(
      title: "Today's Patients",
      value: "12",
      icon: Icons.people,
      color: Color(0xFF6C4AB6),
      change: "+2",
      isPositive: true,
    ),
    DashboardStats(
      title: "Pending Reports",
      value: "8",
      icon: Icons.assignment,
      color: Color(0xFF6C4AB6),
      change: "-3",
      isPositive: true,
    ),
    DashboardStats(
      title: "Prescriptions",
      value: "25",
      icon: Icons.medical_services,
      color: Color(0xFF6C4AB6),
      change: "+5",
      isPositive: true,
    ),
    DashboardStats(
      title: "Emergencies",
      value: "2",
      icon: Icons.warning,
      color: Colors.red[400]!,
      change: "0",
      isPositive: true,
    ),
  ];

  List<QuickAction> get quickActions => [
    QuickAction(
      title: "View Appointments",
      subtitle: "Manage today's schedule",
      icon: Icons.calendar_today,
      color: Color(0xFF6C4AB6),
      onTap: () {
        Navigator.pushNamed(context, '/doctor-appointments');
      },
    ),
    QuickAction(
      title: "Create Prescription",
      subtitle: "Write new prescription",
      icon: Icons.note_add,
      color: Color(0xFF6C4AB6),
      onTap: () {
        Navigator.pushNamed(context, '/create-prescription');
      },
    ),
    QuickAction(
      title: "Patient Records",
      subtitle: "Access medical history",
      icon: Icons.folder_shared,
      color: Color(0xFF6C4AB6),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Patient Records feature coming soon!')),
        );
      },
    ),
    QuickAction(
      title: "Lab Results",
      subtitle: "Review test reports",
      icon: Icons.science,
      color: Color(0xFF6C4AB6),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lab Results feature coming soon!')),
        );
      },
    ),
    QuickAction(
      title: "Emergency Alerts",
      subtitle: "Critical notifications",
      icon: Icons.notification_important,
      color: Colors.red[500]!,
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Emergency Alerts feature coming soon!')),
        );
      },
    ),
    QuickAction(
      title: "Video Consultation",
      subtitle: "Start telemedicine",
      icon: Icons.video_call,
      color: Color(0xFF6C4AB6),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Video Consultation feature coming soon!')),
        );
      },
    ),
  ];

  List<RecentActivity> get recentActivities => [
    RecentActivity(
      title: "Completed consultation",
      subtitle: "Patient: John Doe",
      time: DateTime.now().subtract(const Duration(minutes: 15)),
      icon: Icons.check_circle,
      color: Colors.green[500]!,
    ),
    RecentActivity(
      title: "Prescription created",
      subtitle: "Patient: Mary Smith",
      time: DateTime.now().subtract(const Duration(minutes: 45)),
      icon: Icons.healing,
      color: Colors.purple[500]!,
    ),
    RecentActivity(
      title: "Lab report reviewed",
      subtitle: "Patient: Robert Wilson",
      time: DateTime.now().subtract(const Duration(hours: 1, minutes: 20)),
      icon: Icons.assignment_turned_in,
      color: Colors.blue[500]!,
    ),
    RecentActivity(
      title: "Emergency handled",
      subtitle: "Patient: Lisa Brown",
      time: DateTime.now().subtract(const Duration(hours: 2)),
      icon: Icons.local_hospital,
      color: Colors.red[500]!,
    ),
  ];

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
            );
          },
        ),
        elevation: 0,
        backgroundColor: Color(0xFF6C4AB6),
        foregroundColor: Colors.white,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Notifications action
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // Settings action
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(

          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6C4AB6).withOpacity(0.1),
              Color(0xFF6C4AB6).withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom App Bar
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6C4AB6),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                name: doctorName,
                                email: 'doctor@example.com',
                                role: 'Doctor',
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xFF6C4AB6).withOpacity(0.2),
                          child: const Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentTime,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              doctorName,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications_outlined,
                          color: Color(0xFF6C4AB6),
                          size: 28,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Notifications feature coming soon!')),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Stats Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: dashboardStats.length,
                    itemBuilder: (context, index) {
                      final stat = dashboardStats[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: stat.color.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    stat.icon,
                                    color: stat.color,
                                    size: 20,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: stat.isPositive
                                        ? Colors.green.withOpacity(0.2)
                                        : Colors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    stat.change,
                                    style: TextStyle(
                                      color: stat.isPositive ? Colors.green : Colors.red,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              stat.value,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              stat.title,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Quick Actions Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.flash_on,
                            color: Color(0xFF6C4AB6).withOpacity(0.8),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Quick Actions',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C4AB6).withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: quickActions.length,
                        itemBuilder: (context, index) {
                          final action = quickActions[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: action.color.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: action.onTap,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: action.color.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          action.icon,
                                          color: action.color,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        action.title,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        action.subtitle,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Recent Activity Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.history,
                            color: Color(0xFF6C4AB6),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Recent Activity',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C4AB6),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('View all activity feature coming soon!')),
                              );
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                color: Color(0xFF6C4AB6),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(16),
                          itemCount: recentActivities.length,
                          separatorBuilder: (context, index) => Divider(
                            color: Colors.grey[200],
                            height: 20,
                          ),
                          itemBuilder: (context, index) {
                            final activity = recentActivities[index];
                            return Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: activity.color.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    activity.icon,
                                    color: activity.color,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        activity.title,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        activity.subtitle,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  _formatTime(activity.time),
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

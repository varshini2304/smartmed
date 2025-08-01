import 'package:flutter/material.dart';

class PatientAppointmentsScreen extends StatefulWidget {
  const PatientAppointmentsScreen({super.key});

  @override
  State<PatientAppointmentsScreen> createState() =>
      _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen> {
  final List<Map<String, dynamic>> appointments = [
  {
    "doctor": "Dr. Sharma",
    "specialty": "Cardiologist",
    "date": "July 1",
    "time": "9:00 AM",
    "status": "confirmed",
    "avatar": "S"
  },
  {
    "doctor": "Dr. Meena",
    "specialty": "Dermatologist",
    "date": "July 3",
    "time": "4:30 PM",
    "status": "pending",
    "avatar": "M"
  },
  {
    "doctor": "Dr. Patel",
    "specialty": "General Physician",
    "date": "July 5",
    "time": "11:15 AM",
    "status": "confirmed",
    "avatar": "P"
  },
  {
    "doctor": "Dr. Khan",
    "specialty": "Neurologist",
    "date": "July 6",
    "time": "2:00 PM",
    "status": "cancelled",
    "avatar": "K"
  },
  {
    "doctor": "Dr. Arora",
    "specialty": "Orthopedic",
    "date": "July 8",
    "time": "10:30 AM",
    "status": "confirmed",
    "avatar": "A"
  },
  {
    "doctor": "Dr. Banerjee",
    "specialty": "Pediatrician",
    "date": "July 9",
    "time": "1:00 PM",
    "status": "pending",
    "avatar": "B"
  },
  {
    "doctor": "Dr. Chawla",
    "specialty": "Oncologist",
    "date": "July 10",
    "time": "3:45 PM",
    "status": "confirmed",
    "avatar": "C"
  },
  {
    "doctor": "Dr. Iyer",
    "specialty": "ENT Specialist",
    "date": "July 11",
    "time": "9:30 AM",
    "status": "confirmed",
    "avatar": "I"
  },
  {
    "doctor": "Dr. Reddy",
    "specialty": "Gastroenterologist",
    "date": "July 12",
    "time": "5:00 PM",
    "status": "pending",
    "avatar": "R"
  },
  {
    "doctor": "Dr. Nair",
    "specialty": "Psychiatrist",
    "date": "July 13",
    "time": "12:15 PM",
    "status": "confirmed",
    "avatar": "N"
  },
  {
    "doctor": "Dr. Joshi",
    "specialty": "Urologist",
    "date": "July 14",
    "time": "2:30 PM",
    "status": "cancelled",
    "avatar": "J"
  },
  {
    "doctor": "Dr. Verma",
    "specialty": "Gynecologist",
    "date": "July 15",
    "time": "11:00 AM",
    "status": "confirmed",
    "avatar": "V"
  },
  {
    "doctor": "Dr. Saxena",
    "specialty": "Pulmonologist",
    "date": "July 16",
    "time": "3:00 PM",
    "status": "pending",
    "avatar": "S"
  },
  {
    "doctor": "Dr. Desai",
    "specialty": "Ophthalmologist",
    "date": "July 17",
    "time": "10:00 AM",
    "status": "confirmed",
    "avatar": "D"
  },
  {
    "doctor": "Dr. Bhatt",
    "specialty": "Endocrinologist",
    "date": "July 18",
    "time": "1:30 PM",
    "status": "confirmed",
    "avatar": "B"
  }
]
;

  // Primary color scheme
  static const Color primaryBlue = Color(0xFF6C4AB6);
  static const Color primaryDark = Color(0xFF6C4AB6);
  static const Color primaryLight = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'My Appointments',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              // Calendar view action
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFFFFF), // stronger soft blue
              theme.primaryColor.withOpacity(0.3), // stronger lavender
            ],
          ),
        ),
        child: Column(
          children: [
            // Header section with stats
            Container(
              width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      'Total',
                      appointments.length.toString(),
                      Icons.event,
                    ),
                    _buildStatCard(
                      'Confirmed',
                      appointments
                          .where((a) => a['status'] == 'confirmed')
                          .length
                          .toString(),
                      Icons.check_circle,
                    ),
                    _buildStatCard(
                      'Pending',
                      appointments
                          .where((a) => a['status'] == 'pending')
                          .length
                          .toString(),
                      Icons.schedule,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Appointments list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appt = appointments[index];
                  return _buildAppointmentCard(appt, index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          // Add new appointment
        },
        icon: const Icon(Icons.add),
        label: const Text('Book Appointment'),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primaryColor, // solid color instead of gradient
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appt, int index) {
    final theme = Theme.of(context);
    final isConfirmed = appt['status'] == 'confirmed';
    final statusColor = isConfirmed ? accentColor : warningColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF), // stronger very light blue
            Color(0xFFFFFFFF), // stronger light lavender
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            _showAppointmentDetails(appt);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Doctor avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryLight,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: theme.primaryColor, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      appt['avatar'],
                      style: const TextStyle(
                        color: primaryDark,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Appointment details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appt['doctor'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        appt['specialty'],
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${appt['date']} at ${appt['time']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status and icon
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        appt['status'].toString().toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      isConfirmed ? Icons.check_circle : Icons.schedule,
                      color: statusColor,
                      size: 24,
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

  void _showAppointmentDetails(Map<String, dynamic> appointment) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Appointment Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: primaryDark,
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Doctor', appointment['doctor']),
              _buildDetailRow('Specialty', appointment['specialty']),
              _buildDetailRow('Date', appointment['date']),
              _buildDetailRow('Time', appointment['time']),
              _buildDetailRow(
                'Status',
                appointment['status'].toString().toUpperCase(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Reschedule'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel),
                      label: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

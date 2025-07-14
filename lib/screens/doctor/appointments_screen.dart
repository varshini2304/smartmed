import 'package:flutter/material.dart';

enum AppointmentStatus { scheduled, inProgress, completed, cancelled }

class Appointment {
  final String id;
  final String patientName;
  final String patientPhone;
  final String appointmentType;
  final DateTime dateTime;
  final int durationMinutes;
  final AppointmentStatus status;
  final String? notes;
  final bool isUrgent;

  Appointment({
    required this.id,
    required this.patientName,
    required this.patientPhone,
    required this.appointmentType,
    required this.dateTime,
    this.durationMinutes = 30,
    this.status = AppointmentStatus.scheduled,
    this.notes,
    this.isUrgent = false,
  });
}

class DoctorAppointmentsScreen extends StatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  State<DoctorAppointmentsScreen> createState() =>
      _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends State<DoctorAppointmentsScreen> {
  DateTime selectedDate = DateTime.now();
  AppointmentStatus? filterStatus;
  String searchQuery = '';

  final List<Appointment> appointments = [
    Appointment(
      id: '1',
      patientName: 'Varun Kumar',
      patientPhone: '+91 98765 43210',
      appointmentType: 'General Consultation',
      dateTime: DateTime.now().copyWith(hour: 10, minute: 0),
      status: AppointmentStatus.scheduled,
      notes: 'Follow-up for hypertension',
    ),
    Appointment(
      id: '2',
      patientName: 'Neha Sharma',
      patientPhone: '+91 87654 32109',
      appointmentType: 'Cardiology Checkup',
      dateTime: DateTime.now().copyWith(hour: 11, minute: 30),
      status: AppointmentStatus.inProgress,
      durationMinutes: 45,
      isUrgent: true,
    ),
    Appointment(
      id: '3',
      patientName: 'Rajesh Patel',
      patientPhone: '+91 76543 21098',
      appointmentType: 'Diabetes Management',
      dateTime: DateTime.now().copyWith(hour: 14, minute: 0),
      status: AppointmentStatus.completed,
      notes: 'Blood sugar levels stable',
    ),
    Appointment(
      id: '4',
      patientName: 'Priya Singh',
      patientPhone: '+91 65432 10987',
      appointmentType: 'Routine Checkup',
      dateTime: DateTime.now().copyWith(hour: 15, minute: 30),
      status: AppointmentStatus.scheduled,
    ),
    Appointment(
      id: '5',
      patientName: 'Amit Gupta',
      patientPhone: '+91 54321 09876',
      appointmentType: 'Emergency Consultation',
      dateTime: DateTime.now()
          .add(const Duration(days: 1))
          .copyWith(hour: 9, minute: 0),
      status: AppointmentStatus.scheduled,
      isUrgent: true,
      notes: 'Chest pain complaint',
    ),
  ];

  List<Appointment> get filteredAppointments {
    return appointments.where((appointment) {
      final matchesDate =
          appointment.dateTime.day == selectedDate.day &&
          appointment.dateTime.month == selectedDate.month &&
          appointment.dateTime.year == selectedDate.year;
      final matchesStatus =
          filterStatus == null || appointment.status == filterStatus;
      final matchesSearch =
          searchQuery.isEmpty ||
          appointment.patientName.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          appointment.appointmentType.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
      return matchesDate && matchesStatus && matchesSearch;
    }).toList()..sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  String _getStatusText(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.scheduled:
        return 'Scheduled';
      case AppointmentStatus.inProgress:
        return 'In Progress';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$hour12:$minute $period';
  }

  void _updateAppointmentStatus(
    Appointment appointment,
    AppointmentStatus newStatus,
  ) {
    setState(() {
      final index = appointments.indexWhere((a) => a.id == appointment.id);
      if (index != -1) {
        appointments[index] = Appointment(
          id: appointment.id,
          patientName: appointment.patientName,
          patientPhone: appointment.patientPhone,
          appointmentType: appointment.appointmentType,
          dateTime: appointment.dateTime,
          durationMinutes: appointment.durationMinutes,
          status: newStatus,
          notes: appointment.notes,
          isUrgent: appointment.isUrgent,
        );
      }
    });
  }

  void _showAppointmentDetails(Appointment appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Appointment Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Patient', appointment.patientName),
              _buildDetailRow('Phone', appointment.patientPhone),
              _buildDetailRow('Type', appointment.appointmentType),
              _buildDetailRow('Time', _formatTime(appointment.dateTime)),
              _buildDetailRow(
                'Duration',
                '${appointment.durationMinutes} minutes',
              ),
              _buildDetailRow('Status', _getStatusText(appointment.status)),
              if (appointment.notes != null)
                _buildDetailRow('Notes', appointment.notes!),
              if (appointment.isUrgent)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.priority_high, color: Colors.red, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Urgent',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          if (appointment.status == AppointmentStatus.scheduled)
            ElevatedButton(
              onPressed: () {
                _updateAppointmentStatus(
                  appointment,
                  AppointmentStatus.inProgress,
                );
                Navigator.pop(context);
              },
              child: const Text('Start'),
            ),
          if (appointment.status == AppointmentStatus.inProgress)
            ElevatedButton(
              onPressed: () {
                _updateAppointmentStatus(
                  appointment,
                  AppointmentStatus.completed,
                );
                Navigator.pop(context);
              },
              child: const Text('Complete'),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredAppts = filteredAppointments;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Appointments'),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) {
                setState(() {
                  selectedDate = date;
                });
              }
            },
          ),
          PopupMenuButton<AppointmentStatus?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (status) {
              setState(() {
                filterStatus = status;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: null, child: Text('All Appointments')),
              PopupMenuItem(
                value: AppointmentStatus.scheduled,
                child: Text('Scheduled'),
              ),
              PopupMenuItem(
                value: AppointmentStatus.inProgress,
                child: Text('In Progress'),
              ),
              PopupMenuItem(
                value: AppointmentStatus.completed,
                child: Text('Completed'),
              ),
              PopupMenuItem(
                value: AppointmentStatus.cancelled,
                child: Text('Cancelled'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.primaryColor.withOpacity(0.1),
              theme.primaryColor.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search patients or appointment types...',
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAppts.length,
                itemBuilder: (context, index) {
                  final appointment = filteredAppts[index];
                  return ListTile(
                    title: Text(appointment.patientName),
                    subtitle: Text(
                      '${_formatTime(appointment.dateTime)} • ${_getStatusText(appointment.status)}',
                    ),
                    trailing: appointment.isUrgent
                        ? const Icon(Icons.priority_high, color: Colors.red)
                        : null,
                    onTap: () => _showAppointmentDetails(appointment),
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

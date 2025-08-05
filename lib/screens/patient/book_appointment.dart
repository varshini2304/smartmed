import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentBookingScreen extends StatefulWidget {
  const AppointmentBookingScreen({super.key});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();

  // Static storage for appointments (moved from state class)
  static List<Map<String, dynamic>> _storedAppointments = [];

  // Static method to get appointments
  static List<Map<String, dynamic>> getStoredAppointments() {
    return List.from(_storedAppointments);
  }

  // Static method to remove appointment
  static void removeAppointment(int index) {
    if (index >= 0 && index < _storedAppointments.length) {
      _storedAppointments.removeAt(index);
    }
  }

  // Static method to save appointment
  static void saveAppointment(Map<String, dynamic> appointment) {
    _storedAppointments.add(appointment);
  }
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  // Static storage for appointments (simulates local storage)
  static List<Map<String, dynamic>> _storedAppointments = [];

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _patientEmailController = TextEditingController();
  final _notesController = TextEditingController();

  // Selected values
  String? _selectedDoctor;
  String? _selectedSpecialty;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;

  // Loading state
  bool _isBooking = false;

  // Primary color scheme
  static const Color primaryBlue = Color(0xFF6C4AB6);
  static const Color primaryDark = Color(0xFF6C4AB6);
  static const Color accentColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);

  // Sample doctors data
  final List<Map<String, dynamic>> _doctors = [
      {
        "id": "1",
        "name": "Dr. Sharma",
        "specialty": "Cardiologist",
        "avatar": "S",
        "experience": "15 years",
        "rating": 4.8,
        "fee": "₹500"
      },
      {
        "id": "2",
        "name": "Dr. Meena",
        "specialty": "Dermatologist",
        "avatar": "M",
        "experience": "12 years",
        "rating": 4.6,
        "fee": "₹600"
      },
      {
        "id": "3",
        "name": "Dr. Patel",
        "specialty": "General Physician",
        "avatar": "P",
        "experience": "20 years",
        "rating": 4.9,
        "fee": "₹400"
      },
      {
        "id": "4",
        "name": "Dr. Khan",
        "specialty": "Neurologist",
        "avatar": "K",
        "experience": "18 years",
        "rating": 4.7,
        "fee": "₹800"
      },
      {
        "id": "5",
        "name": "Dr. Arora",
        "specialty": "Orthopedic",
        "avatar": "A",
        "experience": "14 years",
        "rating": 4.5,
        "fee": "₹700"
      },
      {
        "id": "6",
        "name": "Dr. Nair",
        "specialty": "ENT Specialist",
        "avatar": "N",
        "experience": "10 years",
        "rating": 4.4,
        "fee": "₹450"
      },
      {
        "id": "7",
        "name": "Dr. Roy",
        "specialty": "Psychiatrist",
        "avatar": "R",
        "experience": "13 years",
        "rating": 4.6,
        "fee": "₹650"
      },
      {
        "id": "8",
        "name": "Dr. Verma",
        "specialty": "Pulmonologist",
        "avatar": "V",
        "experience": "16 years",
        "rating": 4.7,
        "fee": "₹550"
      },
      {
        "id": "9",
        "name": "Dr. Bhatia",
        "specialty": "Oncologist",
        "avatar": "B",
        "experience": "19 years",
        "rating": 4.9,
        "fee": "₹1200"
      },
      {
        "id": "10",
        "name": "Dr. Iyer",
        "specialty": "Gastroenterologist",
        "avatar": "I",
        "experience": "17 years",
        "rating": 4.8,
        "fee": "₹900"
      },
      {
        "id": "11",
        "name": "Dr. Reddy",
        "specialty": "Urologist",
        "avatar": "R",
        "experience": "11 years",
        "rating": 4.5,
        "fee": "₹750"
      },
      {
        "id": "12",
        "name": "Dr. Chawla",
        "specialty": "Pediatrician",
        "avatar": "C",
        "experience": "9 years",
        "rating": 4.6,
        "fee": "₹500"
      },
      {
        "id": "13",
        "name": "Dr. Joshi",
        "specialty": "Radiologist",
        "avatar": "J",
        "experience": "13 years",
        "rating": 4.3,
        "fee": "₹600"
      },
      {
        "id": "14",
        "name": "Dr. Das",
        "specialty": "Ophthalmologist",
        "avatar": "D",
        "experience": "12 years",
        "rating": 4.7,
        "fee": "₹550"
      },
      {
        "id": "15",
        "name": "Dr. Gill",
        "specialty": "Endocrinologist",
        "avatar": "G",
        "experience": "14 years",
        "rating": 4.6,
        "fee": "₹800"
      }
  ];

  // Available time slots
  final List<String> _timeSlots = [
    "9:00 AM",
    "9:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "2:00 PM",
    "2:30 PM",
    "3:00 PM",
    "3:30 PM",
    "4:00 PM",
    "4:30 PM",
    "5:00 PM",
  ];

  @override
  void dispose() {
    _patientNameController.dispose();
    _patientEmailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        title: const Text(
          'Book Appointment',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFFFFFFF),
              theme.primaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step indicator
                _buildStepIndicator(),
                const SizedBox(height: 24),

                // Select Doctor Section
                _buildSectionTitle('Select Doctor', Icons.person),
                const SizedBox(height: 12),
                _buildDoctorSelection(),
                const SizedBox(height: 24),

                // Select Date Section
                _buildSectionTitle('Select Date', Icons.calendar_today),
                const SizedBox(height: 12),
                _buildDateSelection(),
                const SizedBox(height: 24),

                // Select Time Section
                _buildSectionTitle('Select Time', Icons.access_time),
                const SizedBox(height: 12),
                _buildTimeSelection(),
                const SizedBox(height: 24),

                // Patient Information Section
                _buildSectionTitle('Patient Information', Icons.info),
                const SizedBox(height: 12),
                _buildPatientForm(),
                const SizedBox(height: 32),

                // Booking Summary
                if (_selectedDoctor != null &&
                    _selectedDate != null &&
                    _selectedTimeSlot != null)
                  _buildBookingSummary(),

                const SizedBox(height: 24),

                // Book Appointment Button
                _buildBookButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildStepCircle(1, _selectedDoctor != null, 'Doctor'),
          Expanded(child: Container(height: 2, color: Colors.grey[300])),
          _buildStepCircle(
            2,
            _selectedDate != null && _selectedTimeSlot != null,
            'Date & Time',
          ),
          Expanded(child: Container(height: 2, color: Colors.grey[300])),
          _buildStepCircle(
            3,
            _patientNameController.text.isNotEmpty,
            'Details',
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, bool isCompleted, String label) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isCompleted ? theme.primaryColor : Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    step.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isCompleted ? theme.primaryColor : Colors.grey[600],
            fontWeight: isCompleted ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: theme.primaryColor, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorSelection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: _doctors.map((doctor) {
          final isSelected = _selectedDoctor == doctor['name'];

          return Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? primaryBlue.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isSelected
                  ? Border.all(color: primaryBlue, width: 2)
                  : null,
            ),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: isSelected
                      ? Border.all(color: primaryBlue, width: 2)
                      : null,
                ),
                child: Center(
                  child: Text(
                    doctor['avatar'],
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                doctor['name'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? primaryBlue : Colors.black87,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(doctor['specialty']),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(' ${doctor['rating']} • ${doctor['experience']}'),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doctor['fee'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? primaryBlue : Colors.black87,
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle, color: primaryBlue, size: 20),
                ],
              ),
              onTap: () {
                setState(() {
                  _selectedDoctor = doctor['name'];
                  _selectedSpecialty = doctor['specialty'];
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateSelection() {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate != null
                      ? 'Selected: ${_formatDate(_selectedDate!)}'
                      : 'Choose a date',
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedDate != null
                        ? theme.primaryColor
                        : Colors.grey[600],
                    fontWeight: _selectedDate != null
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: _selectDate,
                icon: const Icon(Icons.calendar_today, size: 16),
                label: const Text('Select Date'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Time Slots',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _timeSlots.map((time) {
              final isSelected = _selectedTimeSlot == time;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTimeSlot = time;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryBlue : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected ? Border.all(color: primaryBlue) : null,
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _patientNameController,
            decoration: const InputDecoration(
              labelText: 'Patient Name *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter patient name';
              }
              return null;
            },
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _patientEmailController,
            decoration: const InputDecoration(
              labelText: 'Email Address *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter email address';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _notesController,
            decoration: const InputDecoration(
              labelText: 'Additional Notes (Optional)',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.note),
            ),
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildBookingSummary() {
    final theme = Theme.of(context);
    final selectedDoctorData = _doctors.firstWhere(
      (d) => d['name'] == _selectedDoctor,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.primaryColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list_alt, color: theme.primaryColor),
              const SizedBox(width: 8),
              Text(
                'Booking Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Doctor', _selectedDoctor!),
          _buildSummaryRow('Specialty', _selectedSpecialty!),
          _buildSummaryRow('Date', _formatDate(_selectedDate!)),
          _buildSummaryRow('Time', _selectedTimeSlot!),
          _buildSummaryRow('Consultation Fee', selectedDoctorData['fee']),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                selectedDoctorData['fee'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildBookButton() {
    final theme = Theme.of(context);
    final canBook =
        _selectedDoctor != null &&
        _selectedDate != null &&
        _selectedTimeSlot != null &&
        _patientNameController.text.isNotEmpty &&
        _patientEmailController.text.isNotEmpty;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: canBook ? theme.primaryColor : Colors.grey[400],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: canBook && !_isBooking ? _bookAppointment : null,
        child: _isBooking
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : const Text(
                'Book Appointment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(
              context,
            ).colorScheme.copyWith(primary: primaryBlue),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedTimeSlot = null; // Reset time slot when date changes
      });
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  Future<void> _bookAppointment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isBooking = true;
    });

    try {
      // Create appointment data
      final selectedDoctorData = _doctors.firstWhere(
        (d) => d['name'] == _selectedDoctor,
      );
      final appointment = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'doctor': _selectedDoctor,
        'specialty': _selectedSpecialty,
        'date': _formatDate(_selectedDate!),
        'time': _selectedTimeSlot,
        'patientName': _patientNameController.text.trim(),
        'patientEmail': _patientEmailController.text.trim(),
        'notes': _notesController.text.trim(),
        'status': 'confirmed',
        'avatar': selectedDoctorData['avatar'],
        'fee': selectedDoctorData['fee'],
        'bookingDate': DateTime.now().toIso8601String(),
      };

      // Save to local storage
      await _saveAppointment(appointment);

      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isBooking = false;
      });

      // Show success dialog
      _showSuccessDialog(appointment);
    } catch (e) {
      setState(() {
        _isBooking = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error booking appointment: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveAppointment(Map<String, dynamic> appointment) async {
    final prefs = await SharedPreferences.getInstance();
    // Clear in-memory list before loading to avoid duplicates
    _storedAppointments.clear();
    // Load existing appointments from storage
    final String? appointmentsString = prefs.getString('appointments');
    if (appointmentsString != null) {
      _storedAppointments = List<Map<String, dynamic>>.from(
        json.decode(appointmentsString),
      );
    } else {
      _storedAppointments = [];
    }
    // Add new appointment
    _storedAppointments.add(appointment);
    // Save updated list
    await prefs.setString('appointments', json.encode(_storedAppointments));
  }

  // Static method to get appointments (used by appointments screen)
  static List<Map<String, dynamic>> getStoredAppointments() {
    return List.from(_storedAppointments);
  }

  // Static method to remove appointment (used by appointments screen)
  static Future<void> removeAppointment(int index) async {
    final prefs = await SharedPreferences.getInstance();
    if (index >= 0 && index < _storedAppointments.length) {
      _storedAppointments.removeAt(index);
      await prefs.setString('appointments', json.encode(_storedAppointments));
    }
  }

  void _showSuccessDialog(Map<String, dynamic> appointment) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(Icons.check_circle, color: accentColor, size: 48),
              ),
              const SizedBox(height: 16),
              const Text(
                'Booking Confirmed!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Your appointment has been successfully booked.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    _buildSummaryRow('Doctor', appointment['doctor']),
                    _buildSummaryRow('Date', appointment['date']),
                    _buildSummaryRow('Time', appointment['time']),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to previous screen
              },
              child: const Text('Done'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.pushNamed(context, '/patient-appointments');
              },
              child: const Text('View Appointments'),
            ),
          ],
        );
      },
    );
  }
}

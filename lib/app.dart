import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/role_selection_screen.dart';
import 'screens/doctor/dashboard_screen.dart';
import 'screens/doctor/appointments_screen.dart';
import 'screens/doctor/prescription_screen.dart';
import 'screens/patient/dashboard_screen.dart';
import 'screens/patient/appointments_screen.dart';
import 'screens/patient/book_appointment.dart';
import 'screens/patient/records_screen.dart';
import 'screens/shared/profile_screen.dart';

class SmartMedApp extends StatelessWidget {
  const SmartMedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartMed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/role-selection': (context) => const RoleSelectionScreen(),
        '/doctor-dashboard': (context) => const DoctorDashboardScreen(),
        '/doctor-appointments': (context) => const DoctorAppointmentsScreen(),
        '/create-prescription': (context) => const CreatePrescriptionScreen(),
        '/patient-dashboard': (context) => const PatientDashboardScreen(),
        '/patient-appointments': (context) => const PatientAppointmentsScreen(),
        '/book-appointment': (context) => const AppointmentBookingScreen(), // Add this route
        '/medical-records': (context) => const MedicalRecordsScreen(),
        '/profile': (context) => const ProfileScreen(
          name: 'Demo User',
          email: 'demo@example.com',
          role: 'Patient',
        ),
      },
    );
  }
}
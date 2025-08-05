import 'dart:convert';
import 'package:http/http.dart' as http;

class AppointmentService {
  static const String baseUrl = 'http://localhost:5000/api';

  // Create new appointment
  static Future<Map<String, dynamic>> createAppointment(
      Map<String, dynamic> appointment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/appointments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(appointment),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create appointment: ${response.body}');
    }
  }

  // Get appointments for a patient
  static Future<List<dynamic>> getAppointments(String patientEmail) async {
    final response = await http.get(
      Uri.parse('$baseUrl/appointments/$patientEmail'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load appointments: ${response.body}');
    }
  }

  // Update appointment
  static Future<Map<String, dynamic>> updateAppointment(
      String id, Map<String, dynamic> appointment) async {
    final response = await http.put(
      Uri.parse('$baseUrl/appointments/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(appointment),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update appointment: ${response.body}');
    }
  }

  // Delete appointment
  static Future<void> deleteAppointment(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/appointments/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete appointment: ${response.body}');
    }
  }
}

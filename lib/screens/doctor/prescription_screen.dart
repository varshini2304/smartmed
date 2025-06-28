import 'package:flutter/material.dart';

class Medicine {
  final String name;
  final String type;
  final String strength;
  final String category;

  Medicine({
    required this.name,
    required this.type,
    required this.strength,
    required this.category,
  });
}

class Patient {
  final String id;
  final String name;
  final String phone;
  final int age;
  final String gender;

  Patient({
    required this.id,
    required this.name,
    required this.phone,
    required this.age,
    required this.gender,
  });
}

class PrescriptionItem {
  String medicineId;
  String medicineName;
  String dosage;
  String frequency;
  String duration;
  String instructions;
  bool beforeMeal;

  PrescriptionItem({
    this.medicineId = '',
    this.medicineName = '',
    this.dosage = '',
    this.frequency = '',
    this.duration = '',
    this.instructions = '',
    this.beforeMeal = true,
  });
}

class CreatePrescriptionScreen extends StatefulWidget {
  const CreatePrescriptionScreen({super.key});

  @override
  State<CreatePrescriptionScreen> createState() =>
      _CreatePrescriptionScreenState();
}

class _CreatePrescriptionScreenState extends State<CreatePrescriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final patientController = TextEditingController();
  final diagnosisController = TextEditingController();
  final notesController = TextEditingController();

  Patient? selectedPatient;
  List<PrescriptionItem> prescriptionItems = [PrescriptionItem()];

  // Sample data
  final List<Patient> patients = [
    Patient(id: '1', name: 'Varun Kumar', phone: '+91 98765 43210', age: 35, gender: 'Male'),
    Patient(id: '2', name: 'Neha Sharma', phone: '+91 87654 32109', age: 28, gender: 'Female'),
    Patient(id: '3', name: 'Rajesh Patel', phone: '+91 76543 21098', age: 45, gender: 'Male'),
    Patient(id: '4', name: 'Priya Singh', phone: '+91 65432 10987', age: 32, gender: 'Female'),
    Patient(id: '5', name: 'Amit Gupta', phone: '+91 54321 09876', age: 55, gender: 'Male'),
  ];

  final List<Medicine> medicines = [
    Medicine(name: 'Paracetamol', type: 'Tablet', strength: '500mg', category: 'Analgesic'),
    Medicine(name: 'Amoxicillin', type: 'Capsule', strength: '250mg', category: 'Antibiotic'),
    Medicine(name: 'Ibuprofen', type: 'Tablet', strength: '400mg', category: 'Anti-inflammatory'),
    Medicine(name: 'Cetirizine', type: 'Tablet', strength: '10mg', category: 'Antihistamine'),
    Medicine(name: 'Omeprazole', type: 'Capsule', strength: '20mg', category: 'Antacid'),
    Medicine(name: 'Metformin', type: 'Tablet', strength: '500mg', category: 'Antidiabetic'),
    Medicine(name: 'Aspirin', type: 'Tablet', strength: '75mg', category: 'Antiplatelet'),
    Medicine(name: 'Lisinopril', type: 'Tablet', strength: '10mg', category: 'ACE Inhibitor'),
  ];

  final List<String> frequencies = [
    'Once daily',
    'Twice daily',
    'Three times daily',
    'Four times daily',
    'Every 6 hours',
    'Every 8 hours',
    'Every 12 hours',
    'As needed',
  ];

  final List<String> durations = [
    '3 days',
    '5 days',
    '7 days',
    '10 days',
    '14 days',
    '21 days',
    '1 month',
    '3 months',
    'Until symptoms resolve',
  ];

  void _addMedicine() {
    setState(() {
      prescriptionItems.add(PrescriptionItem());
    });
  }

  void _removeMedicine(int index) {
    if (prescriptionItems.length > 1) {
      setState(() {
        prescriptionItems.removeAt(index);
      });
    }
  }

  void _submitPrescription() {
    if (_formKey.currentState!.validate()) {
      if (selectedPatient == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a patient'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      bool hasValidMedicine = prescriptionItems.any((item) =>
      item.medicineName.isNotEmpty &&
          item.dosage.isNotEmpty &&
          item.frequency.isNotEmpty
      );

      if (!hasValidMedicine) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please add at least one medicine with complete details'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: const Icon(Icons.check_circle, color: Colors.green, size: 48),
          title: const Text('Prescription Created Successfully'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Patient: ${selectedPatient!.name}'),
              Text('Medicines: ${prescriptionItems.where((item) => item.medicineName.isNotEmpty).length}'),
              const SizedBox(height: 10),
              const Text('The prescription has been saved and can be printed or sent electronically.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showPrescriptionPreview();
              },
              child: const Text('Preview'),
            ),
          ],
        ),
      );
    }
  }

  void _showPrescriptionPreview() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Prescription Preview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Dr. Sarah Johnson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Patient Info
                      Text('Patient: ${selectedPatient!.name}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      Text('Age: ${selectedPatient!.age}, Gender: ${selectedPatient!.gender}'),
                      Text('Phone: ${selectedPatient!.phone}'),

                      if (diagnosisController.text.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text('Diagnosis: ${diagnosisController.text}', style: const TextStyle(fontWeight: FontWeight.w600)),
                      ],

                      const SizedBox(height: 20),
                      const Text('Prescription:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),

                      // Medicines
                      ...prescriptionItems.where((item) => item.medicineName.isNotEmpty).map((item) =>
                          Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('• ${item.medicineName}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                Text('  Dosage: ${item.dosage}'),
                                Text('  Frequency: ${item.frequency}'),
                                if (item.duration.isNotEmpty) Text('  Duration: ${item.duration}'),
                                if (item.instructions.isNotEmpty) Text('  Instructions: ${item.instructions}'),
                                Text('  ${item.beforeMeal ? "Before meals" : "After meals"}'),
                              ],
                            ),
                          ),
                      ).toList(),

                      if (notesController.text.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text('Additional Notes: ${notesController.text}'),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Print feature coming soon!')),
                        );
                      },
                      icon: const Icon(Icons.print),
                      label: const Text('Print'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email sent successfully!')),
                        );
                      },
                      icon: const Icon(Icons.email),
                      label: const Text('Email'),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back, color: theme.primaryColor),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.healing, color: theme.primaryColor, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      'Create Prescription',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Patient Selection
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primaryColor.withOpacity(0.1),
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
                                  Icon(Icons.person, color: theme.primaryColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Patient Information',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              DropdownButtonFormField<Patient>(
                                value: selectedPatient,
                                decoration: InputDecoration(
                                  labelText: 'Select Patient',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: const Icon(Icons.search),
                                ),
                                items: patients.map((patient) => DropdownMenuItem(
                                  value: patient,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(patient.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                      Text('${patient.age} years, ${patient.gender}',
                                          style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                    ],
                                  ),
                                )).toList(),
                                onChanged: (patient) {
                                  setState(() {
                                    selectedPatient = patient;
                                  });
                                },
                                validator: (value) => value == null ? 'Please select a patient' : null,
                              ),
                              if (selectedPatient != null) ...[
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.phone, size: 16, color: theme.primaryColor),
                                      const SizedBox(width: 8),
                                      Text(selectedPatient!.phone),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Diagnosis
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primaryColor.withOpacity(0.1),
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
                                  Icon(Icons.medical_information, color: theme.primaryColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Diagnosis',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: diagnosisController,
                                decoration: InputDecoration(
                                  labelText: 'Primary Diagnosis',
                                  hintText: 'Enter the primary diagnosis...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: const Icon(Icons.assignment),
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Medicines Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primaryColor.withOpacity(0.1),
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
                                  Icon(Icons.medication, color: theme.primaryColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Medicines',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: _addMedicine,
                                    icon: const Icon(Icons.add_circle),
                                    color: theme.primaryColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              ...prescriptionItems.asMap().entries.map((entry) {
                                int index = entry.key;
                                PrescriptionItem item = entry.value;

                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Medicine ${index + 1}',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          if (prescriptionItems.length > 1)
                                            IconButton(
                                              onPressed: () => _removeMedicine(index),
                                              icon: const Icon(Icons.delete, color: Colors.red),
                                              iconSize: 20,
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),

                                      // Medicine Selection
                                      DropdownButtonFormField<String>(
                                        value: item.medicineName.isEmpty ? null : item.medicineName,
                                        decoration: InputDecoration(
                                          labelText: 'Select Medicine',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        ),
                                        items: medicines.map((medicine) => DropdownMenuItem(
                                          value: medicine.name,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(medicine.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                              Text('${medicine.strength} ${medicine.type} - ${medicine.category}',
                                                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                                            ],
                                          ),
                                        )).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            item.medicineName = value ?? '';
                                          });
                                        },
                                      ),

                                      const SizedBox(height: 12),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Dosage',
                                                hintText: 'e.g., 1 tablet',
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              ),
                                              onChanged: (value) => item.dosage = value,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: DropdownButtonFormField<String>(
                                              value: item.frequency.isEmpty ? null : item.frequency,
                                              decoration: InputDecoration(
                                                labelText: 'Frequency',
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              ),
                                              items: frequencies.map((freq) => DropdownMenuItem(
                                                value: freq,
                                                child: Text(freq),
                                              )).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  item.frequency = value ?? '';
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: DropdownButtonFormField<String>(
                                              value: item.duration.isEmpty ? null : item.duration,
                                              decoration: InputDecoration(
                                                labelText: 'Duration',
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              ),
                                              items: durations.map((duration) => DropdownMenuItem(
                                                value: duration,
                                                child: Text(duration),
                                              )).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  item.duration = value ?? '';
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey[400]!),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text('Timing:', style: TextStyle(color: Colors.grey[600])),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: DropdownButton<bool>(
                                                      value: item.beforeMeal,
                                                      underline: const SizedBox(),
                                                      isExpanded: true,
                                                      items: const [
                                                        DropdownMenuItem(value: true, child: Text('Before meals')),
                                                        DropdownMenuItem(value: false, child: Text('After meals')),
                                                      ],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          item.beforeMeal = value ?? true;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      TextFormField(
                                        decoration: InputDecoration(
                                          labelText: 'Special Instructions (Optional)',
                                          hintText: 'e.g., Take with food, avoid alcohol',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        ),
                                        onChanged: (value) => item.instructions = value,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Additional Notes
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: theme.primaryColor.withOpacity(0.1),
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
                                  Icon(Icons.note_add, color: theme.primaryColor),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Additional Notes',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: notesController,
                                decoration: InputDecoration(
                                  labelText: 'Notes & Recommendations',
                                  hintText: 'Add any additional notes, lifestyle recommendations, or follow-up instructions...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignLabelWithHint: true,
                                ),
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: _submitPrescription,
                            icon: const Icon(Icons.save, color: Colors.white),
                            label: const Text(
                              'Create Prescription',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    patientController.dispose();
    diagnosisController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
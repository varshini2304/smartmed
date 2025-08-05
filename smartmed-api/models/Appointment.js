const mongoose = require('mongoose');

const appointmentSchema = new mongoose.Schema({
  patientEmail: { type: String, required: true },
  doctorName: { type: String, required: true },
  specialty: { type: String, required: true },
  date: { type: String, required: true },
  time: { type: String, required: true },
  patientName: { type: String, required: true },
  patientEmail: { type: String, required: true },
  notes: { type: String, default: '' },
  status: { type: String, enum: ['confirmed', 'pending', 'cancelled'], default: 'confirmed' },
  fee: { type: String, default: '' },
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Appointment', appointmentSchema);

const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  uid: String,
  name: String,
  email: String,
  role: String,
  createdAt: { type: Date, default: Date.now }
});

module.exports = mongoose.model('User', userSchema);

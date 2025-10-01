const mongoose = require('mongoose');

const volunteerSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  phone: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true
  },
  option: {
    type: String,
    required: true
  }
});

module.exports = mongoose.model('Volunteer', volunteerSchema);

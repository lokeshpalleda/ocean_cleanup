const mongoose = require('mongoose');

const adminDataSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true
    },
  date: {
     type: String,
      required: true 
    },
  location: {
    latitude: { type: Number, required: true },
    longitude: { type: Number, required: true },
  },
  description: { 
    type: String, 
    required: true 
},
  imageUrl: { 
    type: String, 
    required: true 
},
}, { timestamps: true });

module.exports = mongoose.model('AdminData', adminDataSchema);

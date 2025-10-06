const express = require('express');
const router = express.Router();
const AdminData = require('../models/admindata.model');
const upload = require('../middleware/multer');
const cloudinary = require('../config/cloudinary');

// Upload data route
router.post('/upload', upload.single('image'), async (req, res) => {
  try {
    const { title, date, latitude, longitude, description } = req.body;

    // Multer file check
    if (!req.file) {
      return res.status(400).json({ message: 'Image is required' });
    }

    // Upload image to Cloudinary
    cloudinary.uploader
      .upload_stream({ folder: 'ocean-cleanup' }, async (error, result) => {
        if (error) return res.status(500).json({ message: error.message });

        // Save data in MongoDB
        const newData = new AdminData({
          title,
          date,
          location: { latitude, longitude },
          description,
          imageUrl: result.secure_url, // this is Cloudinary URL
        });

        await newData.save();
        res.status(200).json({ message: 'Data uploaded successfully', data: newData });
      })
      .end(req.file.buffer); // send file buffer to Cloudinary

  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});


// Get all uploaded data
router.get('/history', async (req, res) => {
  try {
    const data = await AdminData.find().sort({ createdAt: -1 });
    res.status(200).json(data);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;

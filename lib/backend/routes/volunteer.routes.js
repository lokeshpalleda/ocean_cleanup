const express=require('express');
const Volunteer=require('../models/volunteer.model');
//const auth = require("../middleware/auth");
//dotenv.config();  
const router=express.Router(); 

router.post("/volunteer", async (req, res) => {
  try {
    const { name, phone, email, option } = req.body;

    if (!name || !phone || !email || !option) {
      return res.status(400).json({ msg: "All fields are required" });
    }

    const newVolunteer = new Volunteer({ name, phone, email, option });
    await newVolunteer.save();

    res.json({ msg: "Volunteer details saved successfully", data: newVolunteer });
  } catch (e) {
    res.status(500).json({ msg: "Server error" });
  }
});

router.get("/volunteers", async (req, res) => {
  try {
    const volunteers = await Volunteer.find();
    res.json(volunteers);
  } catch (e) {
    res.status(500).json({ msg: "Server error" });
  }
});

module.exports=router;
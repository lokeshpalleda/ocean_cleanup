const express=require('express');
const dotenv=require('dotenv');
const connectDb = require('./config/db');
const authRoutes = require('./routes/auth.routes');
const volunteerRoutes = require("./routes/volunteer.routes");
const cors = require('cors');
const app=express()
const adminRoutes = require('./routes/admin.routes');

//database
dotenv.config();
connectDb();

app.use(cors()); 
//middleware
app.use(express.json());

app.get("/", (req, res) => {
  res.send("Backend is running!");
});

//routes
app.use("/api/auth", authRoutes);
app.use("/api", volunteerRoutes);
app.use('/api/admin', adminRoutes);

//running
const PORT=process.env.PORT ||3000
app.listen(PORT,()=>
    console.log(`Server running on ${PORT}`)
)
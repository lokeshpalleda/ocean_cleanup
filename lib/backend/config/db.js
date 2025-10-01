const mongoose=require('mongoose');
const connectDb=async() =>{
    try{
        await mongoose.connect(process.env.MONGO_URI);
        console.log("MongoDB Connected");
    }catch(e){
        console.error("MongoDB Connection Failed", e);
    process.exit(1);
    }
}

module.exports=connectDb;
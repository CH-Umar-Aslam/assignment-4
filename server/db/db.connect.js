import mongoose from "mongoose";

const connectDB=()=>{
    try {
      const connected = mongoose.connect("mongodb://localhost:27017",{dbName:"flutterApi"})
        if(connected) console.log("DB Connected")
        
    } catch (error) {
        
    }
}

export default connectDB
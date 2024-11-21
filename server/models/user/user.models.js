import mongoose  from "mongoose";
const userSchema= mongoose.Schema({
    name:{
        type:String,
        required:true,
    },
    email:{
        type:String,
        unique:true,
        required:true,
    },
    age:{
        type:Number,
        required:true
        
    },
    city:{
        type:String,
        unique:true,
        required:true,
    },
    gender:{
        type:String,
        enum:["male","female"],
        required:true,
    },
    employed:{
        type:Boolean,
        required:true,
    }

    

},{timestamps:true})



const User = mongoose.model("User",userSchema)

export default User
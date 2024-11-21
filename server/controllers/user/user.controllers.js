import User from "../../models/user/user.models.js";

const createUser=async(req,res)=>{
    const {name,email,age,city,employed,gender}=req.body
    if (!name || !email || !age || !city || employed==undefined || !gender)  return res.json({message:"all fields are required"}) .status(400)
        try {
            const newUser= new User({
                name,
                email,
                age,
                city,
                employed,
                gender
            })
    
            const createdUser = await newUser.save()
            if(!createdUser)  return res.json({message:"user creation failed"}) .status(400)
            
            res.json({message:"user created successfully"}) .status(200)
            
        } catch (error) {
            return res.json({message:"user creation failed",error}) .status(400)
        }
       

}


const getAllUsers=async(req,res)=>{
    try {
        const users=await User.find()
        if(!users)   return res.json({message:"no user available"}) .status(400)

        return res.json({users,message:"user retrieved successfully"}) .status(200)

    } catch (error) {
        return res.json({message:"user retrieval failed"},error) .status(400)
        
    }
            
       
       

}


export {createUser,getAllUsers}
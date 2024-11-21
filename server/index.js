import express from "express"
import cors from "cors"
import connectDB from "./db/db.connect.js";
import userRoutes from "./routes/user/user.routes.js"

const app = express();

connectDB()


app.use(cors());
app.use(express.json());


app.use('/api/example', (req,res)=>{
    res.send("end point is working")
});
app.use("/user",userRoutes)

app.listen(8800, () => {
  console.log(`Server is running on port 8800`);
});

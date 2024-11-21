import { getAllUsers, createUser } from "../../controllers/user/user.controllers.js"
import express from "express"

const router = express.Router()

router.post("/create",createUser)
router.get("/",getAllUsers)


export default router
import express from "express";
import { register } from "../controllers/register.js";

const router = express.Router();


router.get("", (req, res) => {
    res.send("register");
})


router.post("",register);

export default router;
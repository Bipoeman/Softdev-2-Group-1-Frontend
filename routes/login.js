import express from "express";
import {signToken} from "./token/token.js";
import { loginController } from "../controllers/login";

const router = express.Router();

router.get("", (req, res) => {
    res.send("login");
});


router.get("/text",(req, res)=>{
    res.send("sdjhufhs")
})



router.post("", loginController);




export default router;
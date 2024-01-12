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

router.post("", (req, res) => {
        const username = req.body.username;
        const password = req.body.password;
        if (username === "admin" && password === "admin") {
            res.send(signToken(2,"allah"));
        }
        else {
            res.send("login fail");
        }
    }
);

router.post("/", loginController);




export default router;
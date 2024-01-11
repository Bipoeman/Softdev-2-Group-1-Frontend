import express from "express";
import { loginController } from "../controllers/login";

const router = express.Router();

router.get("/", (req, res) => {
    res.send("login");
});

router.post("/", loginController);



export default router;
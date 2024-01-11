import express from "express";

const router = express.Router();

router.get("/", (req, res) => {
    res.send("login");
});

router.post("/", (req, res) => {
        const username = req.body.username;
        const password = req.body.password;
        if (username === "admin" && password === "admin") {
            res.send("login success");
        }
        else {
            res.send("login fail");
        }
    }
);



export default router;
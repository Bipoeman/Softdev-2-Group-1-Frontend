import express from "express";

const router = express.Router();


router.get("", (req, res) => {
    res.send("register");
})


router.post("", (req, res) => {

    const username = req.body.username;
    const password = req.body.password;
    const passwordagain = req.body.passwordagain;
    if (username === "admin" && password === "admin" && passwordagain === "admin") {
        res.send("register success");
    }
    else {
        res.send("register fail");
    }
});
    export default router;
const loginController = (req, res) => {
    const username = req.body.username;
    const password = req.body.password;
    if (username === "admin" && password === "admin") {
        res.send("login success");
    }
    else {
        res.status(401);
        res.send("login fail");
    }
}

module.exports = { loginController };
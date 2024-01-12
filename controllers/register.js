const register = (req, res) => {

    const username = req.body.username;
    const password = req.body.password;
    const passwordagain = req.body.passwordagain;
    if (username === "admin" && password === "admin" && passwordagain === "admin") {
        res.send("register success");
    }
    else {
        res.send("register fail");
    }
}

module.exports = { register };
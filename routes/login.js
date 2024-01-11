import express from "express";
const router =express.Router();

router.post("/",(req,res)=>{
    const username = req.body.username;
    const password = req.body.password;
    if(username==="admin" && password==="admin"){
        res.send("login success");
}
}
);


export default router;
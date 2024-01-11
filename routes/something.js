import express from 'express';
const router = express.Router();


//  path /rou/
router.get('/', (req, res) => {
    res.send('Hello World! from toruter');
})


export default router;
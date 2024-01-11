import express from 'express';
import rou from './routes/rou.js';
const app = express();
const port = 3000;
app.use("/rou", rou);

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(3000, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});
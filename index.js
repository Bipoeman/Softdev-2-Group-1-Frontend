import express from 'express';
import rou from './routes/something.js';
import login from './routes/login.js';
const app = express();
const port = 3000;
app.use("/something", rou);
app.use(express.json());
app.use("/login", login);

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(3000, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});
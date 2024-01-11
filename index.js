import express from 'express';
import rou from './routes/something.js';
import login from './routes/login.js';
import register from './routes/register.js';
const app = express();
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/something ", rou);
app.use("/login", login);
app.use("/register", register);

app.get('/', (req, res) => {
    res.send('Hello World!');
});

app.listen(3000, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});
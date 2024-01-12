import fs from 'fs';
import mysql from 'mysql';

const certPath = path.join(__dirname, './cert.pem');
const serverCa = fs.readFileSync(certPath);
const conn = mysql.createConnection({
    host: process.env.host, user: process.env.user, // Do not use username as it will be collided with host username
    password: process.env.password, database: process.env.database, port: 3306, ssl: {
        rejectUnauthorized: true, ca: serverCa
    }
});



// connect to database
conn.connect(function (err) {
    if (err) throw err;
    console.log("sql start");
});

export default conn;

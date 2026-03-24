const express = require('express');
const mysql = require('mysql2');
const path = require('path');

const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

const db = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'admin',
    password: process.env.DB_PASSWORD || 'Shubham11',
    database: process.env.DB_NAME || 'car_showroom'
});

db.connect(err => {
    if (err) console.error('RDS Connection Error:', err);
    else console.log('Connected to Car Showroom Database.');
});

app.get('/api/cars', (req, res) => {
    db.query('SELECT * FROM cars', (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

const PORT = 3000;
app.listen(PORT, () => console.log(`Showroom Live: http://localhost:${PORT}`));

const mysql = require('mysql2/promise');

async function seed() {
    const db = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_NAME
    });

    await db.query(`CREATE TABLE IF NOT EXISTS cars (id INT AUTO_INCREMENT PRIMARY KEY, brand VARCHAR(50), model VARCHAR(50), price INT, image_url VARCHAR(255))`);
    await db.query(`DELETE FROM cars`);

    const cars = [
        ['Tesla', 'Model S', 89000, 'https://images.unsplash.com/photo-1617788138017-80ad40651399?w=400'],
        ['BMW', 'M4 Competition', 78000, 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=400'],
        ['Audi', 'RS e-tron GT', 106000, 'https://images.unsplash.com/photo-1614200187524-dc5b8ec221bd?w=400'],
        ['Porsche', '911 Carrera', 114000, 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=400'],
        ['Ferrari', '296 GTB', 322000, 'https://images.unsplash.com/photo-1592198084033-aade902d1aae?w=400'],
        ['Lamborghini', 'Huracán Evo', 206000, 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=400'],
        ['Mercedes', 'AMG GT', 118000, 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=400'],
        ['Nissan', 'GT-R Nismo', 210000, 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400'],
        ['Ford', 'Mustang Dark Horse', 59000, 'https://images.unsplash.com/photo-1584345604476-8ec5e12e42dd?w=400'],
        ['Toyota', 'Supra MKV', 56000, 'https://images.unsplash.com/photo-1626014303757-6366116894c7?w=400']
    ];

    await db.query(`INSERT INTO cars (brand, model, price, image_url) VALUES ?`, [cars]);
    console.log("✅ Showroom Seeded!");
    process.exit();
}
seed();

const mysql = require('mysql2/promise');

async function seed() {
    const db = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER || 'admin',
        password: process.env.DB_PASSWORD || 'Shubham11',
        database: process.env.DB_NAME || 'car_showroom'
    });

    try {
        console.log("Connected to RDS. Cleaning up old data...");
        await db.query(`CREATE TABLE IF NOT EXISTS cars (
            id INT AUTO_INCREMENT PRIMARY KEY,
            brand VARCHAR(50),
            model VARCHAR(50),
            price INT,
            image_url VARCHAR(500)
        )`);
        await db.query(`DELETE FROM cars`);

        const cars = [
            ['Tesla', 'Model S Plaid', 89000, 'https://images.unsplash.com/photo-1617788138017-80ad40651399?auto=format&fit=crop&q=80&w=600'],
            ['BMW', 'M4 Competition', 78000, 'https://images.unsplash.com/photo-1555215695-3004980ad54e?auto=format&fit=crop&q=80&w=600'],
            ['Audi', 'RS e-tron GT', 106000, 'https://www.autovisie.nl/wp-content/uploads/2020/11/Schermafbeelding-2020-11-03-om-21.49.26.png'],
            ['Porsche', '911 Carrera', 114000, 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=600'],
            ['Ferrari', '296 GTB', 322000, 'https://images.unsplash.com/photo-1592198084033-aade902d1aae?auto=format&fit=crop&q=80&w=600'],
            ['Lamborghini', 'Huracán Evo', 206000, 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&q=80&w=600'],
            ['Mercedes', 'AMG GT', 118000, 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&q=80&w=600'],
            ['Nissan', 'GT-R Nismo', 210000, 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&q=80&w=600'],
            ['Ford', 'Mustang Dark Horse', 59000, 'https://images.unsplash.com/photo-1584345604476-8ec5e12e42dd?auto=format&fit=crop&q=80&w=600'],
            ['Toyota', 'Supra MKV', 56000, 'https://photo-voiture.motorlegend.com/high/toyota-supra-mkv-2-0-258-ch-130263.jpg']
        ];

        await db.query(`INSERT INTO cars (brand, model, price, image_url) VALUES ?`, [cars]);
        console.log("✅ Showroom Seeded with 10 High-Quality Images!");
    } catch (err) {
        console.error("❌ Seeding Error:", err);
    } finally {
        await db.end();
        process.exit();
    }
}

seed();

import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

const pool = mysql.createPool({
    host: process.env.MYSQL_PROD_DB_HOST,
    user: process.env.MYSQL_PROD_DB_USERNAME,
    password: process.env.MYSQL_PROD_DB_PASSWORD,
    database: process.env.MYSQL_PROD_DB_NAME,
    port: process.env.MYSQL_PROD_DB_PORT ? parseInt(process.env.MYSQL_PROD_DB_PORT) : 3306,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

export async function testDBConnection() {
    const connection = await pool.getConnection();
    try {
        await connection.ping();
        console.log(`Connected to mysql database name: ${process.env.MYSQL_PROD_DB_NAME}`);
    }
    catch (err) {
        console.log("Could not connect to mysql database");
        process.exit(1);
    }
}

export default pool;
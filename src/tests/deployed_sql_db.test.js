import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

describe('my deployed mysql connection test', () => {

    let connection; 

    beforeAll(async () => {
        const mysqlConfig = {
            host: process.env.MYSQL_PROD_DB_HOST,
            user: process.env.MYSQL_PROD_DB_USERNAME,
            password: process.env.MYSQL_PROD_DB_PASSWORD,
            database: process.env.MYSQL_PROD_DB_NAME,
            port: process.env.MYSQL_PROD_DB_PORT
        }; 

        connection = await mysql.createConnection(mysqlConfig);
    });

    test('should connect to deployed mysql database', async () => {
        try {
            const [rows] = await connection.execute('SELECT DATABASE() AS databaseName');
            const databaseName = rows[0].databaseName;

            expect(databaseName === 'kea_library').toBe(true);
        }catch (err) {
            console.error(err);
        }
    });

    afterAll(async () => {
        await connection.end();
    });
});
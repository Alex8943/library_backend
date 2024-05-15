import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

dotenv.config();

describe('my local mysql connection test', () => {

  let connection;

  beforeAll(async () => {
    const mysqlConfig = {
      host: '127.0.0.1',
      user: process.env.MYSQL_DEV_DB_USER,
      password: process.env.MYSQL_DEV_DB_PASSWORD,
      database: process.env.MYSQL_DEV_DB_NAME,
      port: '3306'
    };

    connection = await mysql.createConnection(mysqlConfig);


  });

  afterAll(async () => {
    if (connection && connection.end) {
      await connection.end();
    }
  });

  test('should connect to local mysql database', async () => {
    try {
      const [rows] = await connection.execute('SELECT DATABASE() AS databaseName');
      const databaseName = rows[0].databaseName;

      expect(databaseName).toBe('test_db'); // Adjust to match the test DB name
    } catch (err) {
      console.error(err);
      throw err; // Rethrow to ensure the test fails on error
    }
  });

    test('should return all books from the database', async () => {
        try {
            const [rows] = await connection.execute('SELECT * FROM books');
            const books = rows;

            expect(books.length > 0).toBe(true);

        }
        catch (err) {
            console.error(err);
        }
    });

    test('should return all authors from the database', async () => {
        try {
            const [rows] = await connection.execute('SELECT * FROM authors');
            const authors = rows;

            expect(authors.length > 0).toBe(true);

        }
        catch (err) {
            console.error(err);
        }
    });


    afterAll(async () => {
        await connection.end();
    })
})
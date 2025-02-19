const mysql = require("mysql2");
require("dotenv").config();

const pool = mysql
  .createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0,
  })
  .promise();

// Prueba de conexión a la base de datos
async function testConnection() {
  try {
    const [rows, fields] = await pool.execute("SELECT 1 + 1 AS result");
    console.log("Conexión exitosa a la base de datos:", rows[0].result);
  } catch (error) {
    console.error("Error al conectar a la base de datos:", error);
  }
}

testConnection();

module.exports = pool;

const express = require("express");
const router = express.Router();
const pool = require("./db"); // Conexión a la base de datos
const client = require("./redis"); // Conexión a Redis

// Ruta para obtener el ranking de productos más vendidos
router.get("/ranking", async (req, res) => {
  try {
    const { cantidad } = req.query; // Número de productos a obtener
    const limite = cantidad ? parseInt(cantidad) : 10; // Si no se especifica, por defecto son 10 productos

    const cacheKey = `ranking_${limite}`; // Clave de caché para Redis
    const cachedData = await client.get(cacheKey); // Verificamos si los datos están en caché

    if (cachedData) {
      // Si están en caché, los devolvemos directamente
      return res.json(JSON.parse(cachedData));
    }

    // Si no están en caché, hacemos la consulta a la base de datos
    const [result] = await pool.query(
      `SELECT p.id_producto, p.nombre, pr.precio, r.cantidad 
       FROM ranking r
       JOIN productos p ON r.id_producto = p.id_producto
       JOIN precios pr ON p.id_producto = pr.id_producto
       ORDER BY r.cantidad DESC
       LIMIT ?`,
      [limite]
    );

    // Creamos el ranking con los productos ordenados por cantidad de ventas
    const ranking = result.map((producto, index) => ({
      rank: index + 1,
      id: producto.id_producto,
      nombre: producto.nombre,
      ventas: producto.cantidad,
    }));

    // Almacenamos en Redis durante 60 segundos
    await client.setEx(cacheKey, 60, JSON.stringify(ranking));

    // Respondemos con el ranking de productos
    res.json(ranking);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error en el servidor" });
  }
});

// Exportamos el router para usarlo en el servidor
module.exports = router;

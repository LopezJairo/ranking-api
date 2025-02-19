const express = require("express");
const dotenv = require("dotenv");
const routes = require("./routes"); // Importamos las rutas desde routes.js

dotenv.config(); // Cargar las variables de entorno

const app = express();

app.use(express.json()); // Middleware para parsear JSON
app.use("/api", routes); // Usar el router en la ruta /api

app.listen(3000, () =>
  console.log("🚀 Servidor corriendo en http://localhost:3000")
);

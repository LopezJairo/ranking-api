const redis = require("redis");

const client = redis.createClient({
  socket: {
    host: "localhost",
    port: 6379,
  },
});

client
  .connect()
  .then(() => console.log("Conectado a Redis"))
  .catch((err) => console.error("Error conectando a Redis:", err));

module.exports = client;

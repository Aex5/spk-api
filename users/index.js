const connection = require("../utils/db");

const getUsers = async (request, h) => {
  try {
    // Query untuk menghitung jumlah pengguna
    const userCount = await new Promise((resolve, reject) => {
      connection.query(
        "SELECT COUNT(id) as count FROM users",
        (error, results) => {
          if (error) {
            return reject(error);
          } else {
            return resolve(results[0].count); // Mengambil nilai count dari hasil query
          }
        }
      );
    });

    // Query untuk mendapatkan data pengguna
    const users = await new Promise((resolve, reject) => {
      connection.query("SELECT * FROM users", (error, results) => {
        if (error) {
          return reject(error);
        } else {
          return resolve(results);
        }
      });
    });

    return h
      .response({
        status: "success",
        message: "successfully loaded",
        data: {
          count: userCount,
          users: users,
        },
      })
      .code(200);
  } catch (error) {
    return h
      .response({
        status: "error",
        message: error.message || "Internal Server Error",
      })
      .code(error.status || 500);
  }
};

module.exports = {
  getUsers,
};

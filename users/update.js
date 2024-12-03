const connection = require("../utils/db");

const updateUser = async (request, h) => {
  const { email, username, name, password, token, role_id } = request.payload;
  const { user_id } = request.params; // Extract the user ID from the route parameter

  try {
    // Check if the user exists
    const user = await new Promise((resolve, reject) => {
      connection.query(
        "SELECT * FROM users WHERE id = ?",
        [user_id],
        (error, results) => {
          if (error) {
            return reject(error);
          } else if (results.length === 0) {
            return reject({ status: 404, message: "User not found" });
          }
          return resolve(results[0]);
        },
      );
    });

    // Update user information
    await new Promise((resolve, reject) => {
      const query = `
        UPDATE users 
        SET email = ?, username = ?, name = ?, password = ?, token = ?, role_id = ?
        WHERE id = ?
      `;
      const values = [email, username, name, password, token, role_id, user_id];
      connection.query(query, values, (error, results) => {
        if (error) {
          return reject(error);
        }
        return resolve(results);
      });
    });

    return h
      .response({
        status: "success",
        message: "User updated successfully",
        data: {
          id: user_id,
          email,
          username,
          name,
          role_id,
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
  updateUser,
};

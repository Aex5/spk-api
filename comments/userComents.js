const connection = require("../utils/db");

const getUserComment = async (request, h) => {
  const { user_id } = request.params;
  console.log(user_id)
  try {
    const comments = await new Promise((resolve, reject) => {
      connection.query(
        `SELECT c.comment, c.created_at, u.username, d.destination_name FROM comments c JOIN users u ON c.user_id = u.id JOIN destinations d ON c.destination_id = d.id WHERE c.user_id = ${user_id} ORDER BY c.created_at DESC`,
        [user_id],
        (error, results) => {
          if (error) {
            return reject(error);
          }
          resolve(results);
        },
      );
    });

    return h
      .response({
        status: "success",
        data: comments,
      })
      .code(200);
  } catch (error) {
    return h
      .response({
        status: "error",
        message: error.message || "Internal Server Error",
      })
      .code(500);
  }
};

module.exports = {
  getUserComment,
};

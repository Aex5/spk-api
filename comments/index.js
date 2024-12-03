const connection = require("../utils/db");

const getComment = async (request, h) => {
  const { destination_id } = request.params;

  try {
    const comments = await new Promise((resolve, reject) => {
      connection.query(
        `SELECT c.comment, c.created_at, u.username FROM comments c JOIN users u ON c.user_id = u.id WHERE c.destination_id = '${destination_id}' ORDER BY c.created_at DESC`,
        [destination_id],
        (error, results) => {
          if (error) {
            return reject(error);
          }
          resolve(results);
        }
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
    getComment
}

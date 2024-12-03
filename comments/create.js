const connection = require("../utils/db");

const postCommentHandler = async (request, h) => {
  const { user_id, destination_id, comment } = request.payload;
  try {
    const result = await new Promise((resolve, reject) => {
      connection.query(
        `INSERT INTO comments (user_id, destination_id, comment, created_at) VALUES ('${user_id}', '${destination_id}', '${comment}', NOW())`,
        [user_id, destination_id, comment],
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
        message: "Comment added successfully",
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
    postCommentHandler
}

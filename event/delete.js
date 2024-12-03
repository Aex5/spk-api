const connection = require("../utils/db");

const deleteEventHandler = async (request, h) => {
  const { event_id } = request.params;
  
  try {
    const results = await new Promise((resolve, reject) => {
      connection.query(
        `DELETE FROM event WHERE event_id = ${event_id}`,
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
        message: "Event deleted successfully",
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
  deleteEventHandler
}

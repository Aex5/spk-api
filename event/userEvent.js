const connection = require("../utils/db");

const detailEventUser = async (request, h) => {
  try {
    const { user_id } = request.params;

    if (!user_id) {
      return h
        .response({
          status: "error",
          message: "User ID tidak ditemukan",
        })
        .code(400);
    }

    const results = await new Promise((resolve, reject) => {
      connection.query(
        `SELECT booking.*, event.event_name as event_name, destinations.destination_name as destination_name
         FROM booking 
         JOIN event ON booking.event_id = event.event_id 
         JOIN destinations ON event.destination_id = destinations.id
         WHERE booking.user_id = ?`,
        [user_id], // Menggunakan parameter placeholder
        (error, results) => {
          if (error) {
            console.error(error);
            reject(error);
          } else {
            resolve(results);
          }
        },
      );
    });

    return h
      .response({
        status: "success",
        data: results,
      })
      .code(200);
  } catch (error) {
    console.error("Error searching destinations:", error);
    return h
      .response({
        status: "error",
        message: error.message,
      })
      .code(500);
  }
};

module.exports = {
  detailEventUser,
};

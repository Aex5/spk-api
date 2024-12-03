const connection = require("../utils/db");

const createEventHandler = async (request, h) => {
  console.log(request.payload);
  const { event_name, event_date, event_description, destination_id } = request.payload;
  
  try {
    const results = await new Promise((resolve, reject) => {
      connection.query(
        `INSERT INTO event (event_name, event_date, event_description, destination_id) VALUES ('${event_name}', '${event_date}', '${event_description}', '${destination_id}')`,
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
        message: "Event created successfully",
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
    createEventHandler
}

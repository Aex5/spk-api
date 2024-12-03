const connection = require("../utils/db");

const getEvent = async (request, h) => {
  try {
    const results = await new Promise((resolve, reject) => {
      const query = `
            SELECT 
          event.event_id, 
          event.event_name, 
          event.event_date, 
          event.event_description, 
          event.destination_id,
          destinations.destination_name
        FROM 
          event
        JOIN 
          destinations
        ON 
          event.destination_id = destinations.id
      `;
      
      connection.query(query, (error, results) => {
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
        data: results
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
  getEvent
};

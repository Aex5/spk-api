const connection = require("../utils/db");

const registerBookingHandler = async (request, h) => {
  const { user_id, event_id, name, email, phone } = request.payload;

  try {
    // Cek apakah user sudah terdaftar pada event yang sama
    const isAlreadyRegistered = await new Promise((resolve, reject) => {
      connection.query(
        `SELECT * FROM booking WHERE email = '${email}' AND event_id = '${event_id}'`,
        (error, results) => {
          if (error) {
            return reject(error);
          }
          resolve(results.length > 0); // True jika sudah terdaftar
        },
      );
    });

    if (isAlreadyRegistered) {
      return h
        .response({
          status: "fail",
          message: "Email sudah terdaftar untuk event ini",
        })
        .code(400); // Kembalikan status 400 jika user sudah terdaftar
    }

    // Jika belum terdaftar, lanjutkan dengan melakukan INSERT
    const results = await new Promise((resolve, reject) => {
      connection.query(
        `INSERT INTO booking (user_id, event_id, booking_date, name, email, phone) VALUES ('${user_id}', '${event_id}', NOW(), '${name}', '${email}', '${phone}')`,
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
        message: "Registrasi Berhasil",
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
  registerBookingHandler,
};

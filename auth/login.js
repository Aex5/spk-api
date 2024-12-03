const jwt = require("jsonwebtoken");
const connection = require("../utils/db");

const secretKey = "secret123";

const isValidEmail = (email) => {
  // Regex untuk memvalidasi format email
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

const loginHandler = async (request, h) => {
  const { email, password } = request.payload;

  if (!isValidEmail) {
    return h.response({
        status: "error",
        message: "Invalid email format",
      }).code(400);
  }

  try {
    const results = await new Promise((resolve, reject) => {
      connection.query(
        `SELECT * FROM users WHERE email='${email}' AND password='${password}'`,
        (error, results) => {
          if (error) {
            reject(error);
          } else if (results.length === 0) {
            resolve({
              status: "error",
              message: "Invalid email or password",
            });
          } else {
            const user = results[0];
            const token = jwt.sign(
              { userId: user.id, username: user.username },
              secretKey,
              { expiresIn: "1h" }
            );

            connection.query(
              `UPDATE users SET token='${token}', role_id=3 WHERE id=${user.id}`
            );

            resolve({
              status: "success",
              message: "Login successfully",
              data: {
                userId: user.id,
                name: user.username,
                email: user.email,
                token: token,
              },
            })
          }
        }
      );
    });

    const statusCode = results.error ? 401 : 200;
    return h.response(results).code(statusCode);
  } catch (error) {
    return h
      .response({
        status: "error",
        message: "Internal Server Error",
      })
      .code(500);
  }
};

exports.loginHandler = loginHandler;

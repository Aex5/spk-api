const jwt = require("jsonwebtoken");

const secretKey = 'secret123';

const authMiddleware = (request, h) => {
  const token = request.headers.authorization;

  console.log(!token);

  return h.response({
    status: "success",
    message: "Authentication successful",
  });
};

module.exports = authMiddleware;
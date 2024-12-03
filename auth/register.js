const connection = require('../utils/db');

// Regex for email validation
const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

const validateEmail = (email) => {
  return emailPattern.test(email);
};

// cek apakah field terisi
const validateRegistrationData = (data) => {
  const errors = [];

  if (!data.username) {
    errors.push('Username is required');
  }

  if (!data.password) {
    errors.push('Password is required');
  }

  if (!data.email) {
    errors.push('Email is required');
  } else if (!validateEmail(data.email)) {
    errors.push('Please enter a valid email address');
  }

  return errors;
};

const registerHandler = async (request, h) => {
  const { username, password, email } = request.payload;

  const validationErrors = validateRegistrationData({ username, password, email });

  if (validationErrors.length > 0) {
    return h.response({
      status: 'Error',
      message: validationErrors.join(', '), // Combine errors into a single message
    }).code(400);
  }

  try {
    const results = await new Promise((resolve, reject) => {
      connection.query(
        `INSERT INTO users (username, email, password, role_id) VALUES ('${username}', '${email}', '${password}', 2)`,
        (error, results) => {
          if (error) {
            if (error.code === "ER_DUP_ENTRY") {
              return reject(new Error('Email already in use'));
            } else {
              return reject(error);
            }
          }
          resolve(results);
        }
      );
    });

    return h.response({
        status: "success",
        message: "User registered successfully",
      }).code(200);
  } catch (error) {
    // Handle duplicate email error specifically
    if (error.message === 'Email already in use') {
      return h.response({
        status: 'Error',
        message: error.message,
      }).code(400);
    }

    // Handle other errors
    return h.response({
        status: "error",
        message: error.message || "Internal Server Error",
      }).code(error.status || 500);
  }
};

exports.registerHandler = registerHandler;

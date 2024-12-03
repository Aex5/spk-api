const connection = require('../utils/db');

const searchDestination = async (request, h) => {
    try {
        const { name } = request.params; // Destructure to get the 'name' parameter

        if (!name) {
            throw new Error('Missing required parameter: name'); // Handle missing parameter
        }

        // Use parameterized queries to prevent SQL injection
        const results = await new Promise((resolve, reject) => {
            connection.query('SELECT * FROM destinations WHERE destination_name LIKE ?', [`%${name}%`], (error, results) => {
                if (error) {
                    console.error(error);
                    reject(error);
                } else {
                    resolve(results);
                }
            });
        });

        return h.response({
            status: 'success',
            data: results
        }).code(200);

    } catch (error) {
        console.error('Error searching destinations:', error);
        return h.response({
            status: 'error',
            message: error.message
        }).code(500);
    }
};

module.exports = {
    searchDestination
};

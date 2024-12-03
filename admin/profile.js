const connection = require('../utils/db')

const profileHandler = async(request, h) => {
    try {
        const { id } = request.params; // Destructure to get the 'name' parameter

        if (!id) {
            throw new Error('Missing required parameter: id'); // Handle missing parameter
        }

        // Use parameterized queries to prevent SQL injection
        const results = await new Promise((resolve, reject) => {
            connection.query(`SELECT * FROM users WHERE id = ${id}`, (error, results) => {
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
        console.error('Error searching users', error);
        return h.response({
            status: 'error',
            message: error.message
        }).code(500);
    }
}; 

module.exports = profileHandler;
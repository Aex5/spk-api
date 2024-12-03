const connection = require('../utils/db');

const topDestination = async (request, h) => {
    try {
        // Use parameterized queries to prevent SQL injection
        const results = await new Promise((resolve, reject) => {
            connection.query('SELECT * FROM destinations ORDER BY jumlah_pengunjung DESC LIMIT 3', (error, results) => {
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
    topDestination
};

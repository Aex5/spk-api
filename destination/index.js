const connection = require('../utils/db');

const getDestinations = async (request, h) => {
    try {
        const [destinations, countResult] = await Promise.all([
            new Promise((resolve, reject) => {
                const query = 'SELECT * FROM destinations';
                connection.query(query, (error, results) => {
                    if (error) {
                        console.error(error);
                        reject(error);
                    } else {
                        resolve(results);
                    }
                });
            }),
            new Promise((resolve, reject) => {
                const query = 'SELECT COUNT(id) AS total_destination FROM destinations';
                connection.query(query, (error, results) => {
                    if (error) {
                        console.error(error);
                        reject(error);
                    } else {
                        resolve(results[0].total_destination);
                    }
                });
            })
        ]);
        return h.response({
            status: 'success',
            total_destination: countResult,
            data: destinations
        }).code(200);

    } catch (error) {
        return h.response({
            status: 'error',
            message: `error: ${error}`
        }).code(500);
    }
};

exports.getDestinations = getDestinations;

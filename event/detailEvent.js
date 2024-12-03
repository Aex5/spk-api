const connection = require('../utils/db');

const detailEvent = async (request, h) => {
    try {
        const { event_id } = request.params; 
        const {user_id}    = request.params;

        if (!event_id) {
            throw new Error('Missing required parameter: event_id'); 
        }

        const results = await new Promise((resolve, reject) => {
            connection.query(`SELECT * FROM booking WHERE event_id = ${event_id} AND user_id = ${user_id}`, (error, results) => {
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
    detailEvent
};

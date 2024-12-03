const Hapi = require('@hapi/hapi');
const routes = require('./routes')

const init = async () => {
    const server = Hapi.server({
        port: 3001,
        host: 'localhost',
        routes: {
            cors: {
                origin: ['http://localhost:3000'], // Mengizinkan permintaan dari http://localhost:3000
                headers: ['Accept', 'Content-Type'],
                exposedHeaders: ['WWW-Authenticate', 'Server-Authorization'],
                additionalExposedHeaders: ['accept', 'authorization'],
                maxAge: 60,
                credentials: true
            }
        }
    });

    server.route(routes);

    await server.start();
    console.log('Server running on %s', server.info.uri);
};

process.on('unhandledRejection', (err) => {
    console.log(err);
    process.exit(1);
});

init();

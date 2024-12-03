const connection = require('../utils/db');

function categoryToNumber(category) {
    const categories = {
        'nongki': 1,
        'alam': 2,
        // Tambahkan kategori lainnya sesuai dengan data Anda
    };
    return categories[category] || 0; // Kembalikan 0 jika kategori tidak ditemukan
}

const criteria = [
    { name: 'Jarak', priority: 1, formula: [1, 1/2, 1/3, 1/4] },
    { name: 'Harga Tiket', priority: 2, formula: [0, 1/3, 1/4] },
    { name: 'Jumlah Pengunjung', priority: 3, formula: [0, 0, 1/4] }
];

function calculateWeights(criteria) {
    const total = criteria.reduce((acc, curr) => acc + 1 / curr.priority, 0);
    return criteria.map(criterion => ({
        name: criterion.name,
        weight: parseFloat(((1 / criterion.priority) / total).toFixed(2))
    }));
}

function calculatePercentage(weights) {
    const totalWeight = weights.reduce((acc, curr) => acc + curr.weight, 0);
    return weights.map(weight => ({
        name: weight.name,
        percentage: Math.round((weight.weight / totalWeight) * 100)
    }));
}


const haversineDistance = (lat1, lon1, lat2, lon2) => {
    const R = 6371; // Radius of the Earth in km
    const dLat = (lat2 - lat1) * Math.PI / 180; // Convert degree to radians
    const dLon = (lon2 - lon1) * Math.PI / 180; // Convert degree to radians
    const a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c; // Distance in km
    return distance;
};

const predictHandler2 = async function (request, h) {
    try {
        const { rating, category, userLongLat } = request.payload;

        console.log('Received request with payload:', request.payload);

        // Validasi input user
        if (isNaN(parseFloat(rating)) || categoryToNumber(category) === 0 || !userLongLat || !userLongLat.match(/^-?\d+\.\d+,-?\d+\.\d+$/)) {
            console.log('Invalid input data');
            return h.response({
                status: 'error',
                message: 'Invalid input data'
            }).code(400);
        }

        const [userLat, userLong] = userLongLat.split(',').map(parseFloat);

        // Eksekusi query sebagai promise
        const destinations = await new Promise((resolve, reject) => {
            const query = 'SELECT * FROM destinations';
            connection.query(query, (error, results) => {
                if (error) {
                    console.error('Error querying database:', error);
                    reject(error);
                } else {
                    console.log('Retrieved destinations from database:', results);
                    resolve(results);
                }
            });
        });

        // Pastikan data destinasi adalah array
        if (!Array.isArray(destinations)) {
            console.log('Invalid data format');
            throw new Error('Invalid data format');
        }

        // Siapkan data untuk mencari kemiripan
        const inputRating = parseFloat(rating);
        const inputCategory = categoryToNumber(category);

        // Filter destinasi berdasarkan kategori
        const filteredDestinations = destinations.filter(destination => categoryToNumber(destination.category) === inputCategory);

        if (filteredDestinations.length === 0) {
            console.log('No destinations found for the specified category');
            throw new Error('No destinations found for the specified category');
        }

        // Temukan destinasi yang paling mirip dan kumpulkan informasi pembanding
        const comparisons = [];
        const weights = calculateWeights(criteria);

        filteredDestinations.forEach(destination => {
            console.log('Processing destination:', destination);

            const destinationRating = parseFloat(destination.rating);

            // Ambil nilai harga tiket dan jumlah pengunjung dari database
            const hargaTiket = parseFloat(destination.harga_tiket);
            const jumlahPengunjung = parseInt(destination.jumlah_pengunjung);

            console.log('Harga tiket:', hargaTiket);
            console.log('Jumlah pengunjung:', jumlahPengunjung);

            // Hitung jarak antara pengguna dan destinasi
            const [destLat, destLong] = destination.longlat.split(',').map(parseFloat);
            const distance = haversineDistance(userLat, userLong, destLat, destLong);

            // Hitung skor berdasarkan kriteria dengan menggunakan bobot
            const score = (
                weights[0].weight * (1 / (distance + 1)) +
                weights[1].weight * (1 / (hargaTiket + 1)) +
                weights[2].weight * (1 / (jumlahPengunjung + 1))
            );

            comparisons.push({
                id: destination.id,
                destination_name: destination.destination_name,
                distance: distance,
                image: destination.image,
                rating: rating,
                category: category,
                longlat: destination.longlat,
                description: destination.description,
                harga_tiket: hargaTiket,
                jumlah_pengunjung: jumlahPengunjung,
                score: score
            });
        });

        // Urutkan destinasi berdasarkan skor
        comparisons.sort((a, b) => b.score - a.score); // Skor tertinggi di urutan teratas

        // Ambil tiga destinasi teratas
        const nomineeDestinations = comparisons.slice(0, 3);

        // Hitung presentase dari bobot
        const percentages = calculatePercentage(weights);
        const topDestination = nomineeDestinations[0];

        return h.response({
            status: 'success',
            nomineeDestinations: nomineeDestinations, // Menambahkan tiga destinasi teratas
            weights: weights,
            percentages: percentages,
            topDestination: topDestination
        }).code(200);

    } catch (error) {
        console.error('Error finding similar destination:', error);
        return h.response({ status: 'error', message: `Error: ${error.message}` }).code(500);
    }
}

module.exports = predictHandler2;

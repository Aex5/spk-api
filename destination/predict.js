const connection = require("../utils/db");

// Fungsi Haversine Distance
const haversineDistance = (lat1, lon1, lat2, lon2) => {
  const R = 6371; // Radius of the Earth in km
  const dLat = ((lat2 - lat1) * Math.PI) / 180;
  const dLon = ((lon2 - lon1) * Math.PI) / 180;
  const a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos((lat1 * Math.PI) / 180) *
      Math.cos((lat2 * Math.PI) / 180) *
      Math.sin(dLon / 2) *
      Math.sin(dLon / 2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return R * c; // Distance in km
};

// Normalisasi data untuk kriteria minimasi dan maksimasi
const normalize = (values, isMaximization) => {
  const max = Math.max(...values);
  const min = Math.min(...values);
  return values.map((value) => (isMaximization ? value / max : min / value));
};

const predictHandler = async (request, h) => {
  try {
    const { preferences, userLongLat } = request.payload;
    console.log(preferences);

    // Validasi input
    if (
      !preferences ||
      !Array.isArray(preferences) ||
      !userLongLat ||
      !userLongLat.match(/^-?\d+\.\d+,-?\d+\.\d+$/)
    ) {
      return h
        .response({
          status: "error",
          message: "Invalid input data",
        })
        .code(400);
    }

    const [userLat, userLong] = userLongLat.split(",").map(parseFloat);

    // Query data destinasi
    const query = `
            SELECT 
                id, destination_name, description, longlat, image, category, 
                rating, harga_tiket, jumlah_pengunjung 
            FROM destinations;
        `;
    const destinations = await new Promise((resolve, reject) => {
      connection.query(query, (error, results) => {
        if (error) reject(error);
        else resolve(results);
      });
    });

    // Bobot untuk setiap kriteria
    const weights = {
      distance: 4, // Kriteria A - Jarak (40%)
      rating: 3, // Kriteria B - Rating (30%)
      harga_tiket: 2, // Kriteria C - Harga Tiket (20%)
      jumlah_pengunjung: 1, // Kriteria D - Jumlah Pengunjung (10%)
    };

    // Proses preferensi
    const processedPreferences = preferences.map((pref) => ({
      type: pref.type,
      value: pref.value === "true" ? 1 : 0, // Konversi 'true'/'false' ke 1/0
    }));

    // Normalisasi data kriteria
    const distances = destinations.map((destination) => {
      const [destLat, destLong] = destination.longlat
        .split(",")
        .map(parseFloat);
      return haversineDistance(userLat, userLong, destLat, destLong);
    });
    const normalizedDistances = normalize(distances, false); // Minimasi

    const ratings = destinations.map((destination) =>
      parseFloat(destination.rating),
    );
    const normalizedRatings = normalize(ratings, true); // Maksimasi

    const prices = destinations.map((destination) =>
      parseFloat(destination.harga_tiket),
    );
    const normalizedPrices = normalize(prices, false); // Minimasi

    const visitors = destinations.map((destination) =>
      parseInt(destination.jumlah_pengunjung),
    );
    const normalizedVisitors = normalize(visitors, true); // Maksimasi

    // Hitung skor setiap destinasi dengan memasukkan bobot
    const comparisons = destinations.map((destination, index) => {
      let score = 0;

      processedPreferences.forEach((pref) => {
        if (pref.type === "distance") {
          score += pref.value * normalizedDistances[index] * weights.distance; // Bobot jarak
        } else if (pref.type === "rating") {
          score += pref.value * normalizedRatings[index] * weights.rating; // Bobot rating
        } else if (pref.type === "harga_tiket") {
          score += pref.value * normalizedPrices[index] * weights.harga_tiket; // Bobot harga
        } else if (pref.type === "jumlah_pengunjung") {
          score +=
            pref.value * normalizedVisitors[index] * weights.jumlah_pengunjung; // Bobot pengunjung
        }
      });

      return {
        ...destination,
        distance: distances[index].toFixed(2),
        score: parseFloat(score.toFixed(2)), // Dua desimal untuk presisi
      };
    });

    // Urutkan berdasarkan skor
    comparisons.sort((a, b) => b.score - a.score);

    // Ambil tiga destinasi teratas
    const nomineeDestinations = comparisons.slice(0, 3);

    return h
      .response({
        status: "success",
        nomineeDestinations: nomineeDestinations,
      })
      .code(200);
  } catch (error) {
    console.error("Error processing request:", error);
    return h
      .response({
        status: "error",
        message: `Error: ${error.message}`,
      })
      .code(500);
  }
};

module.exports = predictHandler;

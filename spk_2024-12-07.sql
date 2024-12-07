# ************************************************************
# Sequel Ace SQL dump
# Version 20066
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: localhost (MySQL 5.7.44)
# Database: spk
# Generation Time: 2024-12-07 16:03:18 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table booking
# ------------------------------------------------------------

DROP TABLE IF EXISTS `booking`;

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `name` varchar(150) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `booking_status` varchar(50) DEFAULT '0',
  `booking_date` date DEFAULT NULL,
  PRIMARY KEY (`booking_id`),
  KEY `user_id` (`user_id`),
  KEY `booking_ibfk_2` (`event_id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;

INSERT INTO `booking` (`booking_id`, `event_id`, `user_id`, `email`, `name`, `phone`, `booking_status`, `booking_date`)
VALUES
	(1,12,3,'aditdevelop@gmail.com','Adit Test',2147483647,'0','2024-10-24'),
	(2,12,3,'aditfarming@gmail.com','Aditya Argadinata',2147483647,'0','2024-11-20');

/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `destination_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `destination_id` (`destination_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;

INSERT INTO `comments` (`id`, `user_id`, `destination_id`, `comment`, `created_at`)
VALUES
	(42,3,12,'test komen','2024-10-04 11:03:04'),
	(43,3,12,'gomen nasai !!1\n','2024-10-05 00:12:58'),
	(44,3,3,'mantap','2024-10-06 15:14:09'),
	(45,3,5,'bagus tapi agak rame','2024-11-02 19:24:15'),
	(53,3,12,'asdadad','2024-11-29 01:55:44'),
	(54,3,4,'tempatnya bagus\n','2024-11-29 11:01:08');

/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table culinary
# ------------------------------------------------------------

DROP TABLE IF EXISTS `culinary`;

CREATE TABLE `culinary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resto_name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `open` varchar(50) NOT NULL,
  `menu` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `live_music` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `culinary` WRITE;
/*!40000 ALTER TABLE `culinary` DISABLE KEYS */;

INSERT INTO `culinary` (`id`, `resto_name`, `address`, `open`, `menu`, `price`, `live_music`)
VALUES
	(1,'Waroeng Cafe 27','Jalan Cempaka Desa 5','11.00 - 22.00','aneka squash, es tape ketan, es teler, nasi goreng ayam, gado-gado, burger, chocolatte, macchiato, dan masih banyak lagi.',3.00,1),
	(2,'Gank Coffee & Bistro','Jalan Pattimura 99','11.00 - tengah malam','coffee, ice blend, mocktail, smoothies, sparkling, salad, soup, aneka western food',5.00,1),
	(3,'Blackstone Urban Lounge','Jalan Jend Sudirman 184','10.00 - tengah malam','espresso, frappuccino, mojito, jus, steak, spaghetti, dan masih banyak lagi.',5.00,1),
	(4,'TKP Coffee House','Jalan Hos Cokroaminoto 30','N/A','espresso, single origin, blend, latte, cumi pelangi, lasagna, onion rings, chicken wings, pancake, churros, dan lain-lain.',3.00,0),
	(5,'Omah Coffee','Dr Lukmono Hadi','12.00 - tengah malam','tea, coffee, mocktail, burger, soda, beef, jus, pizza, burger, dan masih banyak lagi.',7.00,0),
	(6,'Rabbit Gelatto','Jalan Kutilang 31','Selasa - Minggu, 10.00 - 21.00','N/A',5.00,0),
	(7,'Sidji Coffee','Jalan HM Subchan ZE','Selasa - Minggu','N/A',5.00,1),
	(8,'No 8 Coffee','Jalan Menur No 8','08.00 - 23.00','kopi arabika, robusta, kopi susu wolu, kopi tubruk, cappuccino, chocolate, green tea latte, black tea, red velvet latte',5.00,0),
	(9,'Fresto','Jalan Jend Ahmad Yani','Selasa - Minggu, 12.00-14.00, 17.00-20.00','beef, pasta, steak, sandwich, omelet, mocktail, green tea, milkshake, tea, dan lain-lain.',6.00,0),
	(10,'Home Resto & Cafe','Jalan Raya No 95 A','11.00 - 22.00','salad, snack, roti bakar, cake, ice cream, milkshake, mojito, coffee, jus.',3.00,1),
	(11,'Banaran 9 Resto Coffee & Tea','Jalan Sudirman 285','N/A','nasi rawon, nasi ayam kosek, nasi goreng ampela, sop kakap, nasi soto ayam, dan lain-lain.',5.00,0),
	(12,'Chocobean Kudus','Jalan Sunan Kudus 153','09.00 - 23.00','N/A',5.00,0),
	(13,'Cafe de IJA','Jalan Ahmad Yani No 164','07.00 - 18.00','nasi goreng ikan asin, fried bakso, fried egg rolls, spaghetti, chicken wings.',2.00,0),
	(14,'Kopithong Coffee Workshop','Jalan Jend Ahmad Yani No 118-119','17.00 - 23.00','kopi muria, muria tubruk, Vietnam drip, cafe latte, v60 arabica, v60 brewed coffee, vietnamesse coffee.',0.00,0),
	(15,'Eagle Coffee','Jend Sudirman No 1','15.00 - 22.00','N/A',0.00,0),
	(16,'Greens Bakery & Bistro','Jl. Jend. Ahmad Yani No.81, Magersari, Panjunan, Kec. Kota','N/A','N/A',0.00,0),
	(17,'Kritink Coffee & Restaurant','Jl. Nuri No.302, Wergu Kulon, Kec. Kota Kudus','N/A','N/A',0.00,0),
	(18,'Warung Susucow','Jl. Kyai H. Wahid Hasim, Kudus, Demaan','N/A','N/A',0.00,0),
	(19,'Ulam Sari Resto','Jl. Museum Kretek No.10, Getas, Getas Pejaten, Kec. Jati','N/A','N/A',0.00,0),
	(20,'Golden Resto','Jl. Jend. Sudirman No.95, Nganguk, Kec. Kota Kudus','N/A','N/A',0.00,0),
	(21,'Ikki Resto','Jl. Pangeran Puger No.Kav B, Kudus, Demaan, Kec. Kota Kudus','N/A','N/A',0.00,0),
	(22,'Kretek Kopi','Jl. Mulya, Getas, Getas Pejaten, Kec. Jati','N/A','N/A',0.00,0),
	(23,'Nara Japanese Resto','Jl. Jend. Sudirman, Barongan, Kec. Kota Kudus','N/A','N/A',0.00,0),
	(24,'Six Cents Cafe','Jl. AKBP Agil Kusumadya No.86, Jati','N/A','N/A',0.00,0),
	(25,'In.di Coffee & Chocolate','Ruko Perempatan No.9, Jl. Kampus Umk, Kayuapu Kulon, Gondangmanis, Kec. Bae, Kabupaten Kudus','Senin – Sabtu (11.00 – 17.00 WIB) (Minggu Tutup)','es caramel cappuccino, roti bakar cokelat, red velvet cake, tiramissu, es kopi susu.',3.00,0),
	(26,'PDKT Café and Resto','Jl. Krasak Pandean No.1, Area Sawah, Megawon, Kec. Jati','11.00 – 22.00 WIB','N/A',15.00,0),
	(27,'Balena Resto and Cafe','Gang 2 kavling mlati norowito (samping BPBD kota Kudus)','N/A','N/A',0.00,0),
	(28,'Andrawina Food Terrace - AFTER','Jln Raya Kudus - Pati km 5 Ngembalrejo, Kudus','N/A','N/A',0.00,0),
	(29,'susumoeriacafe','Jl. Pemuda 64, Panjunan, Kudus','Open Everyday, 06.00 - 22.00 WIB','N/A',0.00,1);

/*!40000 ALTER TABLE `culinary` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table destinations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `destinations`;

CREATE TABLE `destinations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `destination_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `longlat` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `category` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `popularity` int(11) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `harga_tiket` decimal(10,2) DEFAULT NULL,
  `jumlah_pengunjung` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `destinations` WRITE;
/*!40000 ALTER TABLE `destinations` DISABLE KEYS */;

INSERT INTO `destinations` (`id`, `destination_name`, `description`, `longlat`, `image`, `category`, `popularity`, `rating`, `harga_tiket`, `jumlah_pengunjung`)
VALUES
	(1,'Air Terjun Montel','Air Terjun Montel berlokasi tak jauh dari makam Sunan Muria, dan berada di kawasan Gunung Muria. Menjadi salah satu air terjun di Kudus yang wajib untuk dikunjungi','-6.6607359,110.886609','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fmontel.jpg?alt=media&token=b1e33057-2865-4c2c-b703-a2db419ed628','alam',12,4.2,10000.00,15),
	(2,'Air Terjun Gonggomino','Air terjun/curug merupakan salah satu objek wisata alam yang menjadi pilihan wisatawan untuk melepas penat dari segala aktivitas ataupun sekedar berwisata. Suara air terjun yang dianggap menentramkan dan menyejukkan pikiran menjadi salah satunya.','-6.6504237,110.9029331','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fgonggomino.jpg?alt=media&token=99ef5ae6-d57f-4802-913c-d9c9a87591c5','alam',2,4.2,15000.00,12),
	(3,'Watereboom Mulia Wisata','Waterpark Mulia Wisata menyuguhkan taman rekreasi bermain air yang seru, asyik dan pastinya menarik. Dengan banyak pilihan kolam dan wahana di dalamnya yang bikin momen liburan kali ini semakin berkesan dan sulit terlupakan.','-6.710950703598827, 110.88284355783553','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fwaterboom-mulia.webp?alt=media&token=5e8cc7e0-c35f-41bb-80fe-6414916e59f0','alam',2,4.5,20000.00,22),
	(4,'Museum Kretek','Museum Kretek adalah salah satu museum yang terletak di Kudus, Jawa Tengah (Jateng). Museum Kretek merupakan museum khusus yang memperkenalkan sejarah tentang kretek. Dibangun dan diresmikan pada tanggal 3 Oktober 1986 silam.','-6.825822504027947, 110.83871621147891','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fmuseum-kretek.jpg?alt=media&token=970609ac-71ad-47a4-b021-ef03ebf02706','alam',2,4.5,15000.00,44),
	(5,'Menara Kudus',' Menara Kudus merupakan salah satu masjid tua di Pulau Jawa yang memiliki bangunan dan saksi akulturasi antara kebudayaan Jawa, Hindu, dan Islam. Masjid ini berlokasi di Jalan Menara, Desa Kauman, Kecamatan Kota, Kabupaten Kudus, Jawa Tengah, sekitar 1,5 km dari pusat Kota Kudus.','-6.804019947119528, 110.83282569302318','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fmenara.jpg?alt=media&token=4b33d628-dbde-4122-bad1-ee7455aa5aca','alam',2,5.5,30000.00,55),
	(6,'Desa Wisata Rahtawu','Dengan ketinggian ± 1.627 m dari permukaan air laut, di desa tersebut kamu dapat menikmati panorama alam pegunungan yang asri dan indah memesona dengan udara yang bersih, segar dan sejuk. Tidak hanya itu, saja kamu juga bisa dengan leluasa menikmati potensi wisata alam dari atas pegunungan Muria. Mulai dari wisata alam hingga mampir makan-makanan khas Rahtawu aneka kuliner Enthog.','-6.6806631411764945, 110.85438160207828','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fdesa-rahtawu.png?alt=media&token=9abf4c53-f0c0-4770-9a86-169fc1aad032','alam',2,4.5,13000.00,12),
	(7,'Air Tiga Rasa Rajenu','Air Tiga Rasa Rejenu terdapat di Desa Japan, Kecamatan Dawe, Kabupaten Kudus, tepatnya di atas Air Terjun Monthel. Lokasinya terletak di sebelah utara makam Sunan Muria, di atas objek air terjun Montel. Di sini terdapat sebuah makam yang banyak diziarahi orang. Orang mengenalnya sebagai makam Syeh Sadzali. Salah satu murid Sunan Muria yang disegani, yang konon berasal dari Irak','-6.650875304065295, 110.90264929276749','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Frajenu.jpg?alt=media&token=7ede61f4-c5c6-4f7e-8539-7305bb5f494b','alam',2,5,20000.00,51),
	(8,'Gray Canyon Kudus','Awalnya Gray Canyon merupakan lokasi galian C yaitu usaha penambangan. Seperti halnya yang berupa pertambangan tanah, pasir, kerikil, marmer, kaolin, granit, dan masih banyak yang lain lagi. Meski tidak memiliki wahana wisata layaknya tempat wisata pada umumnya','-6.766631327617091, 110.91761502160568','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fcanyon.jpg?alt=media&token=82c42ca1-4a13-4003-a9c1-cc9c4c41d3ef','alam',2,4.5,10000.00,40),
	(9,'Perkemahan Kajar','Bumi Perkemahan Kajar Terletak di Desa Kajar, Kecamatan Dawe Kabupaten Kudus sekitar 2 km arah selatan Makam Sunan Muria. kawasan wisata dan bumi perkemahan Kajar mempunyai ketinggian sekitar 600 meter dpl (di atas permukaan laut).','-6.678103651178264, 110.89170122712981','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fperkemahan-kajar.jpg?alt=media&token=1ca2bded-8d65-4fcb-bec8-66f050ce5396','alam',12,4,10000.00,40),
	(10,'Taman Oasis','Salah satu kawasan wisata publik dan perkantoran terpadu di Kabupaten Kudus. Memiliki lahan seluas kurang lebih 85 hektare. Berlokasi di Jalan Lingkar Utara, Desa Bacin, Kecamatan Bae. Mulai dibangun pada 2005 dan selesai pada 2012. Dimiliki dan dikelola oleh PT Djarum Kudus.','-6.783431553087101, 110.85927148073768','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Foasis.jpg?alt=media&token=40f38ab4-972f-473c-a4af-4459fd0a7731','nongki',2,5,10000.00,40),
	(11,'Situs Pati Ayam','Museum Situs Patiayam merupakan museum khusus yang menampung temuan dari daerah situs Patiayam. Museum ini menginformasikan mengenai kehidupan manusia beserta lingkungannya pada masa Plestosen. Museum ini mulai didirikan pada tahun 2004. Museum Situs Patiayam memiliki koleksi berjumlah 99 yang ditampilkan pada display. ','-6.793398327286098, 110.93832533891398','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fpati-ayam.jpg?alt=media&token=dd54593c-4a5a-4a91-8294-8465862d0036','alam',2,4,10000.00,21),
	(12,'Taman Sardi','Wisata Menara Pisang di Dawe Kudus Jawa Tengah adalah salah satu tempat wisata yang berada di dukuh Watu Lumpang, Desa Kajar, Kecamatan Dawe, Kabupaten Kudus, Jawa Tengah, Indonesia. Wisata Menara Pisang di Dawe Kudus Jawa Tengah adalah tempat wisata yang ramai dengan wisatawan pada hari biasa maupun hari liburan. Tempat ini sangat indah dan bisa memberikan sensasi yang berbeda dengan aktivitas kita sehari hari.','-6.703521494519176, 110.8861182112499','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fmenara-pisang.jpg?alt=media&token=94f28fab-5589-4555-b3c7-1f25d0f4b7ae','alam',2,4,10000.00,64),
	(13,'Air Terjun Pengantin','Air Terjun Pengantin sudah terkenal sejak judul film layar lebar yang dibintangi artis cantik Tamara Bleszynski pada tahun 2009 lalu meskipun lokasi syutingnya bukan di Air Terjun Kudus','-6.697233492068962, 110.87725653695023','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fair-terjun-pengantin.jpeg?alt=media&token=c236106d-b687-41c8-8b1f-54b07cb8305b','alam',2,4,15000.00,45),
	(14,'Air Terjun Banteng Rahtawu','Sejak tahun 2018 Air Terjun Banteng dikelola dengan baik antara pemerintah desa setempat dengan beberapa pihak terkait. Sehingga kini dapat menjadi referensi tempat wisata ketika berada di Kudus, khususnya di Desa Rahtawu.','-6.6440550823101825, 110.86795692345872','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fair-terjun-banteng.JPG?alt=media&token=898a5964-b73e-4152-bf24-18c4c5d12681','alam',2,4,12000.00,33),
	(15,'Gua Jepang Colo','Gua Jepang terletak di lereng Gunung Muria, tempatnya tidak jauh dari objek wisata di dekat Desa Colo yaitu air tiga rasa, dan hanya bisa dilalui dengan berjalan kaki.','-6.766996882995542, 110.94083345427','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fgua-jepang.jpeg?alt=media&token=402a8680-f7e7-4489-aa04-30c34c25290f','alam',2,4,10000.00,22),
	(16,'The Peak Waterboom','Kudus Kota Kretek tidak hanya menyajikan wisata sejarah yang menawan hati. Namun, siapa sangka, kota ini pun menyediakan destinasi rekreasi air yang memikat. Salah satunya di The Peak View Waterboom & Resto. Destinasi yang tak hanya menyuguhi wisata alam Kudus, tapi juga arena bermain air.','-6.780127217804236, 110.8704899369516','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fthe-peak.jpg?alt=media&token=d9165e38-44c5-47fa-bba0-3aa49f67888a','renang',2,4,10000.00,23),
	(17,'Puncak 29','Puncak 29 atau Songolikur merupakan satu puncak dari Gunung Muria berada pada ketinggian lebih dari 1.600 mdpl. Berbicara akan keindahan alamnya tentu sudah tidak kita ragukan lagi karena view yang ijo menghiasi kabut tipis menjadi pemandangan utamanya.','-6.616293322148556, 110.88934099588981','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fpuncak29.jpg?alt=media&token=5643b1d5-b659-4bc5-9419-53a023be9003','alam',2,5,10000.00,40),
	(18,'Air Terjun Ternadi','Air Terjun Ternadi memiliki ketinggian sekitar 30 m dengan kolam penampungan di bawahnya.  Air terjun ini berdekatan dengan (di atas) Makam Sunan Kaliyetno dan objek wisata Watu Payung','-6.672709584324997, 110.88307030928576','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fair-terjun-ternadi.jpg?alt=media&token=a7936861-a8fa-4c96-9ef9-05da137499cc','alam',2,4,20000.00,64),
	(19,'Air Terjun Kedung Gender','Di Desa Dukuhwaringin Kecamatan Dawe, Kudus ternyata menyimpan pesona wisata alam yang mempesona. Namanya adalah air terjun Kedung Gender.','-6.6736657149297685, 110.90917198853595','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fair-terjun-kedung-gender.jpg?alt=media&token=d033ab74-e609-461e-8e72-fdec1f2d6f73','alam',33,5,10000.00,40),
	(20,'Gunung Muria Kudus','Di Desa Dukuhwaringin Kecamatan Dawe, Kudus ternyata menyimpan pesona wisata alam yang mempesona. Namanya adalah air terjun Kedung Gender.','-6.615557657257895, 110.89126210412712','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fgunung-muria.jpg?alt=media&token=5e740e64-b2e8-4b5c-ae8f-c37cb9fe376e','alam',2,4,14000.00,32),
	(21,'Sendang Jodo','Di Dukuh Jambean, Desa Purworejo, Kecamatan Bae, Kabupaten Kudus terdapat sumber mata air bernama Sendang Jodo. Konon, air sendang berukuran empat meter persegi tersebut dipercaya masyarakat sekitar mempunyai banyak khasiat, di antaranya untuk memperlancar jodoh.','-6.778993301201402, 110.8554504483068','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fsendang-jodo.jpg?alt=media&token=b9b01fe4-2a4d-4096-8188-4a67bde0100f','alam',2,4,12000.00,43),
	(22,'Desa Wisata Wonosoco','Desa Wisata Wonosoco memiliki destinasi wisata alam yang  terdiri dari wisata goa, sendang, dan wisata budaya, yakni petilasan. Kegiatan budaya disuguhkan oleh masyarakat Wonosoco secara rutin tiap tahun adalah KIRAB RESIK-RESIK SENDANG','-6.972688629067119, 110.81063729110711','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fwonosoco.jpg?alt=media&token=5f96859b-66db-40d5-9110-d970dc99b664','alam',2,4,12000.00,41),
	(23,'Desa Wisata Jurang Gebog','Jurang merupakan sebuah desa yang berada di Kecamatan Gebog, Kabupaten Kudus, Jawa Tengah. Desa Jurang sendiri berada pada kawasan lereng gunung muria dan secara geografis sendiri dilintasi oleh sungai gelis, sungai yang membelah Kota Kudus','-6.722486336363031, 110.8549299027247','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fjurang-gebog.jpg?alt=media&token=adfdfba3-41f0-4a31-a706-f8f967727161','alam',2,5,12000.00,40),
	(24,'Gerbang Kudus Kota Kretek','adalah sebuah monumen berupa gerbang masuk kota yang berada di kawasan Taman Tanggul Angin, Kecamatan Jati, Kabupaten Kudus. Monumen ini melambangkan kota asal dari rokok kretek yaitu Kudus. Gerbang Kudus Kota Kretek ini diklaim termegah di Indonesia','-6.842406571730585, 110.81542318989017','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fgerbang-kudus.JPG?alt=media&token=b5acaa6c-f1f7-48d2-bab6-e578b61a0d95','nongki',3,5,10000.00,22),
	(29,'Puri Kajar Resto And Outbond','Tempat Makan Santai dan Rekreasi Keluarga di kaki gunung Muria Kudus. juga menyewakan tempat untuk  Rapat, Ultah, Reuni, Pernikahan,dll. Dan juga ada Arena OUTBOND','-6.670773313082844, 110.89106283162359','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fpurireste.webp?alt=media&token=acff21ed-b4ac-4de5-8e43-0f3f0dd0db2f','alam, kuliner',0,0,25000.00,0),
	(31,'Taman Krida Wisata','Taman Krida Wisata atau yang sering disebut Kudus Playground, adalah destinasi wisata keluarga yang menyajikan beragam keseruan dan kegembiraan bagi pengunjungnya, Terletak di Kabupaten Kudus, Jawa Tengah, tempat ini menawarkan kombinasi unik antara rekreasi, edukasi, dan hiburan yang cocok untuk semua kalangan.','-6.765607495038917, 110.84632618201829','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Ftaman-krida.jpg?alt=media&token=de90096f-115e-4cbe-bccd-4d39028b1d66','keluarga',0,0,0.00,0),
	(32,'Taman Ria Colo','Letaknya tepat di depan hotel Graha Muria Colo Dawe Kudus. Hanya dipisah oleh jalan menanjak beraspal yang biasa dilalui para tukang ojek menuju makam Sunan Muria. Disitulah berdiri cukup megah Gapuro bertuliskan Taman Ria Colo. Masuki areal Gapura Taman Ria, terdapat pintu masuk yang dilengkapi bangunan loket. Untuk memasuki Taman Ria, pengunjung dikenakan retribusi Rp. 2500,- per-orang pada hari biasa. Sedangkan untuk hari libur dikenakan Rp. 3500,-. Taman Ria Colo dimasukkan dalam kategori pariwisata unggulan yang ada di Kudus. Lokasi yang cocok untuk keluarga sambil menikmati hamparan pemandangan pegunungan Muria. Dilengkapi tempat duduk dan sejumlah mainan anak.','-6.667714167975015, 110.90415438056543','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Ftaman-ria.jpg?alt=media&token=25ce5930-1a38-4c35-a234-63a6e1014ab4','keluarga',0,0,0.00,0),
	(41,'Waterboom Museum Kretek','Deskripsi Waterboom Museum Kretek','-6.791159087648199, 110.78605372612114','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fkretekwaterboom.jpeg?alt=media&token=27bbb6e8-c090-44ad-8396-0a2e473bc1e2','hiburan',0,0,0.00,0),
	(42,'Bumi Perkemahan Abiyasa','Bumi Perkemahan di Kabupaten Kudus, Jawa Tengah yang pertama adalah Buper Abiyoso. Buper ini diberikan nama sesuai dengan nama bukit yang terletak di atasnya. Berlokasi di Desa Menawan Kecamatan Gebog Kabupaten Kudus, di lereng gunung (bukit) Abiyoso, salah satu bukit yang terdapat di Gunung Muria. Bumi Perkemahan Abiyoso pernah digunakan sebagai lokasi penyelenggaraan Jambore Daerah (Jamda) Kwarda Jawa Tengah IX Tahun 1996. Untuk menuju buper ini tidak terlalu sulit, dengan menggunakan angkutan umum cukup dengan menaiki angkutan kota jurusan Gebog dari Terminal Kudus.','-6.703486062143022, 110.84503275570907','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fperkemahan-abiyasa.jpg?alt=media&token=e50ff829-5f56-4edb-b47d-6c8d6947779a','alam',0,0,0.00,0),
	(43,'Puseran Desa Colo','Deskripsi DTW Puseran Desa Colo','-6.66785271177437, 110.89696064008521','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fpuserancolo.jpg?alt=media&token=33056fd1-9544-479f-8b9a-a809d4ae4051','alam',0,0,0.00,0),
	(44,'Bumi Perkemahan Ronggokusumo','Deskripsi Bumi Perkemahan Ronggokusumo','-6.7814329177333015, 110.92452478056636','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fkemah-ronggokusumo.jpeg?alt=media&token=b7f3be82-cd82-484c-b2f5-e33171c78971','alam',0,0,0.00,0),
	(45,'Perkemahan Puteran','Bukit ini terletak di Dusun Pandak, Colo, kabupaten Kudus. Namun bagi pendaki, bukit ini tidak direkomendasikan karena bisa di tempuh dengan kendaraan roda dua dan bersebrangan dengan perkampungan penduduk. Lokasinya bisa ditempuh 30 menit dari pusat kota.','-6.661074944252097, 110.89900995217185','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fkemah-puteran.jpg?alt=media&token=4c7f0211-18ee-4583-bbaf-1851a0fcb716','alam',0,0,0.00,0),
	(46,'Museum Jenang','Museum Jenang Kudus adalah sebuah museum yang terletak di Kota Kudus, Jawa Tengah, Indonesia. Museum ini didirikan oleh perusahaan jenang terkenal, Mubarok Food, sebagai bentuk penghormatan terhadap warisan budaya lokal dan sejarah jenang, makanan khas yang identik dengan Kudus.','-6.802353202900255, 110.84374561551152','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fmuseum-jenang.jpg?alt=media&token=7bc4fe79-49c8-4db3-80a0-46fd6bbdefd1','sejarah',0,0,0.00,0),
	(48,'The Hills Vaganza','The Hills Vaganza Kudus adalah sebuah restoran dan tempat wisata yang terletak di kawasan perbukitan di Kudus, Jawa Tengah. Tempat ini menawarkan pengalaman bersantap dengan pemandangan alam yang memukau, memadukan keindahan panorama perbukitan dengan suasana yang nyaman dan modern.','-6.706343307670036, 110.88553549771801','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fvaganza.jpg?alt=media&token=17cf344a-3fed-432a-9091-4471afbed26f','kuliner',0,0,0.00,0),
	(58,'Edu Wisata Kopi Jetak kedungdowo','Pengunjung dapat mencicipi kopi hasil olahan lokal, belajar tentang proses pembuatan kopi mulai dari panen hingga penyeduhan, serta menikmati berbagai sajian kuliner tradisional. Dengan konsep yang alami dan nuansa khas pedesaan, Wisata Kopi Jetak menjadi tempat yang menarik bagi pecinta kopi dan wisatawan yang ingin mengeksplorasi budaya serta keindahan alam Kudus.','-6.7913652520147245, 110.7837476862009','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fwisata-kopi-jetak.jpg?alt=media&token=6e531027-a866-4611-aba6-88d2eea0d6b0','budaya, kuliner',0,0,0.00,0),
	(62,'Batik Muria Karangmalang','Batik Muria Karangmalang adalah sentra kerajinan batik yang terletak di Desa Karangmalang, Kabupaten Kudus, Jawa Tengah. Batik ini terkenal karena mengangkat motif-motif khas lokal yang terinspirasi dari keindahan alam Pegunungan Muria, flora dan fauna, serta kekayaan budaya Kudus.','-6.772058579661568, 110.8358902001794','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fbatik-muria.jpg?alt=media&token=5b52de52-9b81-4cf0-a0a0-eb2ebfbb85fb','budaya',0,0,0.00,0),
	(64,'Agro Wisata Padurenan','Agro Wisata Padurenan di Kudus adalah destinasi wisata yang menawarkan pengalaman alam pedesaan dengan fokus pada aktivitas pertanian dan edukasi. Terletak di Desa Padurenan, tempat ini dikelilingi oleh area hijau subur yang menampilkan berbagai tanaman hortikultura dan pertanian khas lokal.','-6.760738243512672, 110.92684619214982','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fagro-padurenan.jpeg?alt=media&token=dab73881-eefb-41fd-b2d8-9ed87cf431be','alam',0,0,0.00,0),
	(65,'Edu Wisata Susu Sumber Segar Garung Lor','Wisata Susu Sumber Segar di Garung Lor, Kudus, adalah destinasi wisata edukasi yang berfokus pada peternakan sapi perah dan pengolahan susu segar. Tempat ini menawarkan pengalaman unik bagi pengunjung untuk belajar tentang proses peternakan sapi, mulai dari perawatan, pemerahan susu, hingga pengolahan menjadi berbagai produk olahan susu seperti yogurt, keju, dan es krim.','-6.796200799032531, 110.81042421033565','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fsusu-sumber-segar.jpg?alt=media&token=5dc8523d-b5e6-4cfa-9ec0-ae30b7d08e57','edukasi',0,0,0.00,0),
	(68,'Bukit Puser Angin','Bukit Puser Angin adalah destinasi wisata alam yang terletak di kawasan Pegunungan Muria, Kudus, Jawa Tengah. Tempat ini menawarkan pemandangan alam yang indah dengan hamparan perbukitan hijau, udara segar, dan suasana yang tenang, cocok untuk melepas penat dari hiruk-pikuk perkotaan.','-6.757826924502812, 110.92874720275051','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fbukitpuser.jpg?alt=media&token=561c988f-d009-490f-9ec7-304287333cbc','alam',0,0,0.00,0),
	(72,'Cengkir Manis','Selain suasana di pedesaan, di Wisata Cengkir Manis, wisatawan juga bisa menikmati susur sungai. Di sana, disediakan sejumlah perahu yang bisa dinikmati pengunjung saat akhir pekan. Saat ini tidak ditarif biaya yang dikenakan, pengunjung hanya bayar seikhlasnya pada kotak yang disediakan di pintu masuk.','-6.726305217458667, 111.12926063048157','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fcengkir-manis.jpg?alt=media&token=bd22e2cd-faab-4374-9291-675ddf1475df','hiburan',0,0,0.00,0),
	(73,'Wanawisata Ternadi','Wanawisata Ternadi adalah destinasi wisata alam yang terletak di Desa Ternadi, Kabupaten Kudus, Jawa Tengah. Tempat ini menawarkan keindahan alam berupa hutan pinus yang asri dan sejuk, serta panorama alam pegunungan yang memukau. Wanawisata Ternadi cocok bagi pengunjung yang ingin menikmati suasana alam yang tenang, berkemah, atau sekadar bersantai di tengah pepohonan pinus.','-6.6623157592649, 110.88961944057691','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fcengkir-manis.jpg?alt=media&token=bd22e2cd-faab-4374-9291-675ddf1475df','alam',0,0,0.00,0),
	(74,'Seribu Batu Semliro','Seribu Batu Semliro adalah sebuah destinasi wisata alam yang terletak di daerah Kecamatan Dawe, Kudus, Jawa Tengah. Tempat ini terkenal dengan pemandangan alam yang spektakuler, terutama formasi batu-batu besar yang tersebar di area pegunungan. Nama \"Seribu Batu\" merujuk pada banyaknya batuan besar yang membentuk lanskap yang unik dan menarik.','-6.63731736699934, 110.88137786467378','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fsribu-batu.jpg?alt=media&token=726b4a26-f592-4948-9a5f-312c0831e279','alam',0,0,25000.00,0),
	(75,'Omah Dongkas','Omah Dongkas adalah sebuah tempat wisata yang terletak di Kudus, Jawa Tengah, yang menawarkan konsep wisata alam dan edukasi. Omah Dongkas dikenal dengan suasana yang sejuk dan asri, dikelilingi oleh hamparan alam yang indah, cocok untuk relaksasi dan kegiatan keluarga.','-6.639798760654826, 110.87496034482577','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fomah-dongkas.jpg?alt=media&token=93239a60-69a8-4b7c-bdd4-4788bb1e322b','alam',0,0,0.00,0),
	(79,'Air Terjun Padas Awu','Padas Awu adalah sebuah destinasi wisata alam yang terletak di Kabupaten Kudus, Jawa Tengah, yang terkenal dengan pemandangan alam pegunungan dan suasana yang asri. Lokasi ini berada di sekitar lereng Gunung Muria, dengan keindahan alam yang memukau, termasuk hutan pinus dan spot-spot foto menarik.','-6.654647434488053, 110.8888651963982','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fpadasawu.webp?alt=media&token=599f510d-c857-4517-bd99-ba5ce9146bf2','alam',0,0,0.00,0),
	(80,'Edu Wisata Ulam Sari Getas Pejaten','Wisata Ulam Sari Getas Pejaten adalah sebuah destinasi wisata alam yang terletak di Desa Getas Pejaten, Kabupaten Kudus, Jawa Tengah. Tempat ini menawarkan pengalaman wisata yang memadukan keindahan alam dengan berbagai aktivitas rekreasi yang menyenangkan, seperti area bermain, kolam ikan, dan spot foto menarik.','-6.826298011169319, 110.83730272338505','https://firebasestorage.googleapis.com/v0/b/aerojs.appspot.com/o/destination%2Fruang-makan-ulam-sari.jpg?alt=media&token=5dbea44e-d8f0-4a91-8d8d-4e6b0dc174f6','kuliner',0,0,0.00,0);

/*!40000 ALTER TABLE `destinations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table event
# ------------------------------------------------------------

DROP TABLE IF EXISTS `event`;

CREATE TABLE `event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) NOT NULL,
  `event_date` date DEFAULT NULL,
  `event_description` text,
  `destination_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`event_id`),
  KEY `destination_id` (`destination_id`),
  CONSTRAINT `event_ibfk_1` FOREIGN KEY (`destination_id`) REFERENCES `destinations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;

INSERT INTO `event` (`event_id`, `event_name`, `event_date`, `event_description`, `destination_id`)
VALUES
	(12,'event 1','2024-10-20','test again',2);

/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table registration
# ------------------------------------------------------------

DROP TABLE IF EXISTS `registration`;

CREATE TABLE `registration` (
  `registration_id` int(11) NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `registration_status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`registration_id`),
  KEY `event_id` (`event_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `registration_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  CONSTRAINT `registration_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;

INSERT INTO `role` (`role_id`, `role_name`)
VALUES
	(1,'admin'),
	(2,'eo'),
	(3,'pub');

/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table travel_agent
# ------------------------------------------------------------

DROP TABLE IF EXISTS `travel_agent`;

CREATE TABLE `travel_agent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `agent_name` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `travel_agent` WRITE;
/*!40000 ALTER TABLE `travel_agent` DISABLE KEYS */;

INSERT INTO `travel_agent` (`id`, `agent_name`, `owner`, `address`, `phone`)
VALUES
	(1,'Ranggawarsita Tour','','Jl. Arteri Soekarno Hatta No.10 (Perkantoran WPC Mas) Kudus, Jl Murti Lestari Raya No.20','08222-515-0321, 0813'),
	(2,'Happy Prima Wisata','','Jl. Mayor Basuno No.30, Sunggingan, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59317','(0291) 431229'),
	(3,'Vera Tour','Sri Muryanto','Jl. Bhakti No.83, Burikan, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59311','(0291) 3337143'),
	(4,'Namira Tour','Erzad Qomar','Muneng, Gribig, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59333','0896-3936-9031'),
	(5,'Nice Travelling','Teguh Pramudyo','Jl. Sosrokartono No.58, Kudus, Kaliputu, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59312','0858-0222-2766'),
	(6,'Andini Trans','','Tegal Arum, RT. 05/03, Sunggingan, Kota Kudus, Sunggingan, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59317','0856-4313-5343'),
	(7,'MG Trans','','Jalan DR. Wahidin Sudiro Husodo, Demangan, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59317','0877-3374-9188'),
	(8,'Wildhas Trans','','Jl. Adi Negoro No.20, Sunggingan, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59317','0823-3443-6542'),
	(9,'Abhipraya Wisata','Arus Harhara','Ruko Ganesha No. 16, Jalan Ganesha 1, Purwosari, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59316','0821-3697-9665'),
	(10,'Arwaniyyah Tour & Travel','','Jl. Sunan Kudus No.237A, Purwosari, Janggalan, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59312','(0291) 4250125'),
	(11,'Dhayu Tour & Travel','','Getas, Getas Pejaten, Kec. Jati, Kabupaten Kudus, Jawa Tengah 59343',''),
	(12,'Nusa Indah Tour & Travel','','Jl. Mayjen Sutoyo No.Km. 1, RT.04/RW.04, Blolo, Karangampel, Kec. Kaliwungu, Kabupaten Kudus, Jawa Tengah 59361','0821-4602-7237'),
	(13,'Rikola Tours & Travel','','Jl. Jend. Ahmad Yani No.128, Getas, Getas Pejaten, Kec. Jati, Kabupaten Kudus, Jawa Tengah 59343','(0291) 435055'),
	(14,'Safari Tour','Ali Azhar','Jalan Kadilangu No No.666, Mijen, Prambatan Kidul, Kec. Kaliwungu, Kabupaten Kudus, Jawa Tengah 59332','0816-4880-860'),
	(15,'Rahayu Tour & Travel','','Jl. Hos Cokroaminoto No.82A, Mlati Norowito, Mlati Lor, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59319','(0291) 430558'),
	(16,'Excellent Tour','','Jl. Pramuka No.6, Mlati Kidul, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59319','0815-6523-066'),
	(17,'Rodex Tours & Travel','','Jl. Ronggolawe, Getas, Getas Pejaten, Kec. Jati, Kabupaten Kudus, Jawa Tengah 59343','(0291) 4250044'),
	(18,'Kayla Tour & Travel','','Jl. Bhakti No.23, Burikan, Kec. Kota Kudus, Kabupaten Kudus, Jawa Tengah 59313','(0291) 2911473'),
	(19,'TRIAS TOUR & TRAVEL','','Ruko Jember Permai Kudus Rt.Rw.Kel./Desa Sunggingan Kec. Kota Kudus, Kab. Kudus',''),
	(20,'MARA TOUR','','Jl.Yos Sudarso Ii No.451 Rt.Rw.Kel./Desa Burikan, Kec. Kota Kudus, Kab. Kudus',''),
	(21,'RAHAYU REFLEKSI/TOUR & TRAVEL','','Mlatinorowito Gg.8 No.82 Rt.Rw.Kel./Desa Rendeng, Kec. Kota Kudus, Kab. Kudus',''),
	(22,'KOWINDO TOUR','Siswanto','Jalan Seruag 1. usi lingkar barat kaliwungu kudus','0813-2518-0799, 0819'),
	(23,'Liga Sartika','Sri Hartini','Jalan Raya Kudus Pati Km 6 Ruko Tenggeles Kudus','0291-4252024, 0813-2'),
	(24,'Global Tour','Mukles','Jalan Sitapang Raya Grubak Klumpit RT 03/III Kudus','0852-2585-129'),
	(25,'Mahardika Wisata','M. Suhardi','Prambatan Kidul No. 666 Selatan Man 2 Kudus','0815-6517-805'),
	(26,'Mahkota Wisata','Lutfi','Jalan Wijaya Kusuma RT 1 RW 1 Kadisono Kudus','0852-0037-2573'),
	(27,'Alvaro Travel','','JL Museum Kretek Getas Jati','08112784325, 0811278'),
	(28,'Persada Travel','','Jl. Dr. Lukmonohadi, Magersari, Panjunan','0291 437 149'),
	(29,'Rama Sakti','','Jl. Jl. A Yani No.110','(0291) 432153'),
	(30,'Nadhif Tour & Travel','','Jl. Museum Kretek Nomor 08, Getas Jati, Kudus, Jawa Tengah','0812 7903 0303, 0812');

/*!40000 ALTER TABLE `travel_agent` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role_id` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_role` (`role_id`),
  CONSTRAINT `FK_users_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `email`, `username`, `name`, `password`, `token`, `role_id`)
VALUES
	(3,'aditdevelop@gmail.com','Aditya Argadinata','','123456','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMsInVzZXJuYW1lIjoiQWRpdHlhIEFyZ2FkaW5hdGEiLCJpYXQiOjE3MzMzMDY4MzMsImV4cCI6MTczMzMxMDQzM30.AjoBQeo6qLCsub1dUbX0kPaYr8tJZfhJ3alGuY88kz0',3),
	(96,'adit@fisip.net','jarwo22','','33333',NULL,2),
	(97,'zul@gmail.com','zul','','123456',NULL,2),
	(98,'aditfarming@gmail.com','adit pubuser','','123456','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjk4LCJ1c2VybmFtZSI6ImFkaXQgcHVidXNlciIsImlhdCI6MTczMTcwMDA0NiwiZXhwIjoxNzMxNzAzNjQ2fQ.ISVS3TDu6upQXqzSlq2oivMo5H953lPkdt5R3y5JPOY',3);

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

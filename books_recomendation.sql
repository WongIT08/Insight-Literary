-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 30 Jul 2025 pada 08.51
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `books_recomendation`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `admins`
--

CREATE TABLE `admins` (
  `id_admin` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `admins`
--

INSERT INTO `admins` (`id_admin`, `username`, `password`, `fullname`, `created_at`, `updated_at`) VALUES
(1, 'admin76', 'admin4545', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `books`
--

CREATE TABLE `books` (
  `id_buku` int(11) NOT NULL,
  `judul` text NOT NULL,
  `id_penulis` int(10) NOT NULL,
  `deskripsi` text NOT NULL,
  `genre` enum('Fiksi','Non-Fiksi','Fantasi','Sains','Pendidikan','Sejarah','Biografi','Sci-Fi','Teka-Teki','Misteri','Filsafat','Religi') NOT NULL,
  `tipe` enum('Premium','BIasa') NOT NULL,
  `rating` float NOT NULL,
  `views` int(10) NOT NULL,
  `image` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tags` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `books`
--

INSERT INTO `books` (`id_buku`, `judul`, `id_penulis`, `deskripsi`, `genre`, `tipe`, `rating`, `views`, `image`, `created_at`, `tags`) VALUES
(0, 'Keajaiban Toko Kelontong Namiya', 4, 'Novel \"Keajaiban Toko Kelontong Namiya\" karya Keigo Higashino menceritakan tentang tiga pemuda berandal yang bersembunyi di sebuah toko kelontong tua setelah melakukan pencurian. Di sana, mereka menemukan kotak surat yang berisi surat-surat dari orang-orang yang meminta nasihat. Tanpa sengaja, mereka terhubung dengan masa lalu dan mulai memberikan balasan atas surat-surat tersebut, membantu orang-orang yang membutuhkan dengan nasihat yang mereka berikan. ', 'Misteri', 'Premium', 4.4, 25, 'keajaiban_toko_kelontong_namiya.jfif', '2025-07-27 10:07:10', NULL),
(1, 'Teka - Teki Rumah Aneh', 1, 'Novel \"Teka-Teki Rumah Aneh\" karya Uketsu menceritakan kisah seorang penulis lepas yang berspesialisasi dalam hal-hal gaib dan misteri. Dia diminta untuk menganalisis denah rumah aneh yang akan dibeli oleh seorang kenalan bernama Yanaoka. Bersama seorang arsitek yang juga tertarik pada hal-hal misterius, mereka menemukan kejanggalan dalam tata letak rumah tersebut dan mulai mengungkap misteri yang lebih dalam. ', 'Teka-Teki', 'BIasa', 3.5, 5, 'teka_teki_rumah_aneh.jfif', '2025-07-27 11:26:46', NULL),
(2, 'Laskar Pelangi', 2, 'Novel \"Laskar Pelangi\" karya Andrea Hirata menceritakan kisah persahabatan dan semangat juang anak-anak di sebuah desa miskin di Pulau Belitung. Mereka, yang disebut Laskar Pelangi, berjuang untuk mendapatkan pendidikan dan meraih mimpi di tengah keterbatasan ekonomi dan sosial. ', 'Pendidikan', 'Premium', 4, 7, 'laskar_pelangii.jfif', '2025-07-27 11:29:29', NULL),
(3, 'Seporsi Mie Ayam Sebelum Mati', 3, '\"Seporsi Mie Ayam Sebelum Mati\" adalah novel karya Brian Khrisna yang menceritakan kisah seorang pria bernama Ale yang berjuang dengan depresi dan merencanakan bunuh diri. Namun, sebelum ia mengakhiri hidupnya, ia memutuskan untuk menikmati mie ayam sebagai \"makanan terakhir\". Novel ini menyelidiki perjuangan Ale dengan kesehatan mental dan bagaimana hal kecil seperti mie ayam bisa menjadi titik balik dalam hidupnya. ', 'Fiksi', 'BIasa', 4.2, 9, 'seporsi_mie_ayam_sebelum_mati.jfif', '2025-07-27 10:07:10', NULL),
(4, 'The Devotion of Suspect X', 4, '\"Kesetiaan Mr. X\" atau \"The Devotion of Suspect X\" adalah novel karya Keigo Higashino yang menceritakan tentang seorang pria bernama Tetsuya Ishigami yang berdedikasi untuk melindungi Yasuko Hanaoka, tetangganya, setelah ia membunuh mantan suaminya. Ishigami, seorang guru matematika jenius, menggunakan kecerdasannya untuk menciptakan alibi yang sempurna bagi Yasuko dan mengalihkan kecurigaan polisi. ', 'Misteri', 'Premium', 4.2, 10, 'the_devotion_of_suspect_x.jfif', '2025-07-27 10:07:10', NULL),
(5, 'The Courage to be Disliked', 5, '\"The Courage to be Disliked\" adalah buku laris yang ditulis oleh Ichiro Kishimi dan Fumitake Koga, yang menjelaskan teori psikologi Alfred Adler tentang bagaimana kita dapat mencapai kebahagiaan sejati. Buku ini disajikan dalam bentuk dialog antara seorang filsuf dan seorang pemuda, yang membahas cara membebaskan diri dari ekspektasi sosial dan menemukan kebahagiaan berdasarkan penerimaan diri dan kontribusi sosial. ', 'Filsafat', 'Premium', 4.4, 15, 'the_courage_to_be_disliked.jfif', '2025-07-27 10:07:10', NULL),
(6, 'Bumi Manusia', 8, 'Buku ini bercerita tentang perjalanan seorang tokoh bernama Minke. Minke adalah salah satu anak pribumi yang sekolah di HBS. Pada masa itu, yang dapat masuk ke sekolah HBS adalah orang-orang keturunan Eropa. Minke adalah seorang pribumi yang pandai, ia sangat pandai menulis. Tulisannya bisa membuat orang sampai terkagum-kagum dan dimuat di berbagai Koran Belanda pada saat itu. Hanya saja sebagai seorang pribumi, ia kurang disukai oleh siswa-siswi Eropa lainnya. Minke digambarkan sebagai seorang revolusioner di buku ini. Ia berani melawan ketidakadilan yang terjadi pada bangsanya. Ia juga berani memberontak terhadap kebudayaan Jawa, yang membuatnya selalu di bawah. Melalui buku ini, Pram menggambarkan bagaimana keadaan pemerintahan kolonialisme Belanda pada saat itu secara hidup.', 'Sejarah', 'Premium', 4.9, 15, 'bumi_manusia.jfif', '2025-07-27 10:07:10', NULL),
(7, 'Hujan', 6, 'Novel Hujan berlatar tahun 2042 hingga 2050, menceritakan tentang kisah hidup seorang gadis bernama Lail dan teman prianya bernama Esok. Suatu hari, Lail dan Esok bertemu karena terjadi banyak bencana alam di daerah mereka. Sehingga mereka harus tinggal di tempat pengungsian sealam lebih dari satu tahun. Setelah mengalami berbagai kejadian yang membuat mereka saling mengandalkan satu sama lain, mereka terpaksa harus berpisah karena tempat pengungsian tersebut ditutup oleh pemerintah.', 'Fiksi', 'BIasa', 4.4, 7, 'hujan.jfif', '2025-07-27 09:56:26', NULL),
(8, 'Negeri Para Bedebah', 6, '\"Negeri Para Bedebah\" adalah novel karya Tere Liye yang menceritakan kisah seorang konsultan keuangan bernama Thomas yang terjebak dalam intrik politik dan perebutan kekuasaan di dunia perbankan. Novel ini menyoroti sisi gelap dunia keuangan dan politik, serta bagaimana kekuasaan dan uang dapat memengaruhi orang-orang yang terlibat di dalamnya. ', 'Fiksi', 'Premium', 5, 14, 'negeri_para_bedebah.jfif', '2025-07-27 10:07:10', NULL),
(9, 'Dunia Sophie', 9, 'Novel Dunia Sophie karya Jostein Gaarder menceritakan tentang seorang gadis remaja bernama Sophie Amundsen yang menerima surat-surat misterius berisi pertanyaan filosofis. Surat-surat tersebut mengantarnya pada petualangan mempelajari sejarah filsafat, mulai dari filsuf Yunani kuno hingga filsuf modern. ', 'Filsafat', 'Premium', 4.8, 24, 'dunia_sophie.jfif', '2025-07-27 10:07:10', NULL),
(11, 'Laut Bercerita', 10, 'Novel \"Laut Bercerita\" karya Leila S. Chudori adalah novel fiksi sejarah yang berlatar belakang peristiwa penculikan aktivis pada masa Orde Baru. Novel ini menceritakan kisah Biru Laut, seorang mahasiswa yang aktif dalam gerakan mahasiswa dan menjadi korban penculikan, serta dampak dari peristiwa tersebut pada keluarga dan orang-orang terdekatnya. Novel ini menyoroti bagaimana kekejaman rezim Orde Baru berdampak pada kehidupan individu dan keluarga, serta perjuangan mencari keadilan dan kebenaran di masa lalu. ', 'Fiksi', 'BIasa', 5, 20, 'laut_bercerita.jfif', '2025-07-27 10:07:10', NULL),
(12, 'Negeri 5 Menara', 7, 'Novel \"Negeri 5 Menara\" adalah karya Ahmad Fuadi yang menceritakan kisah persahabatan enam santri dari berbagai daerah di Indonesia yang menuntut ilmu di Pondok Madani, Ponorogo. Novel ini menyoroti perjuangan mereka dalam meraih mimpi, menghadapi tantangan di pesantren, dan bagaimana mereka akhirnya berhasil mewujudkan impian masing-masing setelah lulus. ', 'Fiksi', 'BIasa', 4.2, 14, 'negeri_5_menara.jfif', '2025-07-27 10:07:10', NULL),
(13, 'Anak Semua Bangsa', 8, 'Novel Anak Semua Bangsa karya Pramoedya Ananta Toer menggambarkan penderitaan rakyat Jawa dibawah pemerintahan Belanda yang licik dan haus kekuasaan. Dari sudut pandang Minke, seorang penulis pribumi yang begitu mendewakan Eropa, kita dapat melihat kembali sejarah bangsa Indonesia, serta bercermin melihat diri sendiri.', 'Fiksi', 'Premium', 4.9, 24, 'anak_semua_bangsa.jfif', '2025-07-27 10:07:10', NULL),
(14, 'Daun yang Jatuh Tak Pernah Membenci Angin', 6, 'Novel \"Daun yang Jatuh Tak Pernah Membenci Angin\" karya Tere Liye menceritakan kisah Tania, seorang gadis yang hidup dalam kemiskinan setelah ayahnya meninggal dunia. Bersama ibu dan adik laki-lakinya, Dede, mereka berjuang untuk bertahan hidup, bahkan sampai harus mengamen di jalanan. Kehidupan mereka berubah ketika seorang pria bernama Danar, yang baik hati, datang dan membantu mereka mendapatkan tempat tinggal dan pendidikan. Tania bersekolah lagi dan bahkan mendapatkan beasiswa ke Singapura, tetapi di tengah kebahagiaannya, ia harus menghadapi kenyataan pahit tentang perasaannya pada Danar yang ternyata sudah memiliki kekasih bernama Ratna. ', 'Fiksi', 'BIasa', 5, 25, 'daun_yang_jatuh_tak_pernah_membenci_angin.jfif', '2025-07-27 10:07:10', NULL),
(15, 'Biografi Gus Dur', 12, 'Buku biografi Gus Dur, khususnya yang ditulis oleh Greg Barton berjudul \"Gus Dur: The Authorized Biography of Abdurrahman Wahid\", adalah karya yang mendalam dan komprehensif mengenai kehidupan dan pemikiran tokoh pluralisme ini. Buku ini tidak hanya menyajikan fakta-fakta biografis, tetapi juga mengungkap sisi kemanusiaan Gus Dur, termasuk kelebihan dan kekurangannya, sehingga pembaca dapat lebih dekat dengan sosoknya.', 'Biografi', 'BIasa', 5, 4, 'biografi_gus_dur.jfif', '2025-07-27 10:07:10', NULL),
(16, 'Penjelajah Antariksa', 13, 'Novel \"Penjelajah Antariksa\" adalah serial karya fiksi ilmiah karya Djokolelono yang bercerita tentang petualangan manusia (Terra) setelah planet Bumi (Terra) mereka hancur. Manusia Terra mencari planet baru untuk ditinggali setelah meninggalkan planet mereka yang hancur akibat perang. Seri ini menggambarkan perjalanan mereka yang penuh tantangan, konflik dengan makhluk luar angkasa, dan pencarian tempat tinggal baru di alam semesta yang luas. ', 'Sci-Fi', 'BIasa', 3.8, 9, 'penjelajah_antariksa.jfif', '2025-07-27 10:07:10', NULL),
(17, 'Sejarah Singkat Waktu', 14, '\"Sejarah Singkat Waktu\" (judul asli: A Brief History of Time) adalah buku sains populer yang ditulis oleh Stephen Hawking, membahas konsep-konsep kosmologi untuk pembaca umum. Buku ini menjelaskan teori Big Bang, lubang hitam, dan kerucut cahaya, serta menjawab pertanyaan tentang asal usul alam semesta, sifat waktu, dan kemungkinan adanya dimensi lain. ', 'Sains', 'Premium', 5, 15, 'sejarah_singkat_waktu.jfif', '2025-07-27 10:07:10', NULL),
(18, 'Mata di Tanah Melus', 15, 'Novel \"Mata di Tanah Melus\" karya Okky Madasari menceritakan petualangan seorang gadis bernama Mata yang berusia 12 tahun, yang diajak ibunya berlibur ke Atambua, Nusa Tenggara Timur, sebuah wilayah perbatasan dengan Timor Leste. Di sana, Mata mengalami berbagai kejadian aneh dan bertemu dengan suku Melus, suku asli yang tertutup dari dunia luar dan menjaga alam dengan kuat. ', 'Fantasi', 'BIasa', 39, 7, 'mata_di_tanah_melus.jfif', '2025-07-27 14:54:29', NULL),
(19, 'Menjadi Guru yang Dicintai Siswa', 16, 'Buku \"Menjadi Guru yang Dicintai Siswa\" adalah buku yang membahas tentang bagaimana seorang guru dapat menjalin hubungan yang baik dan dicintai oleh siswanya. Buku ini berisi kumpulan artikel atau tips tentang bagaimana menjadi guru yang ideal di mata siswa. ', 'Pendidikan', 'BIasa', 2, 0, 'menjadi_guru_yang_dicintai_siswa.jfif', '2025-07-27 10:07:10', NULL),
(20, 'Jejak Langkah', 8, '\"Jejak Langkah\" adalah novel ketiga dalam Tetralogi Buru karya Pramoedya Ananta Toer, yang menceritakan tentang perjuangan seorang tokoh bernama Minke melawan kolonialisme Belanda melalui jurnalistik dan organisasi. Minke, seorang pribumi yang cerdas dan berpendidikan, menggunakan surat kabar seperti Medan Prijaji untuk menyuarakan semangat perlawanan terhadap feodalisme dan menyerukan pembentukan organisasi modern. ', 'Fiksi', 'Premium', 4.4, 30, 'jejak_langkah.jfif', '2025-07-27 10:07:10', NULL),
(21, 'Gadis Jeruk', 9, 'Gadis Jeruk, dalam novel \"The Orange Girl\" karya Jostein Gaarder, adalah seorang gadis misterius yang diceritakan dalam surat cinta yang ditulis oleh ayah Georg sebelum meninggal. Gadis ini digambarkan membawa banyak jeruk dalam kantong kertas besar dan menjadi subjek pencarian oleh Georg dan ayahnya. Kisah tentang Gadis Jeruk ini menjadi pintu gerbang bagi Georg untuk merenungkan filosofi kehidupan dan pertanyaan-pertanyaan filosofis tentang alam semesta dan makna hidup. ', 'Fiksi', 'Premium', 3.9, 10, 'gadis_jeruk.jfif', '2025-07-27 10:07:10', NULL),
(22, 'Tentang Kamu', 6, 'Novel \"Tentang Kamu\" karya Tere Liye menceritakan kisah seorang pengacara muda bernama Zaman Zulkarnaen yang ditugaskan untuk menyelesaikan kasus warisan dari kliennya, Sri Ningsih, seorang wanita Indonesia yang meninggal di Paris. Zaman harus menelusuri jejak hidup Sri Ningsih, dari masa kecilnya di Pulau Bungin, Sumbawa, hingga ia menjadi seorang pebisnis sukses di berbagai negara sebelum akhirnya meninggal di panti jompo di Paris. ', 'Fiksi', 'BIasa', 4.6, 14, 'tentang_kamu.jfif', '2025-07-27 10:07:10', NULL),
(23, 'Pulang-Pergi', 6, 'Novel \"Pulang-Pergi\" karya Tere Liye adalah kisah tentang Bujang, seorang mantan pembunuh bayaran, yang kembali berpetualang setelah sebelumnya \"pulang\" dan \"pergi\". Cerita ini melanjutkan kisah Bujang setelah peristiwa di novel \"Pergi\", di mana ia terlibat dalam organisasi kriminal dan harus berhadapan dengan berbagai konflik dan intrik. \"Pulang-Pergi\" menekankan pada tema perjalanan, pencarian jati diri, dan bagaimana seseorang berdamai dengan masa lalu. \r\n', 'Fiksi', 'BIasa', 4.5, 24, 'pulang-pergi.jfif', '2025-07-27 11:30:02', NULL),
(25, 'Ranah 3 Warna ', 7, 'Novel \"Ranah 3 Warna\" adalah novel kedua dari trilogi karya Ahmad Fuadi yang menceritakan kisah Alif Fikri, seorang pemuda Minangkabau yang berjuang keras untuk meraih mimpinya menempuh pendidikan tinggi di Bandung. Novel ini menyoroti perjalanan Alif dalam menghadapi berbagai rintangan, termasuk kesulitan ekonomi dan persaingan, serta bagaimana ia belajar untuk bersabar dan terus berjuang. \r\n', 'Religi', 'BIasa', 4.2, 23, 'ranah_3_warna.jfif', '2025-07-27 11:30:15', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `book_hashtags`
--

CREATE TABLE `book_hashtags` (
  `id_hastag_buku` int(11) NOT NULL,
  `id_book` int(10) NOT NULL,
  `id_hastag` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `book_hashtags`
--

INSERT INTO `book_hashtags` (`id_hastag_buku`, `id_book`, `id_hastag`) VALUES
(1, 1, 2),
(2, 2, 4),
(3, 3, 1),
(4, 4, 3),
(5, 5, 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `buku_favorit_user`
--

CREATE TABLE `buku_favorit_user` (
  `id_buku_favorit` int(11) NOT NULL,
  `id_user` int(10) NOT NULL,
  `id_buku` int(10) NOT NULL,
  `favorited_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `buku_favorit_user`
--

INSERT INTO `buku_favorit_user` (`id_buku_favorit`, `id_user`, `id_buku`, `favorited_at`) VALUES
(1, 1, 2, '2025-06-25 05:01:55'),
(2, 2, 3, '2025-06-25 05:01:55'),
(3, 3, 3, '2025-06-25 05:01:55'),
(4, 4, 4, '2025-06-25 05:01:55'),
(5, 5, 5, '2025-06-25 05:01:55'),
(6, 6, 1, '2025-06-25 05:01:55'),
(7, 1, 25, '2025-07-27 07:22:09'),
(8, 1, 18, '2025-07-27 07:23:51'),
(9, 1, 11, '2025-07-27 07:23:59'),
(10, 1, 23, '2025-07-27 07:24:17'),
(11, 1, 0, '2025-07-27 07:24:28'),
(12, 1, 20, '2025-07-27 07:24:45');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `favorites`
--

CREATE TABLE `favorites` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `book_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `favorites`
--

INSERT INTO `favorites` (`id`, `user_id`, `book_id`, `created_at`, `updated_at`) VALUES
(1, 7, 18, '2025-07-27 08:11:50', '2025-07-27 08:11:50'),
(3, 7, 25, '2025-07-27 08:20:32', '2025-07-27 08:20:32'),
(4, 7, 23, '2025-07-27 16:29:31', '2025-07-27 16:29:31');

-- --------------------------------------------------------

--
-- Struktur dari tabel `hashtags`
--

CREATE TABLE `hashtags` (
  `id_hastag` int(11) NOT NULL,
  `nama_hastag` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `hashtags`
--

INSERT INTO `hashtags` (`id_hastag`, `nama_hastag`, `created_at`) VALUES
(1, 'mental_health', '2025-06-25 04:57:38'),
(2, 'teka-teki', '2025-06-25 04:55:55'),
(3, 'misteri', '2025-06-25 04:55:55'),
(4, 'persahabatan', '2025-06-25 04:55:55'),
(5, 'filosofi', '2025-06-25 04:55:55');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 2),
(3, '2019_08_19_000000_create_failed_jobs_table', 2),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 2),
(5, '2025_07_24_035435_create_admins_table', 2),
(6, '2025_07_24_044454_create_penulis_table', 2),
(7, '2025_07_24_044651_create_books_table', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `penulis`
--

CREATE TABLE `penulis` (
  `id_penulis` int(11) NOT NULL,
  `nama_penulis` varchar(255) NOT NULL,
  `profil` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penulis`
--

INSERT INTO `penulis` (`id_penulis`, `nama_penulis`, `profil`, `created_at`) VALUES
(1, 'Uketsu', 'Penulis misteri asal Jepang yang terkenal karena karyanya yang bergenre horor. Ia juga seorang YouTuber yang dikenal karena konten videonya yang surealis dan misterius, di mana ia tidak pernah menunjukkan wajah atau suaranya.', '2025-06-25 04:13:43'),
(2, 'Andrea Hirata', 'Andrea Hirata Seman Said Harun atau lebih dikenal sebagai Andrea Hirata adalah novelis Indonesia yang berasal dari Pulau Belitung, provinsi Bangka Belitung. Novel pertamanya adalah Laskar Pelangi yang menghasilkan tiga sekuel. Hirata merilis novel Laskar Pelangi pada tahun 2005. Novel ini ditulis dalam waktu enam bulan berdasarkan pengalaman masa kecilnya di Belitung. Ia kemudian menggambarkannya sebagai sebuah ironi tentang kurangnya akses pendidikan bagi anak-anak di salah satu pulau terkaya di dunia.', '2025-06-25 04:13:43'),
(3, 'Brian Khrisna', 'Brian Khrisna, atau yang juga dikenal dengan panggilan “Mbeeer”, seorang penyuka tulisan dan puisi yang bertempat tinggal di Bandung. Sebagian besar tema tulisannya adalah tentang asmara, jatuh cinta, semangat mempertahankan hubungan, putus cinta, kegalauan, sakit hati, kehilangan, dan bangkit dari rasa kehilangan, yang ditulisnya dengan cara yang menarik dan menggunakan pilihan kata yang tepat sasaran, yaitu ke dalam hati pembacanya.', '2025-06-25 04:23:59'),
(4, 'Keigo Higashino ', 'Seorang penulis Jepang yang terkenal karena novel-novelnya bergenre misteri. Dia menjabat sebagai Presiden ke-13 penulis Misteri Jepang dari 2009 hingga 2013. Higashino telah memenangkan penghargaan utama Jepang untuk bukunya, hampir dua puluh di antaranya telah diubah menjadi film dan serial TV. Keigo Higashino menjadi penulis populer di Asia khususnya di Tiongkok. Buku-buku terjemahan seperti The Devotion of Suspect X telah terjual ke negara-negara lain seperti Cina, Thailand, Perancis, Rusia, dan Spanyol dan telah diterbitkan dalam enam bahasa.', '2025-06-25 04:23:59'),
(5, 'Ichiro Kishimi', 'Ichiro Kishimi adalah seorang filsuf, dosen, dan penulis Jepang. Ia lahir pada tanggal 24 Agustus 1956 di Kyoto, Jepang. Kishimi menerima gelar sarjana filsafat dari Universitas Tsukuba pada tahun 1979 dan meraih gelar masternya dari institusi yang sama pada tahun 1982. Kishimi telah memberikan kuliah dan lokakarya tentang psikologi Adlerian dan pertumbuhan pribadi di Jepang dan di seluruh dunia, dan terus mempromosikan pentingnya hak pilihan individu dan minat sosial dalam menciptakan kehidupan yang memuaskan.', '2025-06-25 04:31:26'),
(6, 'Tere Liye', 'Darwis (lahir 21 Mei 1979) yang lebih dikenal dengan nama pena Tere Liye adalah penulis dan akuntan berkebangsaan Indonesia. Memulai debut kepenulisan pada tahun 2005 melalui novel Hafalan Sholat Delisa, ia telah menerbitkan lebih dari 50 buku dalam sepanjang karier menulisnya. Tere Liye memiliki ketrampilan dalam menulis novel berkat hobinya dalam menulis. Ia memulai debut kepenulisan pada tahun 2005 melalui novel Hafalan Sholat Delisa. Beberapa karyanya yang pernah diadaptasi ke layar lebar yaitu Hafalan Shalat Delisa, Bidadari-Bidadari Surga, Moga Bunda Disayang Allah, dan Rembulan Tenggelam di Wajahmu.', '2025-06-27 08:01:31'),
(7, 'Ahmad Fuadi', 'Ahmad Fuadi, S.IP, M.A (lahir 30 Desember 1972) adalah novelis, pekerja sosial, dan mantan wartawan dari Indonesia. Novel pertamanya adalah novel Negeri 5 Menara yang merupakan buku pertama dari trilogi novelnya. Karya fiksinya dinilai dapat menumbuhkan semangat untuk berprestasi. Walaupun tergolong masih baru terbit, novelnya sudah masuk dalam jajaran best seller tahun 2009. Ia adalah cucu Buya H. Sulthani Abdullah Dt. Rajo Dubalang, ketua Persatuan Tarbiyah Islamiyah periode 1930-1931, dan Buya Sulaiman Katik Indo Marajo.', '2025-06-27 08:01:31'),
(8, 'Pramoedya Ananta Toer', 'Pramoedya Ananta Toer (6 Februari 1925 – 30 April 2006) secara luas dianggap sebagai salah satu pengarang yang produktif dalam sejarah sastra Indonesia. Pramoedya telah menghasilkan lebih dari 50 karya dan diterjemahkan ke dalam lebih dari 42 bahasa asing. Pramoedya menempuh pendidikan pada Sekolah Kejuruan Radio di Surabaya, kemudian bekerja sebagai juru ketik untuk surat kabar Jepang Domei di Jakarta selama pendudukan Jepang di Indonesia.', '2025-06-27 08:01:31'),
(9, 'Jostein Gaarder', 'Jostein Gaarder (lahir pada 8 Agustus 1952) adalah seorang intelektual sekaligus penulis novel, cerita pendek dan buku anak-anak dari Norwegia. Gaarder sering menulis dengan menggunakan sudut pandang anak-anak, menonjolkan rasa penasaran mereka akan dunia. Dalam novel Dunia Sophie bahkan ia menganggap bahwa anak-anak dan filsuf memiliki kesamaan,[1] yaitu kepekaan mereka dan rasa penasaran yang besar akan hal-hal baru yang jarang dimiliki oleh orang dewasa pada umumnya. Gaarder juga sering menggunakan metafiksi pada karya-karyanya dan membangun cerita dalam cerita.', '2025-06-27 08:08:38'),
(10, 'Leila Salikha Chudori', 'Leila Salikha Chudori (lahir 12 Desember 1962) adalah seorang penulis dan kritikus film berkebangsaan Indonesia. Namanya dikenal melalui karya-karyanya berupa cerita pendek, novel, dan skenario drama televisi. Leila merupakan salah satu sastrawan yang mengawali debutnya sejak anak-anak.', '2025-06-27 08:08:38'),
(11, 'Abdul Malik Karim Amrullah', 'H. Abdul Malik Karim Amrullah, bergelar Datuak Indomo serta populer dengan nama penanya, Buya Hamka (17 Februari 1908 – 24 Juli 1981), adalah seorang ulama, filsuf, dan sastrawan Indonesia. Ia berkarier sebagai wartawan, penulis, dan pengajar. Ia sempat berkecimpung di politik melalui Masyumi sampai partai tersebut dibubarkan, menjabat Ketua Majelis Ulama Indonesia (MUI) pertama, dan aktif dalam Muhammadiyah hingga akhir hayatnya. Universitas al-Azhar dan Universitas Nasional Malaysia menganugerahkannya gelar doktor kehormatan, sementara Universitas Moestopo mengukuhkan Hamka sebagai guru besar. Namanya disematkan untuk Universitas Hamka milik Muhammadiyah dan masuk dalam daftar Pahlawan Nasional Indonesia.', '2025-06-27 08:08:38'),
(12, 'Greg Barton', 'Greg adalah Profesor Politik Global Islam di Alfred Deakin Institute for Citizenship and Globalization Deakin University, Melbourne, Australia.', '2025-06-27 08:44:52'),
(13, 'Djokolelono', 'Djoko Lelono atau lebih dikenal dengan nama pena Djokolelono adalah seorang penulis buku dari Indonesia yang aktif pada tahun 70-an hingga 80-an. Dia dikenal sebagai penulis buku fiksi-ilmiah seperti seri Penjelajah Antariksa, Jatuh ke Matahari dan sekuelnya, Bintang Hitam.', '2025-06-27 08:44:52'),
(14, 'Stephen Hawking\r\n', 'Stephen William Hawking CH CBE FRS FRSA (8 Januari 1942 – 14 Maret 2018) adalah fisikawan teoretis, kosmologi, pengarang, dan Direktur Penelitian Centre for Theoretical Cosmology di Universitas Cambridge. Karya-karya ilmiahnya meliputi kolaborasi bersama Roger Penrose tentang teorema singularitas gravitasi dalam kerangka relativitas umum dan prediksi teori bahwa lubang hitam mengeluarkan radiasi (biasa disebut radiasi Hawking). Hawking adalah orang pertama yang memaparkan teori kosmologi yang dijelaskan dengan menggabungkan teori relativitas umum dan mekanika kuantum. Ia adalah pendukung interpretasi multidunia teori mekanika kuantum.', '2025-06-27 08:50:20'),
(15, 'Okky Madasari', 'Okky Madasari, Ph.D. adalah seorang sastrawan dan sosiolog Indonesia yang dikenal karena penggambarannya tentang kondisi sosial dan politik di Indonesia. Ia memfokuskan tulisannya pada perlawanan terhadap ketidakadilan dan perjuangan untuk kebebasan dan kemanusiaan.', '2025-06-27 09:02:40'),
(16, 'Muh. Syukur Salman', 'Lahir di Kota Parepare Sulawesi Selatan 42 tahun silam, tepatnya 14 Agustus 1973, guru SDN 71 Parepare ini memang hobbi menulis. Tulisannya banyak dimuat di Koran Pare Pos, tabloid Lacak, majalah Dunia Pendidikan, dan beberapa media online seperti Kompasiana, sekolahdasar.net, guru.or.id, dan kabarindonesia. Tamat SD 1984, lanjut SMP dan tamat tahun 1988, dan karena cita-citanya sejak kecil untuk menjadi guru, maka diputuskan untuk masuk ke Sekolah Pendidikan Guru (SPG).', '2025-06-27 09:02:40');

-- --------------------------------------------------------

--
-- Struktur dari tabel `penulis_favorite_user`
--

CREATE TABLE `penulis_favorite_user` (
  `id_fav_penulis` int(10) NOT NULL,
  `id_user` int(10) NOT NULL,
  `id_penulis` int(10) NOT NULL,
  `favorited_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `penulis_favorite_user`
--

INSERT INTO `penulis_favorite_user` (`id_fav_penulis`, `id_user`, `id_penulis`, `favorited_at`) VALUES
(1, 6, 5, '2025-06-25 05:00:37'),
(2, 4, 2, '2025-06-25 05:00:37'),
(3, 1, 3, '2025-06-25 05:00:37'),
(4, 5, 3, '2025-06-25 05:00:37'),
(5, 2, 4, '2025-06-25 05:00:37'),
(6, 3, 4, '2025-06-25 05:00:37');

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `image` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `bio` text DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` enum('L','P') DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_user`, `username`, `password`, `fullname`, `image`, `created_at`, `bio`, `birth_date`, `gender`, `location`) VALUES
(1, 'rohman76', 'rohman4545', 'M. Abdurrohman', '', '2025-06-25 04:35:02', NULL, NULL, NULL, NULL),
(2, 'luthfi76', 'luthfi4545', 'M. Luthfi Rizqullah', '', '2025-06-25 04:37:01', NULL, NULL, NULL, NULL),
(3, 'kevin76', 'kevin4545', 'Kevin Alvian', '', '2025-06-25 04:37:01', NULL, NULL, NULL, NULL),
(4, 'belva76', 'belva4545', 'Belva Calista', '', '2025-06-25 04:37:48', NULL, NULL, NULL, NULL),
(5, 'dewi76', 'dewi4545', 'Dewi Wati', '', '2025-06-25 04:37:48', NULL, NULL, NULL, NULL),
(6, 'amanda76', 'amanda4545', 'Amanda Sifaul Zanah', '', '2025-06-25 04:38:13', NULL, NULL, NULL, NULL),
(7, 'joko76', 'joko4545', 'Joko Anwar', '', '2025-07-27 00:39:21', NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id_admin`),
  ADD UNIQUE KEY `admins_username_unique` (`username`);

--
-- Indeks untuk tabel `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id_buku`);

--
-- Indeks untuk tabel `book_hashtags`
--
ALTER TABLE `book_hashtags`
  ADD PRIMARY KEY (`id_hastag_buku`);

--
-- Indeks untuk tabel `buku_favorit_user`
--
ALTER TABLE `buku_favorit_user`
  ADD PRIMARY KEY (`id_buku_favorit`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `hashtags`
--
ALTER TABLE `hashtags`
  ADD PRIMARY KEY (`id_hastag`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `penulis`
--
ALTER TABLE `penulis`
  ADD PRIMARY KEY (`id_penulis`);

--
-- Indeks untuk tabel `penulis_favorite_user`
--
ALTER TABLE `penulis_favorite_user`
  ADD PRIMARY KEY (`id_fav_penulis`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `admins`
--
ALTER TABLE `admins`
  MODIFY `id_admin` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `books`
--
ALTER TABLE `books`
  MODIFY `id_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT untuk tabel `book_hashtags`
--
ALTER TABLE `book_hashtags`
  MODIFY `id_hastag_buku` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `buku_favorit_user`
--
ALTER TABLE `buku_favorit_user`
  MODIFY `id_buku_favorit` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `hashtags`
--
ALTER TABLE `hashtags`
  MODIFY `id_hastag` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `penulis`
--
ALTER TABLE `penulis`
  MODIFY `id_penulis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT untuk tabel `penulis_favorite_user`
--
ALTER TABLE `penulis_favorite_user`
  MODIFY `id_fav_penulis` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

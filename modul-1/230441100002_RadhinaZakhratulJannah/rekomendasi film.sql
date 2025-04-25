CREATE DATABASE rekomendasi_film;
USE rekomendasi_film;

CREATE TABLE film (
    id_film INT PRIMARY KEY AUTO_INCREMENT,
    judul VARCHAR(100) NOT NULL,
    thn_rilis YEAR NOT NULL);

CREATE TABLE genre (
    id_genre INT PRIMARY KEY AUTO_INCREMENT,
    nama_genre VARCHAR(50) NOT NULL);

CREATE TABLE pengguna (
    id_user INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE);

CREATE TABLE genre_film (
    id_genrefilm INT PRIMARY KEY AUTO_INCREMENT,
    id_genre INT NOT NULL,
    id_film INT NOT NULL,
    FOREIGN KEY (id_genre) REFERENCES genre(id_genre) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_film) REFERENCES film(id_film) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE ulasan (
    id_ulasan INT PRIMARY KEY AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_film INT NOT NULL,
    rating INT CHECK (rating >= 1 AND rating <= 10),
    komentar TEXT,
    tgl_komen DATE NOT NULL,
    FOREIGN KEY (id_user) REFERENCES pengguna(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_film) REFERENCES film(id_film) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO film (judul, thn_rilis) VALUES
('Red One', 2024),
('Gladiator 2', 2024),
('Moana', 2016),
('Avatar', 2009),
('John Wick', 2014),
('World War Z', 2013),
('Jumanji', 1995),
('The Lord of the Rings', 2001),
('Insidious', 2010),
('The Conjuring', 2013),
('RED', 2010);

INSERT INTO genre (nama_genre) VALUES
('Action'),
('Adventure'),
('Animation'),
('Fantasy'),
('Sci-Fi'),
('Horror'),
('Thriller'),
('Drama'),
('Comedy');

INSERT INTO pengguna (nama, email) VALUES
('Radhina Zakhratul J', 'raddin30@gmail.com'),
('Sunda Madu B', 'sundamadu@gmail.com'),
('Alif Dhaifullah R', 'alifd@gmail.com');

INSERT INTO genre_film (id_genre, id_film) VALUES
(1, 1), -- Red One - Action
(2, 1), -- Red One - Adventure
(1, 2), -- Gladiator 2 - Action
(8, 2), -- Gladiator 2 - Drama
(3, 3), -- Moana - Animation
(2, 3), -- Moana - Adventure
(5, 4), -- Avatar - Sci-Fi
(4, 4), -- Avatar - Fantasy
(1, 5), -- John Wick - Action
(7, 5), -- John Wick - Thriller
(1, 6), -- World War Z - Action
(6, 6), -- World War Z - Horror
(2, 7), -- Jumanji - Adventure
(4, 7), -- Jumanji - Fantasy
(4, 8), -- LOTR - Fantasy
(2, 8), -- LOTR - Adventure
(6, 9), -- Insidious - Horror
(7, 9), -- Insidious - Thriller
(6, 10), -- The Conjuring - Horror
(7, 10), -- The Conjuring - Thriller
(1, 11), -- RED - Action
(9, 11); -- RED - Comedy

INSERT INTO ulasan (id_user, id_film, rating, komentar, tgl_komen) VALUES
(1, 1, 8, 'Seru dan penuh aksi natal!', '2025-04-10'),
(2, 4, 9, 'Visualnya luar biasa', '2025-04-12'),
(3, 5, 7, 'Aksi keren tapi agak repetitif', '2025-04-13'),
(1, 10, 9, 'Sangat menegangkan, bagus banget!', '2025-04-15'),
(2, 3, 8, 'Lagu-lagunya menyenangkan', '2025-04-16');

-- View 2 tabel
CREATE VIEW view_film_dan_genre AS SELECT 
    f.id_film,
    f.judul,
    f.thn_rilis,
    g.nama_genre
FROM film f
JOIN genre_film gf ON f.id_film = gf.id_film
JOIN genre g ON gf.id_genre = g.id_genre;
select * from view_film_dan_genre;

-- View 3 tabel
CREATE VIEW view_ulasan_film_pengguna AS SELECT 
    u.id_ulasan,
    p.nama AS nama_pengguna,
    f.judul AS judul_film,
    u.rating,
    u.komentar,
    u.tgl_komen
FROM ulasan u
JOIN pengguna p ON u.id_user = p.id_user
JOIN film f ON u.id_film = f.id_film;
select * from view_ulasan_film_pengguna;

-- View 2 tabel dgn syarat tertentu
CREATE VIEW view_ulasan_rating_tinggi AS SELECT 
    p.nama AS nama_pengguna,
    f.judul AS judul_film,
    u.rating,
    u.komentar
FROM ulasan u
JOIN pengguna p ON u.id_user = p.id_user
JOIN film f ON u.id_film = f.id_film
WHERE u.rating >= 8;
select * from view_ulasan_rating_tinggi;

-- View agregasi 2 tabel
CREATE VIEW view_jumlah_ulasan_film AS SELECT 
    f.judul,
    COUNT(u.id_ulasan) AS jumlah_ulasan
FROM film f
JOIN ulasan u ON f.id_film = u.id_film
GROUP BY f.id_film, f.judul;
select * from view_jumlah_ulasan_film;

-- View yang berguna
CREATE VIEW view_rata_rata_rating_film AS SELECT 
    f.judul,
    AVG(u.rating) AS rata_rata_rating
FROM film f
JOIN ulasan u ON f.id_film = u.id_film
GROUP BY f.id_film, f.judul;
select * from view_rata_rata_rating_film; 
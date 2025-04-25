

-- View 2 tabel
CREATE VIEW view_film_dan_genre AS SELECT 
    f.id_film,
    f.judul,
    f.thn_rilis,
    g.nama_genre
FROM film f
JOIN genre_film gf ON f.id_film = gf.id_film
JOIN genre g ON gf.id_genre = g.id_genre;
SELECT * FROM view_film_dan_genre;

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
SELECT * FROM view_ulasan_film_pengguna;

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
-- nomer1
ALTER TABLE film ADD keterangan VARCHAR(255);
SELECT * FROM film;

-- nomer2
SELECT f.judul, u.rating, u.komentar FROM film f JOIN ulasan u ON f.`id_film`= u.`id_film`;

-- nomer3
SELECT * FROM film ORDER BY thn_rilis ASC;
SELECT * FROM ulasan ORDER BY rating DESC;

-- nomer4
ALTER TABLE ulasan MODIFY rating DECIMAL (3,1);
SELECT * FROM ulasan ;

-- nomer5
-- Alur: ambil semua data dari film, cocokin yang ada di ulasan, kalau nggak ada tetap tampil NULL.
SELECT f.judul, u.rating FROM film f LEFT JOIN ulasan u ON f.`id_film`= u.`id_film`;
-- Alur: ambil semua data dari ulasan, cocokin yang ada di film, kalau film-nya nggak ada tetap tampil NULL di kolom film.
SELECT f.judul, u.rating FROM ulasan u RIGHT JOIN film f ON f.`id_film`= u.`id_film`;
-- Alur: tabel pengguna dibandingkan dengan dirinya sendiri berdasarkan kata pertama dari nama, tapi pastikan bukan orang yang sama.
SELECT p1.nama AS pengguna1, p2.nama AS pengguna2 FROM pengguna p1 JOIN pengguna p2 ON SUBSTRING_INDEX (p1.`nama`, '', 1) = SUBSTRING_INDEX (p2.`nama`, '', 1) 
WHERE p1.`id_user` <> p2.`id_user`;

-- nomer6
-- Film yang dirilis setelah 2010
SELECT * FROM film WHERE thn_rilis > 2010;
-- Rating di atas atau sama dengan 8
SELECT * FROM ulasan WHERE rating >= 8;
-- Film yang bukan di tahun 2013
SELECT * FROM film WHERE thn_rilis <> 2013;
-- Ulasan dengan rating antara 7 dan 9
SELECT * FROM ulasan WHERE rating BETWEEN 7 AND 9;
-- Film tahun rilis lebih kecil atau sama dengan 2009
SELECT * FROM film WHERE thn_rilis <= 2009;

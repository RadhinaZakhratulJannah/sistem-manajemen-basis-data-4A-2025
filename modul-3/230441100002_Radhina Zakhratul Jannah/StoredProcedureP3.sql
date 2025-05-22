-- Menghapus stored procedure
DROP PROCEDURE IF EXISTS AddUMKM;
DROP PROCEDURE IF EXISTS UpdateKategoriUMKM;
DROP PROCEDURE IF EXISTS DeletePemilikUMKM;
DROP PROCEDURE IF EXISTS AddProduk;
DROP PROCEDURE IF EXISTS GetUMKMByID;

-- no1
DELIMITER //
CREATE PROCEDURE AddUMKM (
    IN p_nama_usaha VARCHAR(100),
    IN p_jumlah_karyawan INT
)
BEGIN
    INSERT INTO umkm (nama_usaha, jumlah_karyawan)
    VALUES (p_nama_usaha, p_jumlah_karyawan);
END //
DELIMITER ;
CALL AddUMKM('Sebelah Sini', 5);

-- no2
DELIMITER //
CREATE PROCEDURE UpdateKategoriUMKM (
    IN p_id_kategori INT,
    IN p_nama_baru VARCHAR(100)
)
BEGIN
    UPDATE kategori_umkm
    SET nama_kategori = p_nama_baru
    WHERE id_kategori = p_id_kategori;
END //
DELIMITER ;
CALL UpdateKategoriUMKM(9, 'Kuliner Tradisional');

-- no3
DELIMITER //
CREATE PROCEDURE DeletePemilikUMKM (
    IN p_id_pemilik INT
)
BEGIN
    DELETE FROM pemilik_umkm
    WHERE id_pemilik = p_id_pemilik;
END //
DELIMITER ;
CALL DeletePemilikUMKM(14);

-- no4
DELIMITER //
CREATE PROCEDURE AddProduk (
    IN id_umkm INT,
    IN nama_produk VARCHAR(100),
    IN harga DECIMAL(15,2)
)BEGIN
    INSERT INTO produk_umkm (id_umkm, nama_produk, harga)
    VALUES (id_umkm, nama_produk, harga);
END //
DELIMITER ;
CALL AddProduk(1, 'Keripik Singkong', 15000.00);

-- no5
DELIMITER //
CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT
)BEGIN
    SELECT * FROM umkm WHERE id_umkm = p_id_umkm;
END //
DELIMITER ;
CALL GetUMKMByID(1);

SELECT * FROM umkm ;
SELECT * FROM kategori_umkm ;
SELECT * FROM pemilik_umkm ;
SELECT * FROM produk_umkm ;
SELECT * FROM umkm WHERE id_umkm = 1;
CALL GetUMKMByID(1);

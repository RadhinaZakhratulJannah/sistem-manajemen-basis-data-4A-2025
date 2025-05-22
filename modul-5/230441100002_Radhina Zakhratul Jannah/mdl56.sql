-- no 1
DELIMITER //
CREATE PROCEDURE ulasan_7hari()
BEGIN
    SELECT * FROM ulasan
    WHERE tgl_komen >= CURDATE() - INTERVAL 7 DAY;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ulasan_1bulan()
BEGIN
    SELECT * FROM ulasan
    WHERE tgl_komen >= CURDATE() - INTERVAL 1 MONTH;
END//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ulasan_3bulan()
BEGIN
    SELECT * FROM ulasan
    WHERE tgl_komen >= CURDATE() - INTERVAL 3 MONTH;
END//
DELIMITER ;


-- no 2
DELIMITER //
CREATE PROCEDURE hapus_ulasan_valid_lama()
BEGIN
    DELETE FROM ulasan
    WHERE tgl_komen < CURDATE() - INTERVAL 1 YEAR
      AND rating IS NOT NULL;
END//
DELIMITER ;


-- no 3
DELIMITER //
CREATE PROCEDURE update_komentar_ulasan()
BEGIN
    UPDATE ulasan
    SET komentar = 'Komentar diupdate'
    LIMIT 7;
END//
DELIMITER ;


-- no 4
DELIMITER //
CREATE PROCEDURE edit_pengguna_jika_bebas_ulasan(
    IN uid INT,
    IN new_nama VARCHAR(100),
    IN new_email VARCHAR(100)
)
BEGIN
    UPDATE pengguna
    SET nama = new_nama, email = new_email
    WHERE id_user = uid
    AND id_user NOT IN (
        SELECT DISTINCT id_user FROM ulasan
    );
END//
DELIMITER ;


-- no 5
ALTER TABLE film ADD COLUMN STATUS VARCHAR(20) DEFAULT NULL;

DELIMITER //
CREATE PROCEDURE status_ulasan_bulanan()
BEGIN
    -- Buat temporary table berisi jumlah ulasan per film dalam 1 bulan terakhir
    DROP TEMPORARY TABLE IF EXISTS tmp_ulasan;
    CREATE TEMPORARY TABLE tmp_ulasan AS
    SELECT
        id_film,
        COUNT(*) AS total_ulasan
    FROM ulasan
    WHERE tgl_komen >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
    GROUP BY id_film;

    -- Ambil nilai minimum dan maksimum ulasan
    SET @min_ulasan := (SELECT MIN(total_ulasan) FROM tmp_ulasan);
    SET @max_ulasan := (SELECT MAX(total_ulasan) FROM tmp_ulasan);

    -- Update status menjadi 'non-aktif' untuk film dengan ulasan paling sedikit
    UPDATE film
    INNER JOIN tmp_ulasan USING (id_film)
    SET film.status = 'non-aktif'
    WHERE tmp_ulasan.total_ulasan = @min_ulasan;

    -- Update status menjadi 'aktif' untuk film dengan ulasan terbanyak
    UPDATE film
    INNER JOIN tmp_ulasan USING (id_film)
    SET film.status = 'aktif'
    WHERE tmp_ulasan.total_ulasan = @max_ulasan;

    -- Update status menjadi 'pasif' untuk film selain min dan max
    UPDATE film
    INNER JOIN tmp_ulasan USING (id_film)
    SET film.status = 'pasif'
    WHERE tmp_ulasan.total_ulasan NOT IN (@min_ulasan, @max_ulasan);
END //
DELIMITER ;


-- no 6
DELIMITER //
CREATE PROCEDURE jumlah_ulasan_sukses()
BEGIN
    DECLARE total INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE idu INT;

    DECLARE cur CURSOR FOR
        SELECT id_ulasan FROM ulasan
        WHERE tgl_komen >= CURDATE() - INTERVAL 1 MONTH
        AND rating >= 7;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    ulasan_loop: LOOP
        FETCH cur INTO idu;
        IF done THEN
            LEAVE ulasan_loop;
        END IF;
        SET total = total + 1;
    END LOOP;

    CLOSE cur;

    SELECT total AS jumlah_ulasan_sukses;
END//
DELIMITER ;



-- pemanggilan
CALL ulasan_7hari();
CALL ulasan_1bulan();
CALL ulasan_3bulan();

CALL hapus_ulasan_valid_lama();
SELECT * FROM ulasan;

CALL update_komentar_ulasan();
SELECT * FROM ulasan;

CALL edit_pengguna_jika_bebas_ulasan(5, "baru", "baru@gmail.com");
SELECT * FROM pengguna;

CALL status_ulasan_bulanan();
SELECT * FROM film;

CALL jumlah_ulasan_sukses;
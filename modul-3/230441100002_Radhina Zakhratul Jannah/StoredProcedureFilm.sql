USE rekomendasi_film;

-- =======================
-- 1. UpdateDataMaster (update nama genre)
-- =======================
DELIMITER //
CREATE PROCEDURE UpdateDataMaster(
    IN p_id INT,
    IN p_nilai_baru VARCHAR(50),
    OUT p_status INT
)
BEGIN
    DECLARE v_exists INT;

    SELECT COUNT(*) INTO v_exists FROM genre WHERE id_genre = p_id;

    IF v_exists = 1 THEN
        UPDATE genre SET nama_genre = p_nilai_baru WHERE id_genre = p_id;
        SET p_status = 1;
    ELSE
        SET p_status = 0;
    END IF;
END //
DELIMITER ;

-- =======================
-- 2. CountFilm (hitung jumlah film)
-- =======================
DELIMITER //
CREATE PROCEDURE CountFilm(OUT total_film INT)
BEGIN
    SELECT COUNT(*) INTO total_film FROM film;
END //
DELIMITER ;

-- ==============================
-- 3. GetFilmByID (ambil detail film)
-- ==============================
DELIMITER //
CREATE PROCEDURE GetFilmByID(
    IN p_id INT,
    OUT p_judul VARCHAR(100),
    OUT p_thn_rilis YEAR
)
BEGIN
    SELECT judul, thn_rilis
    INTO p_judul, p_thn_rilis
    FROM film WHERE id_film = p_id;
END //
DELIMITER ;

-- ========================================
-- 4. UpdateUlasan (update rating & komentar)
-- ========================================
DELIMITER //
CREATE PROCEDURE UpdateUlasan(
    IN p_id INT,
    INOUT p_rating INT,
    INOUT p_komentar TEXT
)
BEGIN
    DECLARE v_rating INT;
    DECLARE v_komentar TEXT;

    SELECT rating, komentar INTO v_rating, v_komentar FROM ulasan WHERE id_ulasan = p_id;

    IF p_rating IS NULL OR p_rating = 0 THEN
        SET p_rating = v_rating;
    END IF;

    IF p_komentar IS NULL THEN
        SET p_komentar = v_komentar;
    END IF;

    UPDATE ulasan
    SET rating = p_rating,
        komentar = p_komentar
    WHERE id_ulasan = p_id;
END //
DELIMITER ;

-- =======================================
-- 5. DeleteFilmByID (hapus data film)
-- =======================================
DELIMITER //
CREATE PROCEDURE DeleteFilmByID(
    IN p_id INT
)
BEGIN
    DELETE FROM film WHERE id_film = p_id;
END //
DELIMITER ;

-- ===========================
-- panggilan prosedur:
-- ===========================

-- Update nama genre
CALL UpdateDataMaster(9, 'Comedy Drama', @status);
SELECT @status;

-- Hitung jumlah film
CALL CountFilm(@total);
SELECT @total;

-- Ambil data film by id
CALL GetFilmByID(3, @judul, @rilis);
SELECT @judul, @rilis;

-- Update rating dan komentar ulasan
SET @rating = NULL;
SET @komentar = 'Seru, wajib nonton!';
CALL UpdateUlasan(3, @rating, @komentar);
SELECT @rating, @komentar;

-- Hapus data film by id
CALL DeleteFilmByID(10);
SELECT * FROM film;

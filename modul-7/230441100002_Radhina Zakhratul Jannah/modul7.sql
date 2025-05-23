-- no 1
DELIMITER //
CREATE TRIGGER before_insert_ulasan
BEFORE INSERT ON ulasan
FOR EACH ROW
BEGIN
    IF NEW.rating < 1 OR NEW.rating > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rating harus di antara 1 sampai 10!';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER before_update_film
BEFORE UPDATE ON film
FOR EACH ROW
BEGIN
    IF NEW.thn_rilis > YEAR(CURDATE()) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tahun rilis tidak boleh lebih dari tahun sekarang!';
    END IF;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER before_delete_pengguna
BEFORE DELETE ON pengguna
FOR EACH ROW
BEGIN
    IF OLD.id_user = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Akun admin tidak boleh dihapus!';
    END IF;
END//
DELIMITER ;

-- pemanggilan
INSERT INTO ulasan (id_user, id_film, rating, komentar, tgl_komen)
VALUES (1, 1, 8, 'Rating aneh', '2025-05-16');

UPDATE film
SET thn_rilis = 2021
WHERE id_film = 5;

DELETE FROM pengguna WHERE id_user = 5;

SELECT * FROM pengguna;
SELECT * FROM film;
SELECT * FROM ulasan;


-- no 2
CREATE TABLE log_aktivitas (
    id_log INT PRIMARY KEY AUTO_INCREMENT,
    aksi VARCHAR(50),
    keterangan TEXT,
    waktu DATETIME
);

DELIMITER //
CREATE TRIGGER after_insert_ulasan
AFTER INSERT ON ulasan
FOR EACH ROW
BEGIN
    INSERT INTO log_aktivitas (aksi, keterangan, waktu)
    VALUES ('INSERT ULASAN',
            CONCAT('User ID ', NEW.id_user, ' memberi rating ', NEW.rating, ' untuk Film ID ', NEW.id_film),
            NOW());
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER after_update_film
AFTER UPDATE ON film
FOR EACH ROW
BEGIN
    INSERT INTO log_aktivitas (aksi, keterangan, waktu)
    VALUES ('UPDATE FILM',
            CONCAT('Film "', OLD.judul, '" diubah menjadi "', NEW.judul, '", tahun rilis: ', NEW.thn_rilis),
            NOW());
END//
DELIMITER ;


DELIMITER //
CREATE TRIGGER after_delete_film
AFTER DELETE ON film
FOR EACH ROW
BEGIN
    INSERT INTO log_aktivitas (aksi, keterangan, waktu)
    VALUES ('DELETE FILM',
            CONCAT('Film "', OLD.judul, '" (ID: ', OLD.id_film, ') telah dihapus.'),
            NOW());
END//
DELIMITER ;

-- pemanggilan
INSERT INTO ulasan (id_user, id_film, rating, komentar, tgl_komen)
VALUES (1, 4, 9, 'Bagus banget!', '2025-05-16');

UPDATE film
SET judul = 'Avatar: Remaster', thn_rilis = 2025
WHERE id_film = 4;

DELETE FROM film WHERE id_film = 11;

SELECT * FROM log_aktivitas;

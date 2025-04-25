CREATE DATABASE akademikprogram;
USE akademikprogram;

CREATE TABLE mahasiswa (
nim CHAR (15) PRIMARY KEY,
nama VARCHAR (50) NOT NULL,
prodi VARCHAR (50) NOT NULL,
angkatan YEAR NOT NULL);

CREATE TABLE dosen (
nip CHAR (25) PRIMARY KEY,
nama VARCHAR (50) NOT NULL,
minat_penelitian VARCHAR (50),
no_tlp VARCHAR (15));

CREATE TABLE MataKuliah (
id_mk CHAR (20) PRIMARY KEY,
nama_mk VARCHAR (100) NOT NULL,
sks INT NOT NULL,
semester INT NOT NULL);

CREATE TABLE KRS (
id_krs INT AUTO_INCREMENT PRIMARY KEY,
nim CHAR (15),
id_mk CHAR (20),
tahun_ajar CHAR (9) NOT NULL,
semester INT NOT NULL,
FOREIGN KEY (nim) REFERENCES mahasiswa (nim) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (id_mk) REFERENCES MataKuliah (id_mk) ON DELETE CASCADE ON UPDATE
CASCADE );
CREATE TABLE bimbingan_akademik (
id_bimbingan int auto_increment primary key,
nim char (15),
nip char (25),
tgl_bimbing date,
catatan varchar (255),
foreign key (nim) references mahasiswa (nim) on delete cascade on update cascade,
foreign key (nip) references on delete cascade on update cascade );

insert into mahasiswa (nim, nama, prodi, angkatan) values
('230441100001', 'Maghfira R.H', 'Sistem Informasi', 2023),
('230441100003', 'Sunda M.B', 'Sistem Informasi', 2023),
('230441100004', 'El Ruby A', 'Sistem Informasi', 2023),
('230441100005', 'Safira R.A', 'Sistem Informasi', 2023),
('230441100006', 'Leyly A', 'Sistem Informasi', 2023),
('230441100007', 'Khusnur F', 'Sistem Informasi', 2023),
('230441100008', 'M.Yusri', 'Sistem Informasi', 2023),
('230441100009', 'M.Ilham F', 'Sistem Informasi', 2023),
('2304411000010', 'Amanatul M', 'Sistem Informasi', 2023),
('2304411000011', 'M.Anwar', 'Sistem Informasi', 2023);

INSERT INTO dosen (nip, nama, minat_penelitian, no_tlp) VALUES
('197509092003121001', 'Dr. Budi Dwi Satoto, S.T., M.Kom.', 'Data Mining', '081234567890'),
('197808042003121001', 'Wahyudi Agustiono, S.Kom., M.Sc., Ph.D', 'Information Systems', '081234567891'),
('197709212008122002', 'Dr. Yeni Kustiyahningsih, S.Kom., M.Kom.', 'Enterprise Architecture Planning', '081234567892'),
('19791252008121002', 'Muhammad Yusuf, S.T., M.MT, PhD', 'E-Government', '081234567893'),
('19780926200641001', 'Dr. Wahyudi Setiawan, S.Kom, M.Kom', 'Image Processing', '081234567894'),
('198308282008122002', 'Sri Herawati, S.Kom., M.Kom', 'Forecasting', '081234567895'),
('19780504201221002', 'Firmansyah Adiputra, S.T., M.Cs.', 'Software Engineering', '081234567896'),
('198206112008011010', 'Achmad Yasid, S.Kom., M.Kom', 'Clustering', '081234567897'),
('198003212008011008', 'Mohammad Syarief, S.T., M.Cs.', 'Semantic Web', '081234567898'),
('197906052003122003', 'Eza Rahmantia, S.T., M.T.', 'Data Mining', '081234567899');
INSERT INTO MataKuliah (id_mk, nama_mk, sks, semester) VALUES
('MK001', 'Data Mining', 3, 4),
('MK002', 'Implementasi dan Pengujian Perangkat Lunak', 3, 4),
('MK003', 'Sistem Pendukung Keputusan', 3, 4),
('MK004', 'Sistem Manajemen Basis Data', 4, 4),
('MK005', 'Perencanaan Sumber Daya Perusahaan', 3, 4),
('MK006', 'Manajemen Proyek IT', 3, 4),
('MK007', 'Pemrograman Bergerak', 4, 4),
('MK008', 'Financial Technology', 3, 4),
('MK009', 'Artificial Intelligence', 3, 6),
('MK010', 'Internet of Things (IoT)', 3, 6);

INSERT INTO KRS (id_krs, nim, id_mk, semester, tahun_ajar) VALUES
('KRS001', '230441100001', 'MK001', 4, '2024/2025'),
('KRS002', '230441100003', 'MK002', 4, '2024/2025'),
('KRS003', '230441100004', 'MK003', 4, '2024/2025'),
('KRS004', '230441100005', 'MK004', 4, '2024/2025'),
('KRS005', '230441100006', 'MK005', 4, '2024/2025');
alter table MataKuliah rename to matkul;
drop database akademikprogram;

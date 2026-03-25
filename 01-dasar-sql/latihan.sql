-- Database: toko_online
-- Script lengkap hari 1

-- Buat database
CREATE DATABASE IF NOT EXISTS toko_online;
USE toko_online;

-- Drop tabel jika ada (urutan terbalik karena foreign key)
DROP TABLE IF EXISTS detail_pesanan;
DROP TABLE IF EXISTS pesanan;
DROP TABLE IF EXISTS produk;
DROP TABLE IF EXISTS pelanggan;

-- Tabel pelanggan
CREATE TABLE pelanggan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    kota VARCHAR(50),
    tanggal_daftar DATE
);

-- Tabel produk
CREATE TABLE produk (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_produk VARCHAR(100) NOT NULL,
    harga DECIMAL(10,2),
    stok INT
);

-- Tabel pesanan
CREATE TABLE pesanan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pelanggan_id INT,
    tanggal_pesan DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(id)
);

-- Tabel detail pesanan
CREATE TABLE detail_pesanan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pesanan_id INT,
    produk_id INT,
    jumlah INT,
    harga_satuan DECIMAL(10,2),
    FOREIGN KEY (pesanan_id) REFERENCES pesanan(id),
    FOREIGN KEY (produk_id) REFERENCES produk(id)
);

-- Insert data
INSERT INTO pelanggan (nama, email, kota, tanggal_daftar) VALUES
('Andi Wijaya', 'andi@email.com', 'Jakarta', '2024-01-10'),
('Budi Santoso', 'budi@email.com', 'Bandung', '2024-01-15'),
('Cici Rahmawati', 'cici@email.com', 'Surabaya', '2024-02-01');

INSERT INTO produk (nama_produk, harga, stok) VALUES
('Laptop', 8000000, 10),
('Mouse', 150000, 50),
('Keyboard', 300000, 30);

INSERT INTO pesanan (pelanggan_id, tanggal_pesan, total) VALUES
(1, '2024-02-10', 8150000),
(2, '2024-02-12', 300000);

INSERT INTO detail_pesanan (pesanan_id, produk_id, jumlah, harga_satuan) VALUES
(1, 1, 1, 8000000),
(1, 2, 1, 150000),
(2, 3, 1, 300000);

-- Query latihan
-- 1. Semua pelanggan
SELECT * FROM pelanggan;

-- 2. Pelanggan dari Jakarta
SELECT * FROM pelanggan WHERE kota = 'Jakarta';

-- 3. Pesanan dengan nama pelanggan
SELECT p.id, p.tanggal_pesan, pl.nama, p.total
FROM pesanan p
INNER JOIN pelanggan pl ON p.pelanggan_id = pl.id;

-- 4. Detail pesanan dengan nama produk
SELECT dp.pesanan_id, pr.nama_produk, dp.jumlah, dp.harga_satuan
FROM detail_pesanan dp
INNER JOIN produk pr ON dp.produk_id = pr.id;

-- 5. Pelanggan yang belum pesan
SELECT pl.nama, COUNT(ps.id) AS jumlah_pesanan
FROM pelanggan pl
LEFT JOIN pesanan ps ON pl.id = ps.pelanggan_id
GROUP BY pl.nama;

-- 6. Produk dengan harga di atas rata-rata
SELECT * FROM produk 
WHERE harga > (SELECT AVG(harga) FROM produk);
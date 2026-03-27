--1. Melihat Execution Plan

-- Lihat execution plan query tanpa indeks
EXPLAIN SELECT * FROM pesanan WHERE pelanggan_id = 1;

-- Lihat execution plan query JOIN
EXPLAIN SELECT pl.nama, p.total
FROM pelanggan pl
INNER JOIN pesanan p ON pl.id = p.pelanggan_id
WHERE pl.kota = 'Jakarta';

--2. Membuat Indeks untuk Mempercepat Query

-- Buat indeks pada kolom yang sering di-WHERE atau JOIN
CREATE INDEX idx_pesanan_pelanggan ON pesanan(pelanggan_id);
CREATE INDEX idx_pelanggan_kota ON pelanggan(kota);

--3. Bandingkan Sebelum dan Sesudah Indeks

-- Jalankan EXPLAIN lagi, bandingkan kolom 'rows' dan 'type'
EXPLAIN SELECT pl.nama, p.total
FROM pelanggan pl
INNER JOIN pesanan p ON pl.id = p.pelanggan_id
WHERE pl.kota = 'Jakarta';

4. Tips Optimasi Lain

-- Hindari SELECT * (hanya ambil kolom yang dibutuhkan)
SELECT nama, email FROM pelanggan;  -- lebih cepat dari SELECT *

-- Gunakan EXISTS daripada IN untuk subquery besar
SELECT * FROM produk p
WHERE EXISTS (SELECT 1 FROM detail_pesanan dp WHERE dp.produk_id = p.id);
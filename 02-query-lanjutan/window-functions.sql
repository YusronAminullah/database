--1. ROW_NUMBER() - Memberi Nomor Urut

-- Beri nomor urut pelanggan berdasarkan tanggal daftar
SELECT 
    nama,
    kota,
    tanggal_daftar,
    ROW_NUMBER() OVER (ORDER BY tanggal_daftar) AS nomor_urut
FROM pelanggan;

-- Beri nomor urut per kota (partisi)
SELECT 
    nama,
    kota,
    tanggal_daftar,
    ROW_NUMBER() OVER (PARTITION BY kota ORDER BY tanggal_daftar) AS urutan_di_kota
FROM pelanggan;

--2. RANK() dan DENSE_RANK() - Peringkat

-- Peringkat produk berdasarkan harga
SELECT 
    nama_produk,
    harga,
    RANK() OVER (ORDER BY harga DESC) AS peringkat_rank,
    DENSE_RANK() OVER (ORDER BY harga DESC) AS peringkat_dense_rank
FROM produk;

3. LEAD() dan LAG() - Lihat Data Sebelum/Sesudah

-- Lihat pesanan sebelumnya dan berikutnya untuk setiap pelanggan
SELECT 
    pelanggan_id,
    tanggal_pesan,
    total,
    LAG(total, 1, 0) OVER (PARTITION BY pelanggan_id ORDER BY tanggal_pesan) AS total_pesanan_sebelumnya,
    LEAD(total, 1, 0) OVER (PARTITION BY pelanggan_id ORDER BY tanggal_pesan) AS total_pesanan_berikutnya
FROM pesanan
ORDER BY pelanggan_id, tanggal_pesan;

4. SUM() OVER() - Running Total

-- Running total pesanan per pelanggan
SELECT 
    pelanggan_id,
    tanggal_pesan,
    total,
    SUM(total) OVER (PARTITION BY pelanggan_id ORDER BY tanggal_pesan) AS running_total
FROM pesanan;
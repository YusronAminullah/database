--1. CTE Sederhana

-- CTE untuk menghitung total pesanan per pelanggan
WITH total_pesanan_per_pelanggan AS (
    SELECT 
        pelanggan_id,
        COUNT(*) AS jumlah_pesanan,
        SUM(total) AS total_belanja
    FROM pesanan
    GROUP BY pelanggan_id
)
SELECT 
    pl.nama,
    tpp.jumlah_pesanan,
    tpp.total_belanja
FROM pelanggan pl
LEFT JOIN total_pesanan_per_pelanggan tpp ON pl.id = tpp.pelanggan_id;

--2. CTE Rekursif (Hierarki)

-- Buat tabel contoh untuk hierarki karyawan
CREATE TABLE karyawan (
    id INT PRIMARY KEY,
    nama VARCHAR(100),
    manager_id INT
);

INSERT INTO karyawan VALUES
(1, 'CEO', NULL),
(2, 'Direktur IT', 1),
(3, 'Direktur Keuangan', 1),
(4, 'Manager Database', 2),
(5, 'Manager Network', 2),
(6, 'DBA Senior', 4),
(7, 'DBA Junior', 6);

-- CTE rekursif untuk melihat struktur organisasi
WITH RECURSIVE hirarki AS (
    -- Anchor: level teratas (CEO)
    SELECT id, nama, manager_id, 1 AS level, CAST(nama AS CHAR(500)) AS path
    FROM karyawan
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive: cari bawahan
    SELECT k.id, k.nama, k.manager_id, h.level + 1, CONCAT(h.path, ' → ', k.nama)
    FROM karyawan k
    INNER JOIN hirarki h ON k.manager_id = h.id
)
SELECT * FROM hirarki ORDER BY level, nama;
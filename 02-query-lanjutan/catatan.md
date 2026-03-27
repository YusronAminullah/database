# Hari 2: SQL Lanjutan - Window Functions, CTE, dan Query Optimization

Tanggal: 26 Maret 2026  
Durasi: 3 jam

## 🎯 Tujuan Hari Ini
- [x] Window Functions (ROW_NUMBER, RANK, LEAD, LAG)
- [x] CTE sederhana dan rekursif
- [x] Query Optimization dengan EXPLAIN
- [x] Membuat indeks untuk mempercepat query

## 📊 Window Functions

### ROW_NUMBER()
Memberi nomor urut pada setiap baris.

```sql
SELECT nama, kota, ROW_NUMBER() OVER (ORDER BY tanggal_daftar) AS nomor_urut
FROM pelanggan;
```
![ROW_NUMBER() sederhana](screenshot/01-row-number.png)

### PARTITION BY
Mengelompokkan sebelum memberi nomor.

```sql
SELECT nama, kota, ROW_NUMBER() OVER (PARTITION BY kota ORDER BY tanggal_daftar) AS urutan_di_kota
FROM pelanggan;
```
![ROW_NUMBER() dengan PARTITION BY](screenshot/02-partition-by.png)

### RANK() vs DENSE_RANK()

```sql
SELECT 
    nama_produk,
    harga,
    RANK() OVER (ORDER BY harga DESC) AS peringkat_rank,
    DENSE_RANK() OVER (ORDER BY harga DESC) AS peringkat_dense_rank
FROM produk;
```
![RANK() vs DENSE_RANK()](screenshot/03-rank.png)

### LEAD() dan LAG()
Melihat data baris sebelumnya dan berikutnya.

```sql
SELECT 
    pelanggan_id,
    tanggal_pesan,
    total,
    LAG(total, 1, 0) OVER (PARTITION BY pelanggan_id ORDER BY tanggal_pesan) AS total_pesanan_sebelumnya,
    LEAD(total, 1, 0) OVER (PARTITION BY pelanggan_id ORDER BY tanggal_pesan) AS total_pesanan_berikutnya
FROM pesanan
ORDER BY pelanggan_id, tanggal_pesan;
```
![LEAD() dan LAG()](screenshot/04-lead-lag.png)

### Running Total

```sql
SELECT 
    pelanggan_id,
    tanggal_pesan,
    total,
    SUM(total) OVER (PARTITION BY pelanggan_id ORDER BY tanggal_pesan) AS running_total
FROM pesanan;
```
![Running Total](screenshot/05-running-total.png)

### 📊 CTE (Common Table Expression)
CTE Sederhana

```sql
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
```
![CTE sederhana](screenshot/06-cte.png)

### CTE Rekursif (Hierarki Organisasi)

```sql
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
```
![CTE rekursif](screenshot/07-cte-rekursif.png)

### Query Optimization
Sebelum Buat Indeks

```sql
EXPLAIN SELECT * FROM pesanan WHERE pelanggan_id = 1;
```
![EXPLAIN sebelum indeks](screenshot/08-explain-before.png)


### Setelah Buat Indeks

```sql
CREATE INDEX idx_pesanan_pelanggan ON pesanan(pelanggan_id);
CREATE INDEX idx_pelanggan_kota ON pelanggan(kota);

EXPLAIN SELECT pl.nama, p.total
FROM pelanggan pl
INNER JOIN pesanan p ON pl.id = p.pelanggan_id
WHERE pl.kota = 'Jakarta';
```
![EXPLAIN setelah indeks](screenshot/09-explain-after.png)

Perbedaan Sebelum vs Sesudah Indeks

rows: berkurang drastis
type: dari ALL (full scan) menjadi ref (index lookup)

📝 Progress Checklist

ROW_NUMBER()
RANK() dan DENSE_RANK()
LEAD() dan LAG()
Running Total dengan SUM() OVER()
CTE sederhana
CTE rekursif
EXPLAIN execution plan
Membuat indeks
Query Optimization lanjutan (hari berikutnya)

🔗 Referensi
MySQL Window Functions
MySQL CTE
MySQL Indexing
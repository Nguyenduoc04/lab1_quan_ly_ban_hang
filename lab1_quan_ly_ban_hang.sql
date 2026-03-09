DROP DATABASE IF EXISTS quan_ly_ban_hang;
create database quan_ly_ban_hang;
use quan_ly_ban_hang;

CREATE TABLE khach_hang (
    ma_khach_hang VARCHAR(5) PRIMARY KEY,
    ho_va_ten_lot VARCHAR(50),
    ten VARCHAR(50),
    dia_chi VARCHAR(255),
    email VARCHAR(50),
    dien_thoai VARCHAR(13)
);

INSERT INTO khach_hang (ma_khach_hang, ho_va_ten_lot, ten, dia_chi, email, dien_thoai) VALUES
('001', 'Lê Văn', 'A', '30 Trần Hưng Đạo', 'levana@gmail.com', '0987654321'),
('005', 'Nguyễn Văn', 'B', '51 Lê Hồng Phong', 'nguyenvanb@gmail.com', '0123456789'),
('924', 'Lê Thị', 'C', '99 Cao Bá Quát', 'lethic@gmail.com', '03716482743'),
('036', 'Cao Thị', 'D', '67 Hồ Chí Minh', 'caothid@gmail.com', '036189275942'),
('012', 'Trần Đức', 'E', '561 Trường Chinh', 'tranduce@gmail.com', '06298538472');

select * from khach_hang;

CREATE TABLE san_pham (
    ma_san_pham INT AUTO_INCREMENT PRIMARY KEY,
    ten_sp VARCHAR(50),
    mo_ta VARCHAR(255),
    so_luong INT CHECK (so_luong >= 0),
    don_gia DECIMAL(15,2) CHECK (don_gia >= 0)
);

INSERT INTO san_pham (ten_sp, mo_ta, so_luong, don_gia) VALUES
('Laptop Dell', 'Laptop văn phòng', 10, 15000000),
('Chuột Logitech', 'Chuột không dây', 50, 350000),
('Bàn phím cơ', 'Keyboard gaming', 20, 1200000),
('Màn hình Samsung', 'Màn hình 24 inch', 15, 4200000),
('Tai nghe Sony', 'Tai nghe chống ồn', 25, 2800000);

CREATE TABLE hoa_don (
  ma_hoa_don INT AUTO_INCREMENT PRIMARY KEY,
  ngay_mua_hang DATE,
  ma_khach_hang VARCHAR(5), 
  trang_thai VARCHAR(30),
  FOREIGN KEY (ma_khach_hang) REFERENCES khach_hang(ma_khach_hang)
);

INSERT INTO hoa_don (ngay_mua_hang, ma_khach_hang, trang_thai) VALUES
('2026-03-01','001','Đã thanh toán'),
('2026-03-02','005','Chưa thanh toán'),
('2026-03-03','924','Đã thanh toán'),
('2026-03-04','036','Đang xử lý'),
('2026-03-05','012','Đã thanh toán');

CREATE TABLE hoa_don_chi_tiet (
  ma_hoa_don_chi_tiet INT AUTO_INCREMENT PRIMARY KEY,
  ma_hoa_don INT,
  ma_san_pham INT, 
  so_luong INT,
  FOREIGN KEY (ma_hoa_don) REFERENCES hoa_don(ma_hoa_don),
  FOREIGN KEY (ma_san_pham) REFERENCES san_pham(ma_san_pham)
);

INSERT INTO hoa_don_chi_tiet (ma_hoa_don, ma_san_pham, so_luong) VALUES
(1,1,1),
(1,2,2),
(2,3,1),
(3,4,1),
(4,5,2);

SELECT count(ma_khach_hang) FROM khach_hang;

SELECT max(don_gia) FROM san_pham;

SELECT min(don_gia) FROM san_pham;

SELECT sum(so_luong) FROM san_pham;

SELECT count(*) as so_hoa_don
FROM hoa_don 
WHERE ngay_mua_hang BETWEEN '2016-12-01' AND '2016-12-31'
AND trang_thai = 'Chưa thanh toán'; 

SELECT ma_hoa_don, COUNT(ma_san_pham) AS so_loai_san_pham
FROM hoa_don_chi_tiet
GROUP BY ma_hoa_don;

SELECT ma_hoa_don, COUNT(ma_san_pham) AS so_loai_san_pham
FROM hoa_don_chi_tiet
GROUP BY ma_hoa_don
having so_loai_san_pham >= 5;

SELECT ma_hoa_don, ngay_mua_hang, ma_khach_hang 
FROM hoa_don
ORDER BY ngay_mua_hang DESC;

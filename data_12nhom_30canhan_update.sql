create database Website_tmdt
use Website_tmdt

create table NHABANHANG (
MANBH char(20) primary key,
TENNBH nvarchar(100) not null,
EMAIL varchar(100) not null unique,
SDT varchar(20) not null,
DIACHI nvarchar(200),
NGAYDANGKY date not null)
go

create table DANHMUC (
MADM char(20) primary key,
TENDM nvarchar(100) not null)
go

create table QUANLY (
MANBH char(20) not null,
MADM char(20) not null,
NGAYQUANLY date,
GHICHU nvarchar(255),
primary key (MANBH, MADM),
foreign key (MANBH) references NHABANHANG(MANBH),
foreign key (MADM) references DANHMUC(MADM))
go

create table SANPHAM ( 
MASP char(20) primary key, 
TENSP nvarchar(100) not null,
MADM char(20),
MOTA text, 
HINHANH varchar(255),
GIAGOC decimal(15,2) not null, 
SLTON int not null default 0, 
foreign key (MADM) references DANHMUC(MADM))
go

create table DANGBAN (
MANBH char(20) not null,
MASP char(20) not null,
TENSP nvarchar(100) not null,
GIABAN decimal(15,2) not null, 
SOLUONG int not null default 0, 
NGAYDANGBAN date,
TRANGTHAI nvarchar(100), 
primary key (MANBH, MASP),
foreign key (MANBH) references NHABANHANG(MANBH),
foreign key (MASP) references SANPHAM(MASP))
go

create table KHACHHANG (
MAKH char(20) primary key,
TENKH nvarchar(100) not null,
EMAIL varchar(100) not null unique,
SDT varchar(20) not null,
DIACHI nvarchar(200),
NGAYDANGKY date not null)
go

create table GIOHANG (  
MAGH char(20) primary key,
MANBH char(20) not null,
MAKH char(20) not null,
foreign key (MANBH) references NHABANHANG(MANBH), 
foreign key (MAKH) references KHACHHANG(MAKH))
go

create table CHITIETGIOHANG (
MAGH char(20) not null,
MASP char(20) not null,
TENSP nvarchar(100) not null,
SOLUONG int not null,
GIABAN decimal(15,2),
primary key (MAGH, MASP),
foreign key (MAGH) references GIOHANG(MAGH),
foreign key (MASP) references SANPHAM(MASP))
go

create table DONHANG ( 
MADH char(20) primary key, 
MAKH char(20) not null,
MAGH char(20),
MANBH char(20),
NGAYDATHANG date,
TONGTIEN decimal(15,2) not null, 
TRANGTHAIGIAOHANG nvarchar(100) default 'Chờ xử lý',
foreign key (MAKH) references KHACHHANG(MAKH),
foreign key (MAGH) references GIOHANG(MAGH),
foreign key (MANBH) references NHABANHANG(MANBH))
go

create table CHITIETDONHANG ( 
MADH char(20) not null,
MASP char(20) not null,
TENSP nvarchar(100) not null,
SOLUONG int not null, 
GIABAN decimal(15,2) not null,
primary key (MADH, MASP),
foreign key (MADH) references DONHANG(MADH), 
foreign key (MASP) references SANPHAM(MASP))
go

create table DANHGIA (
MADG char(20) primary key,
MADH char(20),
foreign key (MADH) references DONHANG(MADH))
go

create table DANHGIACHITIET (
MADG char(20) not null,
MASP char(20) not null,
TENSP nvarchar(100) not null,
NOIDUNG nvarchar(max),
SOSAO int check(SOSAO between 1 and 5),
NGAYDANHGIA date,
PRIMARY KEY (MADG, MASP),
foreign key (MADG) references DANHGIA(MADG),
foreign key (MASP) references SANPHAM(MASP))
go
exec sp_changedbowner 'sa'
-- KHÁCH HÀNG
INSERT INTO KHACHHANG (MAKH, TENKH, EMAIL, SDT, DIACHI, NGAYDANGKY) VALUES
('KH001', N'Nguyễn Văn An', 'nguyenvanan@gmail.com', '0912345678', N'123 Đường Lê Lợi, Q1, TP.HCM', '2023-01-15'),
('KH002', N'Trần Thị Bình', 'tranthibinh@gmail.com', '0987654321', N'456 Đường Nguyễn Huệ, Q1, TP.HCM', '2023-02-20'),
('KH003', N'Lê Hoàng Cường', 'lehoangcuong@gmail.com', '0905123456', N'789 Đường CMT8, Q3, TP.HCM', '2023-03-10'),
('KH004', N'Phạm Thị Dung', 'phamthidung@gmail.com', '0978123456', N'321 Đường Lý Tự Trọng, Q1, TP.HCM', '2023-04-05'),
('KH005', N'Vũ Minh Đức', 'vuminhduc@gmail.com', '0918765432', N'654 Đường Pasteur, Q3, TP.HCM', '2023-05-12')
go
-- NHÀ BÁN HÀNG
INSERT INTO NHABANHANG (MANBH, TENNBH, EMAIL, SDT, DIACHI, NGAYDANGKY) VALUES
('NB001', N'Cửa hàng điện máy Xanh', 'dienmayxanh@gmail.com', '18001061', N'111 Đường 3/2, Q10, TP.HCM', '2022-11-01'),
('NB002', N'Thế giới di động', 'thegioididong@gmail.com', '18001080', N'222 Đường Lê Văn Việt, Q9, TP.HCM', '2022-10-15'),
('NB003', N'Shop thời trang YAME', 'yamefashion@gmail.com', '19001560', N'333 Đường Lê Lai, Q1, TP.HCM', '2023-01-10'),
('NB004', N'Nhà sách Fahasa', 'fahasa@gmail.com', '19005454', N'444 Đường Nguyễn Văn Cừ, Q5, TP.HCM', '2022-12-05'),
('NB005', N'Siêu thị Coopmart', 'coopmart@gmail.com', '19002239', N'555 Đường Lê Văn Sỹ, Q3, TP.HCM', '2022-09-20')
go
-- DANH MỤC
INSERT INTO DANHMUC (MADM, TENDM) VALUES
('DM001', N'Điện thoại di động'),
('DM002', N'Laptop'),
('DM003', N'Thời trang nam'),
('DM004', N'Thời trang nữ'),
('DM005', N'Sách văn học')
go
--QUẢN LÝ
INSERT INTO QUANLY (MANBH, MADM, NGAYQUANLY, GHICHU) VALUES
('NB001', 'DM001', '2022-11-02', N'Quản lý mặt hàng điện thoại'),
('NB002', 'DM002', '2022-10-16', N'Chuyên mục laptop'),
('NB003', 'DM003', '2023-01-11', N'Thời trang nam cao cấp'),
('NB003', 'DM004', '2023-01-11', N'Thời trang nữ'),
('NB004', 'DM005', '2022-12-06', N'Sách văn học nổi bật')
go
-- SẢN PHẨM
INSERT INTO SANPHAM (MASP, TENSP,  MADM, MOTA, GIAGOC, SLTON, HINHANH) VALUES
('SP001', 'iPhone 14 Pro Max', 'DM001', 'iPhone 14 Pro Max 128GB', 29990000, 50,  null),
('SP002', 'MacBook Air M2', 'DM002', 'MacBook Air M2 2023 8GB/256GB', 28990000, 30, null),
('SP003', N'Áo sơ mi nam trắng', 'DM003', N'Áo sơ mi công sở cao cấp', 350000, 100, null),
('SP004', N'Váy liền công sở', 'DM004', N'Váy liền nữ công sở dáng dài', 450000, 80, null),
('SP005', N'Tiếng chim hót trong bụi mận gai', 'DM005', N'Sách tiếng Việt, bản dịch của Phạm Mạnh Hùng', 120000, 200, null)
go
-- ĐĂNG BÁN
INSERT INTO DANGBAN (MANBH, MASP, TENSP, GIABAN, SOLUONG, NGAYDANGBAN, TRANGTHAI) VALUES
('NB001', 'SP001', 'iPhone 14 Pro Max', 29990000, 50, '2023-01-01', N'Đang bán'),
('NB002', 'SP002', 'MacBook Air M2', 28990000, 30, '2023-01-02', N'Đang bán'),
('NB003', 'SP003', N'Áo sơ mi nam trắng', 350000, 100, '2023-01-03', N'Đang bán'),
('NB003', 'SP004', N'Váy liền công sở', 450000, 80, '2023-01-04', N'Đang bán'),
('NB004', 'SP005', N'Tiếng chim hót trong bụi mận gai', 120000, 200, '2023-01-05', N'Đang bán')
go
-- GIỎ HÀNG
INSERT INTO GIOHANG (MAGH, MANBH, MAKH) VALUES
('GH001', 'NB002', 'KH001'),
('GH002', 'NB003', 'KH002'),
('GH003', 'NB003', 'KH003'),
('GH004', 'NB004', 'KH004'),
('GH005', 'NB001', 'KH005')
go
-- CHI TIẾT GIỎ HÀNG
INSERT INTO CHITIETGIOHANG (MAGH, MASP, TENSP, SOLUONG, GIABAN) VALUES
('GH001', 'SP002', 'MacBook Air M2', 1, 28990000),
('GH002', 'SP003', N'Áo sơ mi nam trắng', 2, 350000),
('GH003', 'SP004', N'Váy liền công sở', 1, 450000),
('GH004', 'SP005', N'Tiếng chim hót trong bụi mận gai', 3, 120000),
('GH005', 'SP001', 'iPhone 14 Pro Max', 1, 29990000)
go
-- ĐƠN HÀNG
INSERT INTO DONHANG (MADH, MAKH, MAGH, MANBH, NGAYDATHANG, TONGTIEN, TRANGTHAIGIAOHANG) VALUES
('DH001', 'KH001', 'GH001', 'NB002', '2023-06-01', 29990000, N'Đã giao'),
('DH002', 'KH002', 'GH002', 'NB003', '2023-06-05', 28990000, N'Đang vận chuyển'),
('DH003', 'KH003', 'GH003', 'NB003', '2023-06-10', 700000, N'Chờ xử lý'),
('DH004', 'KH004', 'GH004', 'NB004', '2023-06-15', 570000, N'Đã giao'),
('DH005', 'KH005', 'GH005', 'NB001', '2023-06-20', 120000, N'Đã giao')
go
-- CHI TIẾT ĐƠN HÀNG
INSERT INTO CHITIETDONHANG (MADH, MASP, TENSP, SOLUONG, GIABAN) VALUES
('DH001', 'SP001', 'iPhone 14 Pro Max', 1, 29990000),
('DH002', 'SP002', 'MacBook Air M2', 1, 28990000),
('DH003', 'SP003', N'Áo sơ mi nam trắng', 2, 350000),
('DH004', 'SP003', N'Áo sơ mi nam trắng', 1, 350000),
('DH004', 'SP004',  N'Váy liền công sở', 1, 450000),
('DH005', 'SP005', N'Tiếng chim hót trong bụi mận gai', 1, 120000)
go
-- ĐÁNH GIÁ
INSERT INTO DANHGIA (MADG, MADH) VALUES
('DG001', 'DH001'),
('DG002', 'DH002'),
('DG003', 'DH003'),
('DG004', 'DH004'),
('DG005', 'DH005')
go
-- CHI TIẾT ĐÁNH GIÁ
INSERT INTO DANHGIACHITIET (MADG, MASP, TENSP, NOIDUNG, SOSAO, NGAYDANHGIA) VALUES
('DG001', 'SP001', 'iPhone 14 Pro Max', N'Sản phẩm tuyệt vời, giao hàng nhanh', 5, '2023-06-03'),
('DG002', 'SP002', 'MacBook Air M2', N'Máy chạy mượt, pin trâu', 4, '2023-06-08'),
('DG003', 'SP003', N'Áo sơ mi nam trắng', N'Áo đẹp nhưng hơi mỏng', 3, '2023-06-12'),
('DG004', 'SP004', N'Váy liền công sở', N'Váy vừa vặn, chất liệu tốt', 5, '2023-06-18'),
('DG005', 'SP005', N'Tiếng chim hót trong bụi mận gai', N'Sách hay, nội dung cảm động', 5, '2023-06-22')
go


-----12 câu truy vấn nhóm-------------
---1.4.1. Truy vấn dữ liệu (SELECT)
--1.4.1.3. Liệt kê danh sách đơn hàng, tên khách hàng, tổng tiền, và số lượng sản phẩm trong đơn hàng.
SELECT DONHANG.MADH, KHACHHANG.TENKH, DONHANG.TONGTIEN, 
SUM(CHITIETDONHANG.SOLUONG) AS TONGSOLUONGSANPHAM 
FROM DONHANG 
JOIN KHACHHANG ON DONHANG.MAKH = KHACHHANG.MAKH 
JOIN CHITIETDONHANG ON DONHANG.MADH = CHITIETDONHANG.MADH 
GROUP BY DONHANG.MADH, KHACHHANG.TENKH, DONHANG.TONGTIEN
--kết quả: 5
--1.4.1.4. Danh sách đơn hàng kèm theo tên sản phẩm, chỉ hiển thị nếu đơn hàng có tổng tiền > trung bình toàn bộ đơn hàng.
SELECT DONHANG.MADH, CHITIETDONHANG.TENSP, CHITIETDONHANG.SOLUONG, 
DONHANG.TONGTIEN 
FROM DONHANG 
JOIN CHITIETDONHANG ON DONHANG.MADH = CHITIETDONHANG.MADH  
WHERE DONHANG.TONGTIEN > (SELECT AVG(TONGTIEN) FROM DONHANG)
--kết quả: 2
--1.4.2. Câu lệnh cập nhật (UPDATE)
--1.4.2.1. Cập nhật số lượng tồn kho của sản phẩm trong đơn hàng mã 'DH003'.
UPDATE SP  
SET SP.SLTON = SP.SLTON - CT.SOLUONG  
FROM SANPHAM SP  
JOIN CHITIETDONHANG CT ON SP.MASP = CT.MASP  
WHERE CT.MADH = 'DH003'
SELECT SP.MASP, SP.TENSP, SP.SLTON  
FROM SANPHAM SP  
JOIN CHITIETDONHANG CT ON SP.MASP = CT.MASP   
WHERE CT.MADH = 'DH003'
--kết quả: 1
--1.4.2.2. Cập nhật trạng thái giao hàng của các đơn hàng thành 'Đã giao' nếu tất cả sản phẩm trong đơn hàng đó đã được khách hàng đánh giá.
UPDATE DH
SET DH.TRANGTHAIGIAOHANG = N'Đã giao'
FROM DONHANG DH
WHERE NOT EXISTS (
    SELECT *
    FROM CHITIETDONHANG CTDH
    WHERE CTDH.MADH = DH.MADH
    AND NOT EXISTS (
        SELECT *
        FROM DANHGIA DG
        JOIN DANHGIACHITIET DGCT ON DG.MADG = DGCT.MADG
        WHERE DG.MADH = DH.MADH  -- nối qua MADH thay vì MAKH
        AND DGCT.MASP = CTDH.MASP ))
--1.4.2.4. Tăng giá 5% cho sản phẩm có doanh thu thấp nhất (dựa trên tổng số lượng bán).
UPDATE SANPHAM 
SET GIAGOC = GIAGOC * 1.05 
WHERE MASP IN ( 
SELECT TOP 1 MASP 
FROM CHITIETDONHANG 
GROUP BY MASP 
ORDER BY SUM(SOLUONG) ASC)
---1.4.3. Câu lệnh xóa (DELETE)
--1.4.3.1. Xóa đánh giá của khách hàng có mã 'KH003' đối với sản phẩm có mã 'SP003'.
DELETE DGCT
FROM DANHGIACHITIET DGCT
JOIN DANHGIA DG ON DGCT.MADG = DG.MADG
JOIN DONHANG DH ON DG.MADH = DH.MADH
WHERE DH.MAKH = 'KH003' AND DGCT.MASP = 'SP003'
--1.4.3.2. Xóa các đơn hàng đã tạo trước năm 2020 và chưa có sản phẩm nào trong CHITIETDONHANG.
DELETE FROM DONHANG 
WHERE MADH NOT IN (SELECT DISTINCT MADH FROM CHITIETDONHANG) 
AND YEAR(NGAYDATHANG) < 2020
--1.4.3.3. Xoá sản phẩm không có đơn hàng nào trong vòng 2 năm qua.
DELETE FROM SANPHAM 
WHERE MASP NOT IN ( 
SELECT DISTINCT MASP 
FROM CHITIETDONHANG OD 
JOIN DONHANG O ON OD.MADH = O.MADH 
WHERE O.NGAYDATHANG >= DATEADD(YEAR, -2, GETDATE()))
---1.4.4. Truy vấn nhóm (GROUP BY)
--1.4.4.1. Thống kê số lượng đơn hàng và tổng tiền theo từng khách hàng, phân loại theo trạng thái giao hàng.
SELECT 
    KH.MAKH,
    KH.TENKH,
    DH.TRANGTHAIGIAOHANG,
    COUNT(DH.MADH) AS SoDonHang,
    SUM(DH.TONGTIEN) AS TongChiTieu
FROM KHACHHANG KH
JOIN DONHANG DH ON KH.MAKH = DH.MAKH
GROUP BY KH.MAKH, KH.TENKH, DH.TRANGTHAIGIAOHANG
--kết quả: 5
--1.4.4.2. Thống kê đánh giá sản phẩm theo số sao (1–5), hiển thị tổng số đánh giá và trung bình số sao theo từng sản phẩm.
SELECT 
    SP.MASP,
    SP.TENSP,
    COUNT(DGC.SOSAO) AS SoLuotDanhGia,
    AVG(DGC.SOSAO * 1.0) AS TrungBinhSoSao
FROM SANPHAM SP
JOIN DANHGIACHITIET DGC ON SP.MASP = DGC.MASP
GROUP BY SP.MASP, SP.TENSP
ORDER BY TrungBinhSoSao DESC
--kết quả: 4
--1.4.4.3. Liệt kê tên sản phẩm và tổng số lượng bán được của từng sản phẩm trong năm 2023.
SELECT SP.TENSP, SUM(CT.SOLUONG) AS TONGSOLUONGBAN 
FROM SANPHAM SP 
JOIN CHITIETDONHANG CT ON SP.MASP = CT.MASP 
JOIN DONHANG DH ON CT.MADH = DH.MADH 
WHERE YEAR(DH.NGAYDATHANG) = 2023 
GROUP BY SP.TENSP, SP.MASP
--kết quả: 5
--1.4.4.4. Tính tổng doanh thu theo danh mục sản phẩm và chỉ hiển thị nếu doanh thu > 1000000.
SELECT SP.MADM, SUM(CT.SOLUONG * CT.GIABAN) AS DOANHTHU 
FROM CHITIETDONHANG CT 
JOIN SANPHAM SP ON CT.MASP = SP.MASP 
GROUP BY SP.MADM 
HAVING SUM(CT.SOLUONG * CT.GIABAN) > 1000000
--kết quả: 3
--BÀI CÁ NHÂN
--1.Dương Hồ Mỹ Quyên
--1. Tìm tên khách hàng đã đánh giá tất cả các sản phẩm thuộc danh mục "Thời trang nữ"
SELECT KH.TENKH
FROM KHACHHANG KH
WHERE NOT EXISTS (
    SELECT MASP 
    FROM SANPHAM 
    WHERE MADM = 'DM004'
    EXCEPT
    SELECT DGC.MASP 
    FROM DANHGIACHITIET DGC
    JOIN DANHGIA DG ON DGC.MADG = DG.MADG
    JOIN DONHANG DH ON DG.MADH = DH.MADH
    WHERE DH.MAKH = KH.MAKH)
--kết quả: 1
--2. Tìm sản phẩm có điểm đánh giá cao nhất so với trung bình tất cả sản phẩm
SELECT MASP,
    (SELECT TENSP FROM SANPHAM WHERE MASP = DGC.MASP) AS TENSP,
    AVG(SOSAO) AS DiemTrungBinh
FROM DANHGIACHITIET DGC
GROUP BY MASP
HAVING AVG(SOSAO) > (
    SELECT AVG(SOSAO) FROM DANHGIACHITIET)
--kết quả: 3
--3. Thống kê số lượng đánh giá của từng sản phẩm trong tháng 6/2023, phân loại theo mức độ đánh giá 
--(đánh giá từ 1-2 sao là "Kém", từ 3-4 sao là "Trung Bình", 5 sao là "Tốt")
SELECT MASP,
       COUNT(CASE WHEN SOSAO BETWEEN 1 AND 2 THEN 1 END) AS SoDanhGiaKem,
       COUNT(CASE WHEN SOSAO BETWEEN 3 AND 4 THEN 1 END) AS SoDanhGiaTrungBinh,
       COUNT(CASE WHEN SOSAO = 5 THEN 1 END) AS SoDanhGiaTot
FROM DANHGIACHITIET
WHERE MONTH(NGAYDANHGIA) = 6 AND YEAR(NGAYDANHGIA) = 2023
GROUP BY MASP
--Kết quả: 4
--4. Thống kê số tiền khách hàng đã chi tiêu cho từng nhà bán hàng, chỉ tính các đơn hàng đã giao, phân theo loại đơn hàng: 
--lớn hay nhỏ (tổng tiền >= 1 triệu là "Lớn", còn lại là "Nhỏ")
SELECT MAKH,
       MANBH,
       SUM(TONGTIEN) AS TongChiTieu,
       CASE 
           WHEN SUM(TONGTIEN) >= 1000000 THEN N'Đơn hàng lớn'
           ELSE N'Đơn hàng nhỏ'
       END AS LoaiDonHang
FROM DONHANG
WHERE TRANGTHAIGIAOHANG = N'Đã giao'
GROUP BY MAKH, MANBH
--Kết quả: 5
--5. Thống kê số lượng khách hàng đã đánh giá toàn bộ sản phẩm mà họ đã mua
SELECT MAKH
FROM DONHANG
WHERE MAKH IN (
    SELECT MAKH
    FROM DONHANG D
    WHERE NOT EXISTS (
        SELECT *
        FROM CHITIETDONHANG CT
        WHERE CT.MADH = D.MADH
        AND NOT EXISTS (
            SELECT *
            FROM DANHGIA DG
            JOIN DANHGIACHITIET CTDG ON DG.MADG = CTDG.MADG
            WHERE DG.MADH = CT.MADH AND CTDG.MASP = CT.MASP)))
			GROUP BY MAKH
--Kết quả: 3
--2.Lê Thị Mỹ Duyên
--Câu 1: Tìm tên khách hàng đã mua tất cả sản phẩm thuộc danh mục "Phụ kiện"
SELECT TENKH
FROM KHACHHANG KH
WHERE NOT EXISTS (
    SELECT MASP
    FROM SANPHAM
    WHERE MADM = 'DM005'
    EXCEPT
    SELECT MASP
    FROM CHITIETDONHANG CT
    JOIN DONHANG DH ON CT.MADH = DH.MADH
    WHERE DH.MAKH = KH.MAKH)
--Kết quả : 1
--Câu 2: Tìm nhà bán hàng có trung bình điểm đánh giá cao nhất trong năm 2023
SELECT TOP 1 MANBH, AVG(CT.SOSAO) AS DiemTrungBinh
FROM DANHGIACHITIET CT
JOIN DANHGIA DG ON CT.MADG = DG.MADG
JOIN DONHANG DH ON DG.MADH = DH.MADH
WHERE YEAR(CT.NGAYDANHGIA) = 2023
GROUP BY MANBH
ORDER BY AVG(CT.SOSAO) DESC
--Kết quả : 1
--3. Thống kê số lượt đánh giá theo mức độ trong tháng 6/2023
SELECT MASP,
       COUNT(CASE WHEN SOSAO BETWEEN 1 AND 2 THEN 1 END) AS Kem,
       COUNT(CASE WHEN SOSAO BETWEEN 3 AND 4 THEN 1 END) AS TrungBinh,
       COUNT(CASE WHEN SOSAO = 5 THEN 1 END) AS Tot
FROM DANHGIACHITIET
WHERE MONTH(NGAYDANHGIA) = 6 AND YEAR(NGAYDANHGIA) = 2023
GROUP BY MASP
--Kết quả : 5
--4. Thống kê tổng tiền khách hàng chi theo nhà bán hàng (chỉ đơn đã giao)
SELECT MAKH, MANBH, SUM(TONGTIEN) AS TongTien,
       CASE WHEN SUM(TONGTIEN) >= 1000000 THEN N'Lớn' ELSE N'Nhỏ' END AS Loai
FROM DONHANG
WHERE TRANGTHAIGIAOHANG = N'Đã giao'
GROUP BY MAKH, MANBH
--Kết quả : 3
--5. Tìm khách hàng đã đánh giá toàn bộ sản phẩm họ đã mua
SELECT DISTINCT D.MAKH
FROM DONHANG D
WHERE NOT EXISTS (
    SELECT *
    FROM CHITIETDONHANG CT
    WHERE CT.MADH = D.MADH
    AND NOT EXISTS (
        SELECT 1
        FROM DANHGIA DG
        JOIN DANHGIACHITIET CTDG ON DG.MADG = CTDG.MADG
        WHERE DG.MADH = CT.MADH AND CTDG.MASP = CT.MASP))
--Kết quả : 4

--3.Lê Phạm Như Ý 
--Lấy tên khách hàng, tên sản phẩm, số sao đánh giá, ngày đánh giá – nhưng chỉ hiển thị những đánh giá từ 4 sao trở lên
 SELECT 
    KHACHHANG.TENKH,
    SANPHAM.TENSP,
    DANHGIACHITIET.SOSAO,
    DANHGIACHITIET.NGAYDANHGIA
FROM KHACHHANG, DONHANG, DANHGIA, DANHGIACHITIET, SANPHAM
WHERE KHACHHANG.MAKH = DONHANG.MAKH
  AND DONHANG.MADH = DANHGIA.MADH
  AND DANHGIA.MADG = DANHGIACHITIET.MADG
  AND DANHGIACHITIET.MASP = SANPHAM.MASP
  AND DANHGIACHITIET.SOSAO >= 4
--kết quả: 4
--Tìm tên khách hàng đã mua sản phẩm có GIÁ CAO NHẤT trong hệ thống
  SELECT DISTINCT KHACHHANG.TENKH
FROM KHACHHANG, DONHANG, CHITIETDONHANG
WHERE KHACHHANG.MAKH = DONHANG.MAKH
  AND DONHANG.MADH = CHITIETDONHANG.MADH
  AND CHITIETDONHANG.MASP = (
      SELECT MASP
      FROM SANPHAM
      WHERE GIAGOC = (
          SELECT MAX(GIAGOC)
          FROM SANPHAM))
--kết quả: 1
--Lấy danh sách nhà bán hàng có tổng giá trị đơn hàng từ 20 triệu trở lên
SELECT 
    NHABANHANG.TENNBH,
    SUM(DONHANG.TONGTIEN) AS TongGiaTriBan
FROM NHABANHANG, DONHANG
WHERE NHABANHANG.MANBH = DONHANG.MANBH
GROUP BY NHABANHANG.TENNBH
HAVING SUM(DONHANG.TONGTIEN) >= 20000000
--kết quả: 2
--thống kê: Doanh thu và đơn hàng theo nhà bán hàng
SELECT 
    NHABANHANG.TENNBH,
    COUNT(DONHANG.MADH) AS SoDonHang,
    SUM(DONHANG.TONGTIEN) AS TongDoanhThu,
    SUM(CHITIETDONHANG.SOLUONG) AS TongSanPhamBan
FROM NHABANHANG, DONHANG, CHITIETDONHANG
WHERE NHABANHANG.MANBH = DONHANG.MANBH
  AND DONHANG.MADH = CHITIETDONHANG.MADH
GROUP BY NHABANHANG.TENNBH
--kết quả: 4
--phân loại các sản phẩm trong cửa hàng theo mức giá thành 3 nhóm: Cao cấp, Tầm trung, và Bình dân dựa vào giá gốc
SELECT 
    TENSP,
    GIAGOC,
    CASE 
        WHEN GIAGOC >= 20000000 THEN N'Cao cấp'
        WHEN GIAGOC BETWEEN 10000000 AND 19999999 THEN N'Tầm trung'
        ELSE N'Bình dân'
    END AS PHAN_LOAI
FROM SANPHAM
--kết quả: 5

--4.Phạm Ngọc Khánh Băng
--1. Liệt kê danh sách khách hàng chưa từng mua sản phẩm nào có giá dưới 500,000 VNĐ.
SELECT KH.MAKH, KH.TENKH
FROM KHACHHANG KH
WHERE KH.MAKH NOT IN (
    SELECT DISTINCT MAKH
    FROM DONHANG DH, CHITIETDONHANG DHCT
    WHERE DH.MADH = DHCT.MADH
    AND DHCT.GIABAN < 500000)
--kết quả: 2
--2. Liệt kê các đơn hàng có giá trị lớn hơn mức trung bình của đơn hàng cùng nhà bán hàng nhưng chưa được giao.
SELECT MADH, MAKH, TONGTIEN, MANBH
FROM DONHANG DH
WHERE DH.TONGTIEN > ( SELECT AVG(TONGTIEN)
						FROM DONHANG 
						WHERE MANBH = DH.MANBH) 
						AND DH.TRANGTHAIGIAOHANG NOT IN (N'Đã giao')
--kết quả: 1
--3. Liệt kê các sản phẩm có mặt trong ít nhất 2 đơn hàng khác nhau và tổng số lượng đã bán của mỗi sản phẩm.
SELECT SP.TENSP, COUNT(DISTINCT DHCT.MADH) AS SoDonHangXuatHien, SUM(DHCT.SOLUONG) AS TongSoLuongBan
FROM SANPHAM SP, CHITIETDONHANG DHCT
WHERE SP.MASP = DHCT.MASP
GROUP BY SP.TENSP
HAVING COUNT(DISTINCT DHCT.MADH) >= 2
--kết quả: 1
--4. Liệt kê khách hàng có đơn hàng chứa ít nhất một sản phẩm có đánh giá trung bình dưới 4 sao.
SELECT KH.TENKH, KH.EMAIL, KH.SDT,DGCT.SOSAO
FROM KHACHHANG KH, DONHANG DH, CHITIETDONHANG DHCT, DANHGIACHITIET DGCT
WHERE KH.MAKH = DH.MAKH
AND DH.MADH = DHCT.MADH
AND DHCT.MASP = DGCT.MASP
AND DHCT.MASP IN (
    SELECT MASP 
    FROM DANHGIACHITIET 
    GROUP BY MASP 
    HAVING AVG(SOSAO) < 4)
--kết quả: 2
--5. Danh sách nhà bán hàng có doanh thu từ sản phẩm đã bán thấp hơn doanh thu trung bình của tất cả nhà bán hàng.
SELECT NBH.MANBH, NBH.TENNBH, SUM(DH.TONGTIEN) AS DoanhThu
FROM NHABANHANG NBH, DONHANG DH
WHERE NBH.MANBH = DH.MANBH
GROUP BY NBH.MANBH, NBH.TENNBH
HAVING SUM(DH.TONGTIEN) < (
    SELECT AVG(DoanhThu)
    FROM (
        SELECT MANBH, SUM(TONGTIEN) AS DoanhThu
        FROM DONHANG
        GROUP BY MANBH
    ) AS TrungBinhDoanhThu)
--kết quả: 2

--5.Phạm Thị Hồng Nhung
--1. Truy vấn kết nối nhiều bảng: Liệt kê danh sách sản phẩm, nhà bán hàng, số đơn hàng đã bán và tổng số lượng sản phẩm bán ra trong năm 2023. Chỉ hiện những nhà bán hàng có sản phẩm bán được ít nhất 2 đơn và trạng thái giao hàng là ‘đã giao’.
SELECT SP.TENSP, SP.MASP, NBH.TENNBH, NBH.MANBH, COUNT(DISTINCT DH.MADH) AS SoDonHang, SUM(CT.SOLUONG) AS TongSoLuongBanRa
FROM SANPHAM SP
JOIN CHITIETDONHANG CT ON SP.MASP = CT.MASP
JOIN DONHANG DH ON CT.MADH = DH.MADH
JOIN NHABANHANG NBH ON DH.MANBH = NBH.MANBH
WHERE YEAR(DH.NGAYDATHANG) = 2023 AND DH.TRANGTHAIGIAOHANG = N'Đã giao'
AND NBH.MANBH IN ( SELECT DISTINCT DH2.MANBH
    FROM DONHANG DH2
    JOIN CHITIETDONHANG CT2 ON DH2.MADH = CT2.MADH
    WHERE YEAR(DH2.NGAYDATHANG) = 2023
    AND DH2.TRANGTHAIGIAOHANG = N'Đã giao'
    GROUP BY DH2.MANBH, CT2.MASP
    HAVING COUNT(DISTINCT DH2.MADH) >= 2 )
GROUP BY SP.MASP, SP.TENSP, NBH.MANBH, NBH.TENNBH
HAVING COUNT(DISTINCT DH.MADH) >= 2
 
--Kết quả: 0

--2. Tìm khách hàng chưa từng viết đánh giá
SELECT KH.TENKH, KH.MAKH, KH.SDT
FROM KHACHHANG KH
WHERE NOT EXISTS ( SELECT 1 FROM DONHANG DH
JOIN DANHGIA DG ON DH.MADH = DG.MADH
WHERE DH.MAKH = KH.MAKH )
 
--Kết quả: 0

--3. Liệt kê các nhà bán hàng chưa từng có đơn hàng nào.
SELECT NBH.MANBH, NBH.TENNBH
FROM NHABANHANG NBH
WHERE NOT EXISTS ( SELECT 1 FROM DONHANG DH
WHERE DH.MANBH = NBH.MANBH )
  
--Kết quả: 1

--4. Câu lệnh GROUP BY: Liệt kê các khách hàng đã mua tổng giá trị đơn hàng trên 10 triệu.
SELECT KH.TENKH, KH.MAKH, SUM(DH.TONGTIEN) AS TongTienDaMua
FROM KHACHHANG KH
JOIN DONHANG DH ON KH.MAKH = DH.MAKH
GROUP BY KH.TENKH, KH.MAKH
HAVING SUM(DH.TONGTIEN) > 10000000
 
--Kết quả: 2

--5. Truy vấn con (SUBQUERY): Liệt kê tên sản phẩm được khách hàng "Nguyễn Văn An" đánh giá 5 sao.
SELECT DISTINCT SP.TENSP 
FROM SANPHAM SP
WHERE EXISTS ( SELECT 1
FROM DANHGIACHITIET DGCT
JOIN DANHGIA DG ON DGCT.MADG = DG.MADG
    JOIN DONHANG DH ON DG.MADH = DH.MADH
    JOIN KHACHHANG KH ON DH.MAKH = KH.MAKH
    WHERE DGCT.MASP = SP.MASP AND KH.TENKH = N'Nguyễn Văn An' 
    AND DGCT.SOSAO = 5 )
 
--Kết quả: 1


--6.Lê Trần Bảo An
--1. Liệt kê các đơn hàng có trạng thái giao hàng là "Đã giao", gồm: mã đơn hàng, tên khách hàng, tên sản phẩm, số lượng, giá bán, tổng tiền (Số lượng * Giá bán), ngày đặt hàng.
SELECT DH.MADH, KH.TENKH, SP.TENSP, CT.SOLUONG, CT.GIABAN, (CT.SOLUONG * CT.GIABAN) AS TONGTIENSP, DH.NGAYDATHANG
FROM DONHANG DH
JOIN KHACHHANG KH ON DH.MAKH = KH.MAKH
JOIN CHITIETDONHANG CT ON DH.MADH = CT.MADH
JOIN SANPHAM SP ON CT.MASP = SP.MASP
WHERE DH.TRANGTHAIGIAOHANG = N'Đã giao'
ORDER BY DH.NGAYDATHANG
--Kết quả: 4
--2. Tìm các nhà bán hàng có trung bình số sao đánh giá của các sản phẩm từ 4 trở lên, đồng thời phải có ít nhất 2 sản phẩm được đánh giá.
SELECT NB.TENNBH, AVG(DGCT.SOSAO) AS SAOTB, COUNT(DISTINCT DGCT.MASP) AS SLDG
FROM NHABANHANG NB
JOIN DANGBAN DB ON NB.MANBH = DB.MANBH
JOIN DANHGIACHITIET DGCT ON DB.MASP = DGCT.MASP
GROUP BY NB.TENNBH
HAVING AVG(DGCT.SOSAO) >= 4 AND COUNT(DISTINCT DGCT.MASP) >= 2
--Kết quả: 1
--3. Tìm tên sản phẩm có số lượng tồn kho nhiều hơn tất cả các sản phẩm thuộc danh mục "Điện thoại di động".
SELECT TENSP
FROM SANPHAM
WHERE SLTON > ALL (
    SELECT SLTON
    FROM SANPHAM
    WHERE MADM = 'DM001')
--Kết quả: 3
--4. Xóa các đánh giá chi tiết (DANHGIACHITIET) cho những sản phẩm có điểm đánh giá trung bình dưới 3 sao.
DELETE 
FROM DANHGIACHITIET
WHERE MASP IN (
    SELECT MASP FROM (
        SELECT MASP
        FROM DANHGIACHITIET
        GROUP BY MASP
        HAVING AVG(SOSAO) < 3
    ) AS DG_TB
)

--5. Cập nhật TONGTIEN trong bảng DONHANG theo đúng tổng giá bán thực tế từ bảng CHITIETDONHANG
UPDATE DONHANG
SET TONGTIEN = (
    SELECT SUM(SOLUONG * GIABAN)
    FROM CHITIETDONHANG CT
 WHERE CT.MADH = DONHANG.MADH)

 --5 câu cá nhân: Lê Phạm Như Ý 
 --Lấy tên khách hàng, tên sản phẩm, số sao đánh giá, ngày đánh giá – chỉ từ 4 sao trở lên
 SELECT 
    KH.TENKH,
    SP.TENSP,
    DGCT.SOSAO,
    DGCT.NGAYDANHGIA
FROM KHACHHANG KH
JOIN DONHANG DH ON KH.MAKH = DH.MAKH
JOIN DANHGIA DG ON DH.MADH = DG.MADH
JOIN DANHGIACHITIET DGCT ON DG.MADG = DGCT.MADG
JOIN SANPHAM SP ON DGCT.MASP = SP.MASP
WHERE DGCT.SOSAO >= 4
-- Tìm tên khách hàng đã mua sản phẩm có giá gốc cao nhất
SELECT DISTINCT KH.TENKH
FROM KHACHHANG KH
JOIN DONHANG DH ON KH.MAKH = DH.MAKH
JOIN CHITIETDONHANG CTDH ON DH.MADH = CTDH.MADH
WHERE CTDH.MASP = (
    SELECT MASP
    FROM SANPHAM
    WHERE GIAGOC = (
        SELECT MAX(GIAGOC) FROM SANPHAM))
--Lấy danh sách nhà bán hàng có tổng giá trị đơn hàng từ 20 triệu trở lên
SELECT 
    NBH.TENNBH,
    SUM(DH.TONGTIEN) AS TongGiaTriBan
FROM NHABANHANG NBH
JOIN DONHANG DH ON NBH.MANBH = DH.MANBH
GROUP BY NBH.TENNBH
HAVING SUM(DH.TONGTIEN) >= 20000000
--Thống kê doanh thu và số đơn hàng theo nhà bán hàng
SELECT 
    NBH.TENNBH,
    COUNT(DISTINCT DH.MADH) AS SoDonHang,
    SUM(DH.TONGTIEN) AS TongDoanhThu,
    SUM(CTDH.SOLUONG) AS TongSanPhamBan
FROM NHABANHANG NBH
JOIN DONHANG DH ON NBH.MANBH = DH.MANBH
JOIN CHITIETDONHANG CTDH ON DH.MADH = CTDH.MADH
GROUP BY NBH.TENNBH
--Phân loại sản phẩm theo mức giá: Cao cấp, Tầm trung, Bình dân
SELECT 
    TENSP,
    GIAGOC,
    CASE 
        WHEN GIAGOC >= 20000000 THEN N'Cao cấp'
        WHEN GIAGOC BETWEEN 10000000 AND 19999999 THEN N'Tầm trung'
        ELSE N'Bình dân'
    END AS PHAN_LOAI
FROM SANPHAM






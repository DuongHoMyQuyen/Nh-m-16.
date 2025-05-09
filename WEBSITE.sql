create database Website_tmdt
use Website_tmdt
go
create table KHACHHANG (
MAKH char(20) primary key,
TENKH nvarchar(100) not null,
EMAIL varchar(100) not null unique,
SDT varchar(20) not null,
DIACHI nvarchar(200),
NGAYDANGKY date not null)
go
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
create table SANPHAM( 
MASP char(20) primary key, 
TENSP nvarchar(100) not null,
MANBH char(20) not null,
MADM char(20),
MOTA text, 
HINHANH varchar(255),
GIAGOC decimal(15,2) not null, 
SLTON int not null default 0,
foreign key (MANBH) references NHABANHANG(MANBH), 
foreign key (MADM) references DANHMUC(MADM))
go
create table DONHANG ( 
MADH char(20) primary key, 
MAKH char(20) not null,
NGAYDATHANG date,
TONGTIEN decimal(15,2) not null, 
TRANGTHAIGIAOHANG nvarchar(100) default 'Chờ xử lý',
foreign key (MAKH) references KHACHHANG(MAKH))
go
create table CHITIETDONHANG ( 
MADH char(20) not null,
MASP char(20) not null,
SOLUONG int not null, 
GIABAN decimal(15,2) not null,
primary key (MADH, MASP),
foreign key (MADH) references DONHANG(MADH), 
foreign key (MASP) references SANPHAM(MASP))
go
create table GIOHANG ( 
MAGH char(20) primary key, 
MAKH char(20) not null,
MASP char(20) not null,
SOLUONG int not null default 1,
foreign key (MAKH) references KHACHHANG(MAKH), 
foreign key (MASP) references SANPHAM(MASP))
go
create table DANHGIA (
MAKH char(20) not null,
MASP char(20) not null,
NOIDUNG nvarchar(max),
SOSAO int not null check(SOSAO between 1 and 5), 
NGAYDANHGIA date,
primary key (MAKH, MASP),
foreign key (MAKH) references KHACHHANG(MAKH), 
foreign key (MASP) references SANPHAM(MASP))
go
exec sp_changedbowner 'sa'
go
INSERT INTO KHACHHANG (MAKH, TENKH, EMAIL, SDT, DIACHI, NGAYDANGKY) VALUES
('KH001', N'Nguyễn Văn An', 'nguyenvanan@gmail.com', '0912345678', N'123 Đường Lê Lợi, Q1, TP.HCM', '2023-01-15'),
('KH002', N'Trần Thị Bình', 'tranthibinh@gmail.com', '0987654321', N'456 Đường Nguyễn Huệ, Q1, TP.HCM', '2023-02-20'),
('KH003', N'Lê Hoàng Cường', 'lehoangcuong@gmail.com', '0905123456', N'789 Đường CMT8, Q3, TP.HCM', '2023-03-10'),
('KH004', N'Phạm Thị Dung', 'phamthidung@gmail.com', '0978123456', N'321 Đường Lý Tự Trọng, Q1, TP.HCM', '2023-04-05'),
('KH005', N'Vũ Minh Đức', 'vuminhduc@gmail.com', '0918765432', N'654 Đường Pasteur, Q3, TP.HCM', '2023-05-12')
go
INSERT INTO NHABANHANG (MANBH, TENNBH, EMAIL, SDT, DIACHI, NGAYDANGKY) VALUES
('NB001', N'Cửa hàng điện máy Xanh', 'dienmayxanh@gmail.com', '18001061', N'111 Đường 3/2, Q10, TP.HCM', '2022-11-01'),
('NB002', N'Thế giới di động', 'thegioididong@gmail.com', '18001080', N'222 Đường Lê Văn Việt, Q9, TP.HCM', '2022-10-15'),
('NB003', N'Shop thời trang YAME', 'yamefashion@gmail.com', '19001560', N'333 Đường Lê Lai, Q1, TP.HCM', '2023-01-10'),
('NB004', N'Nhà sách Fahasa', 'fahasa@gmail.com', '19005454', N'444 Đường Nguyễn Văn Cừ, Q5, TP.HCM', '2022-12-05'),
('NB005', N'Siêu thị Coopmart', 'coopmart@gmail.com', '19002239', N'555 Đường Lê Văn Sỹ, Q3, TP.HCM', '2022-09-20')
go
INSERT INTO DANHMUC (MADM, TENDM) VALUES
('DM001', N'Điện thoại di động'),
('DM002', N'Laptop'),
('DM003', N'Thời trang nam'),
('DM004', N'Thời trang nữ'),
('DM005', N'Sách văn học')
go
INSERT INTO SANPHAM (MASP, TENSP, MANBH, MADM, MOTA, GIAGOC, SLTON) VALUES
('SP001', 'iPhone 14 Pro Max', 'NB001', 'DM001', 'iPhone 14 Pro Max 128GB', 29990000, 50),
('SP002', 'MacBook Air M2', 'NB002', 'DM002', 'MacBook Air M2 2023 8GB/256GB', 28990000, 30),
('SP003', N'Áo sơ mi nam trắng', 'NB003', 'DM003', N'Áo sơ mi công sở cao cấp', 350000, 100),
('SP004', N'Váy liền công sở', 'NB003', 'DM004', N'Váy liền nữ công sở dáng dài', 450000, 80),
('SP005', N'Tiếng chim hót trong bụi mận gai', 'NB004', 'DM005', N'Sách tiếng Việt, bản dịch của Phạm Mạnh Hùng', 120000, 200)
go
INSERT INTO DONHANG (MADH, MAKH, NGAYDATHANG, TONGTIEN, TRANGTHAIGIAOHANG) VALUES
('DH001', 'KH001', '2023-06-01', 29990000, N'Đã giao'),
('DH002', 'KH002', '2023-06-05', 28990000, N'Đang vận chuyển'),
('DH003', 'KH003', '2023-06-10', 700000, N'Chờ xử lý'),
('DH004', 'KH004', '2023-06-15', 570000, N'Đã giao'),
('DH005', 'KH005', '2023-06-20', 120000, N'Đã giao')
go
INSERT INTO CHITIETDONHANG (MADH, MASP, SOLUONG, GIABAN) VALUES
('DH001', 'SP001', 1, 29990000),
('DH002', 'SP002', 1, 28990000),
('DH003', 'SP003', 2, 350000),
('DH004', 'SP003', 1, 350000),
('DH004', 'SP004', 1, 450000),
('DH005', 'SP005', 1, 120000)
go
INSERT INTO GIOHANG (MAGH, MAKH, MASP, SOLUONG) VALUES
('GH001', 'KH001', 'SP002', 1),
('GH002', 'KH002', 'SP003', 2),
('GH003', 'KH003', 'SP004', 1),
('GH004', 'KH004', 'SP005', 3),
('GH005', 'KH005', 'SP001', 1)
go
INSERT INTO DANHGIA (MAKH, MASP, NOIDUNG, SOSAO, NGAYDANHGIA) VALUES
('KH001', 'SP001', N'Sản phẩm tuyệt vời, giao hàng nhanh', 5, '2023-06-03'),
('KH002', 'SP002', N'Máy chạy mượt, pin trâu', 4, '2023-06-08'),
('KH003', 'SP003', N'Áo đẹp nhưng hơi mỏng', 3, '2023-06-12'),
('KH004', 'SP004', N'Váy vừa vặn, chất liệu tốt', 5, '2023-06-18'),
('KH005', 'SP005', N'Sách hay, nội dung cảm động', 5, '2023-06-22')
go

select*
from DANHGIA
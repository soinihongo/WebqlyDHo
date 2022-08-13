select * from KhachHang
select * from ChiNhanh
select * from NhanVien
select * from SanPham
select * from HoaDon
--

-- tạo bảng khách hàng
create table KhachHang(
	MaKH nchar(10) primary key unique,
	TenKhachHang nvarchar(50) not null,
	GioiTinh nvarchar(15),
	DiaChi nvarchar(50),
	SDT nvarchar(15),
	Email nvarchar(50)
)
-- tạo bảng sản phẩm
create table SanPham(
	MaSP nvarchar(25)not null,
	TenSanPham nvarchar(100)not null,
	GiaNhap int not null,
	GiaBan int not null,
	ThuongHieu nvarchar(50),
	LinkAnh nvarchar(255)not null,
	constraint PK_SanPham_MaSP primary key(MaSP)
	)
-- tạo bảng chi nhánh
create table ChiNhanh (
	MaCN nchar(10) not null unique,
	DiaChi nvarchar(100) not null,
	constraint PK_ChiNhanh primary key (MaCN)
)
--tạo bảng Nhân Viên
create table NhanVien(

[MaNV]	 		nchar(10) NOT NULL,
[TenNhanVien] 	nvarchar(50) NOT NULL,
[GioiTinh]		nchar(10),
[NgaySinh]		date ,
[CCCD]			nchar(15),
[Email] 		nvarchar(50),
[SDT]			nchar(11),
[LuongCung] 	integer NOT NULL,
[Thuong] 		integer,
Primary key ([MaNV])
)
-- tạo bảng hoá đơn
create table HoaDon(
	MaHD	nvarchar(10) not null unique,
	MaKH	nchar(10) not null,
	MaNV	nchar(10) NOT NULL,
	MaCN	nchar(10) not null,
	MaSP	nvarchar(25) not null,
	SoLuong int,
	ThanhTien int,
	NgayBan datetime,
	constraint PK_HoaDon_primarykey primary key (MaHD),
	constraint FK_HoaDonMaCN foreign key(MaCN) references ChiNhanh(MaCN) on delete cascade,
	constraint FK_HoaDonMaKH foreign key(MaKH) references KhachHang(MaKH) on delete cascade,
	constraint FK_HoaDonMaNV foreign key(MaNV) references NhanVien(MaNV) on delete cascade,
	constraint FK_HoaDonMaSP foreign key(MaSP) references SanPham(MaSP) on delete cascade,

)
---------------------------------------------------------------------------------------------------
--tạo trigger tính hoa hồng 3% cho mỗi đơn hàng bán được
create trigger NhanVien_trg_TinhHoaHong
on HoaDon
for update,insert,delete
as 
begin
	update NhanVien
	set Thuong = (select Sum(ThanhTien)*2/100 from HoaDon where HoaDon.MaNV = NhanVien.MaNV)
end
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
--tạo trigger tính doanh thu chi nhánh qua hoá đơn
create trigger ChiNhanh_trg_DoanhThu
on HoaDon
for insert,update,delete
as
begin
	update ChiNhanh
	set DoanhThu = (select Sum(ThanhTien) from HoaDon where ChiNhanh.MaCN=HoaDon.MaCN)

end
---------------------------------------------------------------------------------------------------
-- tạo trigger cập nhật giá tiền của hoá đơn
---------------------------------------------------------------------------------------------------
create trigger HoaDon_trg_CapNhatGiaTien
on HoaDon
for insert,update,delete
as
begin
	update HoaDon
	set ThanhTien = SoLuong * (select GiaBan from SanPham where SanPham.MaSP=HoaDon.MaSP)

end


-- dữ liệu nhân viên
insert into NhanVien(MaNV,TenNhanVien,GioiTinh,NgaySinh,CCCD,Email,SDT,LuongCung) values
--(N'NV002',N'Bùi Văn Tuấn',N'Nam','1999-07-26','031202001509','tuan.bv260799@gmail.com','0385378188',35),
(N'NV003',N'Phạm Văn Nam',N'Nam','1998-10-30','031202001510','nam.pv301098@gmail.com','0528456666',35),
(N'NV004',N'Dương Quang Huy',N'Nam','14/07/2002','031202001511','huy.dq140702@gmail.com','0569999992',25),
(N'NV005',N'Trịnh Hoàng Dương',N'Nam','25/03/2003','031202001512','duong.th250303@gmail.com','0768982345',25),
(N'NV006',N'Võ Thị Phương Thảo',N'Nữ','15/09/2000','031202001513','thao.vtp150900@gmail.com','0394802402',25),
(N'NV007',N'Nguyễn Hữu Chiến',N'Nam','28/02/1999','031202001514','chien.nh280299@gmail.com','0923995599',25),
(N'NV008',N'Nguyễn Thanh Lâm',N'Nam','18/04/2001','031202001515','lam.nt180401@gmail.com','0931311212',25),
(N'NV009',N'Tống Khánh Linh',N'Nữ','20/10/2000','031202001516','linh.tk201000@gmail.com','0930105696',15),
(N'NV010',N'Nguyễn Thị Diệu Linh',N'Nữ','15/01/1997','031202001517','linh.ntd150197@gmail.com','0908999936',15),
(N'NV011',N'Bùi Ngọc Mai',N'Nữ','23/08/2003','031202001518','mai.bn230803@gmail.com','0919992555',15),
(N'NV012',N'Vũ Khắc Minh',N'Nam','30/06/2001','031202001519','minh.vk300601@gmail.com','0908385556',15),
(N'NV013',N'Lê Minh Quân',N'Nam','11/05/1998','031202001520','quan.lm110598@gmail.com','0973529999',15),
(N'NV014',N'Đặng Minh Chiến',N'Nam','22/12/1997','031202001521','chien.dm221297@gmail.com','0965969999',15),
(N'NV015',N'Đỗ Thùy Chi',N'Nữ','13/11/2000','031202001522','chi.dt131100@gmail.com','0333216166',15)


-- dữ liệu đồng hồ <đã xong>
insert into SanPham values
(N'341.PX.130.RX.114',	N'Hublot Big Bang Chronograph King Gold Diamonds',570,620,N'Hublot','images\watches\listwatch\341.PX.130.RX.114.png'),
(N'7118-1A-011',		N'Patek Philippe Nautilus 7118/1A-011',1084,1356,N'Patek Philippe',				'images\watches\listwatch\7118-1A-011.png'),
(N'M126710BLNR-0002',N'Rolex Batman GMT-MasterII Oystersteel',446,558,N'Rolex',							'images\watches\listwatch\M126710BLNR-0002.png'),
(N'279174-0009',	N'Rolex Datejust White Rolesor MOP Diamond Dial ',256,320,N'Rolex','images\watches\listwatch\.png279174-0009.png'),
(N'116505-0015',	N'Rolex Cosmograph Daytona Everose Gold Black Diamonds Dial',1904,2380,N'Rolex','images\watches\listwatch\.png116505-0015.png'),
(N'128238A',		N'Rolex Day-Date Yellow Gold Green Ombré Diamond Dial',	1520,1900,N'Rolex',			'images\watches\listwatch\128238A.png'),
(N'126613LB',		N'Rolex Submariner Date Rolesor Yellow Gold Blue Bezel & Dial',396,495,N'Rolex',	'images\watches\listwatch\126613LB.png'),
(N'126610LV',		N'Rolex Submariner Kermit',468,585,N'Rolex','images\watches\listwatch\126610LV.png'),
(N'M126710BLNR-0002',N'Rolex Batman GMT-MasterII Oystersteel',446,558,N'Rolex',							'images\watches\listwatch\M126710BLNR-0002.png'),
(N'M126710BLRO-0001',N'Rolex GMT-Master II Pepsi 40mm - Jubilee Strap New',600,750,N'Rolex',			'images\watches\listwatch\M126710BLRO-0001.png'),
(N'126715CHNR',		N'Rolex GMT-Master II Root Beer Everose Gold',1376,1720,N'Rolex',					'images\watches\listwatch\126715CHNR.png'),
(N'326933',		N'Rolex Sky-Dweller Yellow Rolesor Champagne Dial 42mm',440,550,N'Rolex',			'images\watches\listwatch\326933.png'),
(N'116503-0001',	N'Rolex Cosmograph Daytona',624,780,N'Rolex','images\watches\listwatch\116503-0001.png'),
(N'279174-0015',	N'Rolex Lady Datejust White Rolesor Darck Grey Diamond Dial',232,290,N'Rolex',		'images\watches\listwatch\279174-0015.png'),
(N'126231-0027',	N'Rolex Datejust Everose Rolesor Salmon Roman Diamond Dial',340,425,N'Rolex',		'images\watches\listwatch\126231-0027.png'),
(N'126234',		N'Rolex Datejust Rolesor White Gold Blue Jubilee Diamond Dial',292,365,N'Rolex',	'images\watches\listwatch\126234.png'),
(N'228235',		N'Rolex Day-Date Everose Gold Chocolate Baguette Diamond Dial',1536,1920,N'Rolex',	'images\watches\listwatch\228235.png'),
(N'116610LV',		N'Rolex Submariner Hulk',676,845,N'Rolex',											'images\watches\listwatch\116610LV.png'),
(N'465.SS.1117.VR.1704',N'Hublot Big Bang Sang Bleu I Steel Pavé',360,450,N'Hublot',					'images\watches\listwatch\465.SS.1117.VR.1704.png'),
(N'665.OX.7180.LR.1204',N'Hublot Spirit Of Big Bang King Gold Blue Diamond',452,565,N'Hublot',			'images\watches\listwatch\665.OX.7180.LR.1204.png'),
(N'SKU01666',		N'Hublot Big Bang One Click Steel White Full Diamond',296,370,N'Hublot',			'images\watches\listwatch\SKU01666.png'),
(N'665.OX.1180.LR.1204',N'Hublot Spirit Of Big Bang King Gold Black Diamond 39mm',452,565,N'Hublot',	'images\watches\listwatch\665.OX.1180.LR.1204.png'),
(N'647.NX.1137.RX',N'Hublot Spirit Of Big Bang Titanium Moonphase',308,385,N'Hublot',					'images\watches\listwatch\647.NX.1137.RX.png'),
(N'550.OS.1800.RX.1604',N'Hublot Classic Fusion Orlinski King Gold Full Pavé',520,650,N'Hublot',		'images\watches\listwatch\550.OS.1800.RX.1604.png'),
(N'542.NX.1171.LR.1704',N'Hublot Classic Fusion Titanium Pavé',152,190,N'Hublot',						'images\watches\listwatch\542.NX.1171.LR.1704.png'),
(N'465.OS.1118.VR.1704',N'Hublot Big Bang Sang Bleu I King Gold Pavé',528,660,N'Hublot',				'images\watches\listwatch\465.OS.1118.VR.1704.png'),
(N'541.OX.1181.RX',	N'Hublot Classic Fusion Chronograph King Gold Black',424,530,N'Hublot',			'images\watches\listwatch\541.OX.1181.RX.png'),
(N'542.NX.1171.LR.1104',N'Hublot Classic Fusion Titanium Diamonds',140,175,N'Hublot',					'images\watches\listwatch\542.NX.1171.LR.1104.png'),
(N'542.NX.1171.LR',	N'Hublot Classic Fusion Titanium Black',125,157,N'Hublot',						'images\watches\listwatch\542.NX.1171.LR.png'),
(N'550.OS.1800.RX.ORL19',N'Hublot Classic Fusion Orlinski King Gold ',382,478,N'Hublot',				'images\watches\listwatch\550.OS.1800.RX.ORL19.png'),
(N'361.SX.7170.LR.1204',N'Hublot Big Bang Steel Blue Diamond',184,230,N'Hublot',						'images\watches\listwatch\361.SX.7170.LR.1204.png'),
(N'550.NS.1800.RX.1804',N'Hublot Classic Fusion Orlinski Titanium Alternative Pavé',252,315,N'Hublot',	'images\watches\listwatch\550.NS.1800.RX.1804.png'),
(N'485.SE.2210.RW.1204',N'Hublot Big Bang One Click Steel White Diamond',272,340,N'Hublot',			'images\watches\listwatch\485.SE.2210.RW.1204.png'),
(N'V41 Rose Gold',		N'Franck Muller Vanguard Rose Gold Full Diamonds',218,273,N'Franck Muller',		'images\watches\listwatch\V41 Rose Gold.png'),
(N'V41 Steel Black',	N'Franck Muller Vanguard Steel Full Diamonds',130,163,N'Franck Muller',			'images\watches\listwatch\V41 Steel Black.png'),
(N'V41 Yachting Gold',	N'Franck Muller Vanguard Yachting Rose Gold Full Diamonds',227,284,N'Franck Muller','images\watches\listwatch\V41 Yachting Gold.png'),
(N'V41 Yachting Steel',N'Franck Muller Vanguard Yachting Stainles Steel',115,144,N'Franck Muller',		'images\watches\listwatch\V41 Yachting Steel.png'),
(N'V32 Steel Black',	N'Franck Muller Vanguard V32 Steel Black Full Diamonds',110,138,N'Franck Muller','images\watches\listwatch\V32 Steel Black.png'),
(N'5205R-011',			N'Patek Philippe Complications 5205R-011',1670,2088,N'Patek Philippe',			'images\watches\listwatch\5205R-011.png'),
(N'5068R-010',			N'Patek Philippe Aquanaut 5068R-010',999,1249,N'Patek Philippe',				'images\watches\listwatch\5068R-010.png'),
(N'5712R-001',			N'Patek Philippe Nautilus 5712R-001',3640,4550,N'Patek Philippe',				'images\watches\listwatch\5712R-001.png'),
(N'5396R-011',			N'Patek Philippe Complications 5396R-011',854,1068,N'Patek Philippe',			'images\watches\listwatch\5396R-011.png'),
(N'5146G-001',			N'Patek Philippe Complications 5146G-001',647,809,N'Patek Philippe',			'images\watches\listwatch\5146G-001.png'),
(N'5396G-011',			N'Patek Philippe Complications 5396G-011',820,1026,N'Patek Philippe',			'images\watches\listwatch\5396G-011.png'),
(N'7118/1A-011',		N'Patek Philippe Nautilus 7118/1A-011',1084,1356,N'Patek Philippe',				'images\watches\listwatch\7118/1A-011.png'),
(N'5167A-001',			N'Patek Philippe Aquanaut 5167A-001',784,980,N'Patek Philippe',					'images\watches\listwatch\5167A-001.png'),
(N'5724G-001',			N'Patek Philippe Nautilus 5724G-001',4744,5930,N'Patek Philippe',				'images\watches\listwatch\5724G-001.png'),
(N'5724R-001',			N'Patek Philipee Nautilus 5724R-001',3292,4116,N'Patek Philippe',				'images\watches\listwatch\5724R-001.png'),
(N'5159J-001',			N'Patek Philippe Grand Complications 5159J-001',1420,1776,N'Patek Philippe',	'images\watches\listwatch\5159J-001.png'),
(N'5905P-010',			N'Patek Philippe Complications 5905P-010',1259,1574,N'Patek Philippe',			'images\watches\listwatch\5905P-010.png'),
(N'5205G-010',			N'Patek Philippe Annual Calendar 5205G-010',932,1165,N'Patek Philippe',			'images\watches\listwatch\5205G-010.png'),
(N'5296R-001',			N'Patek Philippe Calatrava 5296R-001',520,650,N'Patek Philippe',				'images\watches\listwatch\5296R-001.png'),
(N'RM35-02',			N'Richard Mille RM 35-02 Automatic Winding Rafael Nadal',10115,11900,N'Richard Mille','images\watches\listwatch\RM35-02.png'),
(N'RM035',N'Richard Mille RM035 Rafael Nadal TZP Ceramic NTPT Carbon',8819,10376,N'Richard Mille',		'images\watches\listwatch\RM035.png'),
(N'RM030',N'Richard Mille RM030 Diamond 18K Rose Gold Titanium',7191,8461,N'Richard Mille',			'images\watches\listwatch\RM030.png'),
(N'RM010',N'Richard Mille RM010 Diamond White Gold',4900,6126,N'Richard Mille',						'images\watches\listwatch\RM010.png'),
(N'RM037',N'Richard Mille RM037 Diamond Set Rose Gold Carbon NTPT',5544,6931,N'Richard Mille',			'images\watches\listwatch\RM037.png'),
(N'RM27-03',N'Richard Mille RM27-03 Tourbillon Rafael Nadal',25287,29750,N'Richard Mille',				'images\watches\listwatch\RM27-03.png'),
(N'RM19-01',N'Richard Mille Tourbillon Watches RM19-01 White Gold Diamond',25823,30381,N'Richard Mille','images\watches\listwatch\RM19-01.png'),
(N'RM11-04',N'Richard Mille RM11-04 Roberot Mancini Chronograph',14687,17279,N'Richard Mille',			'images\watches\listwatch\RM11-04.png'),
(N'RM029',N'Richard Mille RM029 Automatic Black Dial',3821,4777,N'Richard Mille',						'images\watches\listwatch\RM029.png'),
(N'RM11-03',N'Richard Mille RM11-03 MCL CA-FQ',12623,14851,N'Richard Mille',							'images\watches\listwatch\RM11-03.png')


-- dữ liệu Khách Hàng
insert into KhachHang values
('KH001',N'Bùi Khánh Hưng',N'Nam',N'Hà Nội','0394121213','buikhanhhung@gmail.com'),
('KH002',N'Hoàng Văn Hiển',N'Nam',N'Hải Phòng','0364343134','hoangvanhien@gmail.com'),
('KH003',N'Bùi Trung Hiếu',N'Nam',N'Hồ Chí Minh','0583839932','buitrunghieu@gmail.com'),
('KH004',N'Đỗ Chí Thành',N'Nam',N'Đà Nẵng','0982532235','dochithanh@gmail.com'),
('KH005',N'Hồ Yến Trinh',N'Nữ',N'Nghệ An','0394271043','hoyentrinh@gmail.com'),
('KH006',N'Đỗ Khánh Ly',N'Nữ',N'Hải Dương','0583982054','dokhanhly@gmail.com'),
('KH007',N'Lê Giang Nam',N'Nam',N'Quảng Ninh','0284936281','legiangnam@gmail.com'),
('KH008',N'Trần Hữu Sơn',N'Nam',N'Cao Bằng','0428926823','tranhuuson@gmail.com'),
('KH009',N'Nguyễn Đức Minh',N'Nam',N'Hà Nội','0352181274','nguyenducminh@gmail.com'),
('KH010',N'Nguyễn Duy Chiến',N'Nam',N'Thái Bình','0923472654','nguyenduychien@gmail.com'),
('KH011',N'Nguyễn Hải Dương',N'Nam',N'Huế','0562491245','nguyenhaiduong@gmail.com'),
('KH012',N'An Phương Thảo',N'Nữ',N'Hồ Chí Minh','0346823954','anphuongthao@gmail.com'),
('KH013',N'Nguyễn Văn Nam',N'Nam',N'Hà Nội','0122467465','nguyenvannam@gmail.com'),
('KH014',N'Nguyễn Ngọc Tú',N'Nữ',N'Hồ Chí Minh','0275913458','nguyenngoctu@gmail.com'),
('KH015',N'Vũ Thị Giới',N'Nữ',N'Hà Nội','0386905899','vuthigioi@gmail.com'),
('KH016',N'Tô Khánh Vân',N'Nữ',N'Hà Nội','0231953486','tokhanhvan@gmail.com'),
('KH017',N'Trần Thủ Độ',N'Nam',N'Hà Nội','0246783524','tranthudo@gmail.com'),
('KH018',N'Hoàng Mai Thùy Linh',N'Nữ',N'Hải Phòng','0394894817','hoangmaithuylinh@gmail.com')      ,
('KH019',N'Bùi Nguyễn Trung Quân',N'Nam',N'Hải Phòng','0365929958','buinguyentrungquan@gmail.com') ,
('KH020',N'Vương Quốc Tuân',N'Nam',N'Hải Dương','0987457721','vuongquoctuan@gmail.com'),
('KH021',N'Trần Nguyễn Thanh Vân',N'Nữ',N'Hồ Chí Minh','0394691563','trannguyenthanhvan@gmail.com'),
('KH022',N'Đặng Thùy Dương',N'Nữ',N'Huế','0953782914','dangthuyduong@gmail.com'),
('KH023',N'Võ Văn Bắc',N'Nam',N'Quảng Ninh','0284328595','vovanbac@gmail.com'),
('KH024',N'Chu Bá Hiếu',N'Nam',N'Quảng Ninh','0637429525','chubahieu@gmail.com'),
('KH025',N'Dương Quang Huy',N'Nam',N'Hải Phòng','0988888888','duongquanghuy@gmail.com'),
('KH026',N'Dương Phương Anh',N'Nữ',N'Quảng Ninh','0368686868','duongphuonganh@gmail.com'),
('KH027',N'Kiều Phương Thảo',N'Nữ',N'Hà Nội','0968686868','kieuphuongthao@gmail.com'),
('KH028',N'Kiều Minh Hiếu',N'Nam',N'Hà Nội','0966668888','kieuminhhieu@gmail.com'),
('KH029',N'Vũ Hoàng Khôi',N'Nam',N'Hà Nội','0923268688','vuhoangkhoi@gmail.com'),
('KH030',N'Đặng Minh Thảo',N'Nữ',N'Hà Nội','0308594442','dangminhthao@gmail.com'),
('KH031',N'Trịnh Đức Minh',N'Nam',N'Hà Nội','0943781245','trinhducminh@gmail.com'),
('KH032',N'Trịnh Công Sơn',N'Nam',N'Hà Nội','0956432819','trinhcongson@gmail.com'),
('KH033',N'Hoàng Minh Đức',N'Nam',N'Hà Nội','0385023234','hoangminhduc@gmail.com'),
('KH034',N'Vũ Văn Nam',N'Nam',N'Hồ Chí Minh','0868686868','vuvannam@gmail.com'),
('KH035',N'Nguyễn Đức Nhật Tân',N'Nam',N'Hồ Chí Minh','0823666888','nguyenducnhattan@gmail.com')   ,
('KH036',N'Johnny Đặng',N'Nam',N'Hồ Chí Minh','0846124775','johnnydang@gmail.com'),
('KH037',N'Kris Nguyễn',N'Nam',N'Đà Nẵng','0395359199','krisnguyen@gmail.com'),
('KH038',N'Tommy Bùi',N'Nam',N'Đà Nẵng','0354385332','tommybui@gmail.com'),
('KH039',N'Đinh Trọng Huy',N'Nam',N'Đà Nẵng','0579348524','dinhtronghuy@gmail.com'),
('KH040',N'Bùi Thị Hương Trà',N'Nữ',N'Đà Nẵng','0561236788','buithihuongtra@gmail.com'),
('KH041',N'Lưu Bị',N'Nam',N'Đà Nẵng','0951478742','luubi@gmail.com'),
('KH042',N'Quan Vũ',N'Nam',N'Trung Quốc','0262499433','quanvu@gmail.com'),
('KH043',N'Tào Tháo',N'Nam',N'Trung Quốc','0247592934','taothao@gmail.com'),
('KH044',N'Đổng Trác',N'Nam',N'Trung Quốc','0375739232','dongtrac@gmail.com'),
('KH045',N'Gia Cát Khổng Minh',N'Nam',N'Trung Quốc','0388959533','giacatluong@gmail.com'),
('KH046',N'Nobi Nobita',N'Nam',N'Nhật Bản','0249240475','nobinobita@gmail.com'),
('KH047',N'Kirigaya Kazuto',N'Nam',N'Nhật Bản','0349302485','kirigayakazuto@gmail.com'),
('KH048',N'Kobayashi Yuu',N'Nam',N'Nhật Bản','0343872595','kobayashiyuu@gmail.com'),
('KH049',N'Tommy Xiaomi',N'Nam',N'Mỹ','0562943256','tommyxiaomi@gmail.com'),
('KH050',N'Châu Tình Trì',N'Nam',N'Hồng Kông','0283691955','chautinhtri@gmail.com'),
('KH051',N'Vũ Trung Nghĩa',N'Nam',N'Hà Nội','0355823594','vutrungnghia@gmail.com'),
('KH052',N'Nguyễn Anh Thứ',N'Nam',N'Hà Nội','0459837564','nguyenanhthu@gmail.com'),
('KH053',N'Đào Quỳnh Anh',N'Nữ',N'Hà Nội','0418915898','daoquynhanh@gmail.com'),
('KH054',N'Đào Khắc Hải Anh',N'Nam',N'Hồ Chí Minh','0279643234','daokhachaianh@gmail.com'),
('KH055',N'Lê Duy Quý',N'Nam',N'Hồ Chí Minh','0372582935','leduyquy@gmail.com'),
('KH056',N'Nguyễn Văn Hùng',N'Nam',N'Hồ Chí Minh','0346295357','nguyenvanhung@gmail.com'),
('KH057',N'Mạc Anh Tú',N'Nam',N'Hồ Chí Minh','0342854583','macanhtu@gmail.com'),
('KH058',N'Kiều Minh Tuấn',N'Nam',N'Đà Nẵng','0462857355','kieuminhtuan@gmail.com'),
('KH059',N'An Minh Hoàng',N'Nam',N'Đà Nẵng','0246858959','anminhhoang@gmail.com'),
('KH060',N'Bùi Thị Huyền Trang',N'Nữ',N'Đà Nẵng','0346852833','buithihuyentrang@gmail.com')

-- dữ liệu chi nhánh
insert into ChiNhanh values 
('HN01',N'Số 1 Khúc Thừa Dụ, Dịch Vọng, Cầu Giấy, Hà Nội'),
('HP01',N'182 Văn Cao, Đằng Giang, Ngô Quyền, Hải Phòng'),
('DN01',N'519 Nguyễn Hữu Thọ, Khuê Trung, Cẩm Lệ, Đà Nẵng'),
('HCM01',N'276 Pasteur, Phường 8, Quận 3, TP Hồ Chí Minh')


---------------------------------------------------------------------------------------------------
-- dữ liệu hoá đơn


insert into HoaDon(MaHD,MaKH,MaNV,MaCN,MaSP,SoLuong,NgayBan) values
('HD001','KH001','NV001','HN01','279174-0009',1,'2022-03-21'),
('HD002','KH002','NV002','HP01','116505-0015',1,'2022-01-26'),
('HD003','KH003','NV003','HCM01','128238A',1,'2022-01-25'),
('HD004','KH004','NV004','DN01','126613LB',1,'2022-04-10'),
('HD005','KH005','NV005','DN01','126610LV',1,'2022-05-13'),
('HD006','KH006','NV006','HP01','M126710BLNR-0002',1,'2022-03-04'),
('HD007','KH007','NV007','HP01','M126710BLRO-0001',1,'2022-03-04'),
('HD008','KH008','NV008','HN01','126715CHNR',1,'2022-03-11'),
('HD009','KH009','NV009','HN01','326933',1,'2022-07-04'),
('HD010','KH010','NV010','HN01','116503-0001',1,'2022-02-21'),
('HD011','KH011','NV011','HCM01','279174-0015',1,'2022-04-05'),
('HD012','KH012','NV012','HCM01','126231-0027',1,'2022-07-14'),
('HD013','KH013','NV013','HN01','126234',1,'2022-02-11'),
('HD014','KH014','NV014','HCM01','228235',1,'2022-07-05'),
('HD015','KH015','NV015','HN01','116610LV',1,'2022-04-13'),
('HD016','KH016','NV001','HN01','465.SS.1117.VR.1704',1,'2022-07-19'),
('HD017','KH017','NV002','HN01','665.OX.7180.LR.1204',1,'2022-03-25'),
('HD018','KH018','NV003','HP01','SKU01666',1,'2022-03-12'),
('HD019','KH019','NV004','HP01','665.OX.1180.LR.1204',1,'2022-01-06'),
('HD020','KH020','NV005','HP01','647.NX.1137.RX',1,'2022-03-03'),
('HD021','KH021','NV006','HCM01','550.OS.1800.RX.1604',1,'2022-04-25'),
('HD022','KH022','NV007','HCM01','542.NX.1171.LR.1704',1,'2022-07-18'),
('HD023','KH023','NV008','HP01','465.OS.1118.VR.1704',1,'2022-01-25'),
('HD024','KH024','NV009','HP01','541.OX.1181.RX',1,'2022-07-26'),
('HD025','KH025','NV010','HP01','542.NX.1171.LR.1104',1,'2022-06-11'),
('HD026','KH026','NV011','HP01','542.NX.1171.LR',1,'2022-05-09'),
('HD027','KH027','NV012','HN01','550.OS.1800.RX.ORL19',1,'2022-06-25'),
('HD028','KH028','NV013','HN01','361.SX.7170.LR.1204',1,'2022-04-18'),
('HD029','KH029','NV014','HN01','550.NS.1800.RX.1804',1,'2022-04-05'),
('HD030','KH030','NV015','HN01','485.SE.2210.RW.1204',1,'2022-02-19'),
('HD031','KH031','NV001','HN01','V41 Rose Gold',1,'2022-03-12'),
('HD032','KH032','NV002','HN01','V41 Steel Black',1,'2022-03-16'),
('HD033','KH033','NV003','HN01','V41 Yachting Gold',1,'2022-06-22'),
('HD034','KH034','NV004','HCM01','V32 Steel White',1,'2022-07-14'),
('HD035','KH035','NV005','HCM01','V41 Yachting Steel',1,'2022-04-15'),
('HD036','KH036','NV006','HCM01','V32 Steel Black',1,'2022-04-04'),
('HD037','KH037','NV007','DN01','5205R-011',1,'2022-02-15'),
('HD038','KH038','NV008','DN01','5068R-010',1,'2022-03-05'),
('HD039','KH039','NV009','DN01','5712R-001',1,'2022-07-03'),
('HD040','KH040','NV010','DN01','5396R-011',1,'2022-07-07'),
('HD041','KH041','NV011','DN01','5146G-001',1,'2022-01-27'),
('HD042','KH042','NV012','HN01','5396G-011',1,'2022-05-01'),
('HD043','KH043','NV013','HN01','7118-1A-011',1,'2022-06-24'),
('HD044','KH044','NV014','HN01','5167A-001',1,'2022-03-13'),
('HD045','KH045','NV015','HN01','5724G-001',1,'2022-01-13'),
('HD046','KH046','NV001','HN01','5724R-001',1,'2022-07-12'),
('HD047','KH047','NV002','HN01','5159J-001',1,'2022-01-26'),
('HD048','KH048','NV003','HN01','5905P-010',1,'2022-05-07'),
('HD049','KH049','NV004','HN01','5205G-010',1,'2022-05-19'),
('HD050','KH050','NV005','HN01','5296R-001',1,'2022-05-10'),
('HD051','KH051','NV006','HN01','RM35-02',1,'2022-05-11'),
('HD052','KH052','NV007','HN01','RM035',1,'2022-07-22'),
('HD053','KH053','NV008','HN01','RM030',1,'2022-02-23'),
('HD054','KH054','NV009','HCM01','RM010',1,'2022-01-05'),
('HD055','KH055','NV010','HCM01','RM029',1,'2022-01-10'),
('HD056','KH056','NV011','HCM01','RM27-03',1,'2022-03-20'),
('HD057','KH057','NV012','HCM01','RM19-01',1,'2022-07-14'),
('HD058','KH058','NV013','DN01','RM11-04',1,'2022-07-21'),
('HD059','KH059','NV014','DN01','RM029',1,'2022-07-02'),
('HD060','KH060','NV015','DN01','RM11-03',1,'2022-02-25')

---------------------------------------------------------------------------------------------------
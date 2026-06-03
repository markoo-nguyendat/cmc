-- =============================================================
-- PHẦN 1: DATABASE VÀ BẢNG
-- =============================================================
CREATE DATABASE QuanLyPhongTapGym;
GO
USE QuanLyPhongTapGym;
GO

-- Bảng GoiTap
CREATE TABLE GoiTap (
    gt_ID       INT IDENTITY(1,1) PRIMARY KEY,
    gt_Ten      NVARCHAR(100) NOT NULL,
    gt_ThoiHan  INT NOT NULL,
    gt_GiaTien  DECIMAL(18,2) NOT NULL,
    CONSTRAINT CK_GoiTap_ThoiHan CHECK (gt_ThoiHan > 0),
    CONSTRAINT CK_GoiTap_GiaTien CHECK (gt_GiaTien >= 0)
);
GO

-- Bảng HoiVien
CREATE TABLE HoiVien (
    hv_ID       INT IDENTITY(1,1) PRIMARY KEY,
    hv_HoTen    NVARCHAR(100) NOT NULL,
    hv_NgaySinh DATE NOT NULL,
    hv_GioiTinh NVARCHAR(10) NOT NULL,
    hv_SDT      NVARCHAR(15) NOT NULL UNIQUE,
    CONSTRAINT CK_HoiVien_GioiTinh CHECK (hv_GioiTinh IN (N'Nam', N'Nữ', N'Khác'))
);
GO

-- Bảng HuanLuyenVien
CREATE TABLE HuanLuyenVien (
    hlv_ID INT IDENTITY(1,1) PRIMARY KEY,
    hlv_Ten NVARCHAR(100) NOT NULL,
    hlv_ChuyenMon NVARCHAR(100) NOT NULL,
    hlv_SDT NVARCHAR(15) NOT NULL UNIQUE
);
GO

-- Bảng PhieuDangKy
CREATE TABLE PhieuDangKy (
    pdk_ID INT IDENTITY(1,1) PRIMARY KEY,
    hv_ID INT NOT NULL,
    pdk_NgayDangKy DATE NOT NULL DEFAULT GETDATE(),
    gt_ID INT NOT NULL,
    pdk_NgayBatDau DATE NOT NULL,
    pdk_NgayKetThuc DATE NOT NULL,
    pdk_SoTien DECIMAL(18,2) NOT NULL,
    pdk_TrangThai NVARCHAR(20) NOT NULL DEFAULT N'Còn hiệu lực',
    CONSTRAINT FK_PhieuDangKy_HoiVien FOREIGN KEY (hv_ID) REFERENCES HoiVien(hv_ID),
    CONSTRAINT FK_PhieuDangKy_GoiTap FOREIGN KEY (gt_ID) REFERENCES GoiTap(gt_ID),
    CONSTRAINT CK_PhieuDangKy_Ngay CHECK (pdk_NgayKetThuc >= pdk_NgayBatDau),
    CONSTRAINT CK_PhieuDangKy_TrangThai CHECK (pdk_TrangThai IN (N'Còn hiệu lực', N'Hết hạn'))
);
GO

-- Bảng DangKyHLV (quan hệ Hội viên - Huấn luyện viên)
CREATE TABLE DangKyHLV (
    dk_ID   INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    hv_ID   INT NOT NULL,
    hlv_ID  INT NOT NULL,
    pdk_ID  INT NOT NULL,
    CONSTRAINT FK_DangKyHLV_HoiVien         FOREIGN KEY (hv_ID)  REFERENCES HoiVien(hv_ID),
    CONSTRAINT FK_DangKyHLV_HuanLuyenVien   FOREIGN KEY (hlv_ID) REFERENCES HuanLuyenVien(hlv_ID),
    CONSTRAINT FK_DangKyHLV_PhieuDangKy     FOREIGN KEY (pdk_ID) REFERENCES PhieuDangKy(pdk_ID)
);
GO

-- =============================================================
-- PHẦN 2: DỮ LIỆU MẪU
-- =============================================================

-- Gói tập (6 gói)
INSERT INTO GoiTap (gt_Ten, gt_ThoiHan, gt_GiaTien) VALUES
(N'Gói 1 tháng cơ bản',    30,     300000),
(N'Gói 3 tháng tiêu chuẩn',90,     750000),
(N'Gói 6 tháng nâng cao',  180,    1300000),
(N'Gói 1 năm VIP',         365,    2200000),
(N'Gói 1 tháng PT kèm',    30,     800000),
(N'Gói 3 tháng PT kèm',    90,     2000000);
GO

-- Huấn luyện viên (5 HLV)
INSERT INTO HuanLuyenVien (hlv_Ten, hlv_ChuyenMon, hlv_SDT) VALUES
(N'Nguyễn Văn Hùng',   N'Gym - Tăng cơ',        '0901111111'),
(N'Trần Thị Mai',       N'Yoga - Giảm cân',      '0902222222'),
(N'Lê Minh Tuấn',       N'Cardio - Sức bền',     '0903333333'),
(N'Phạm Quốc Bảo',     N'CrossFit - Tổng hợp',  '0904444444'),
(N'Đỗ Thị Hoa',         N'Pilates - Phục hồi',   '0905555555');
GO

-- Hội viên (25 hội viên)
INSERT INTO HoiVien (hv_HoTen, hv_NgaySinh, hv_GioiTinh, hv_SDT) VALUES
(N'Trần Văn An',        '1995-03-15', N'Nam',  '0911000001'),
(N'Nguyễn Thị Bình',    '1998-07-22', N'Nữ',   '0911000002'),
(N'Lê Hoàng Cường',     '1992-11-08', N'Nam',  '0911000003'),
(N'Phạm Thị Dung',      '2000-01-30', N'Nữ',   '0911000004'),
(N'Đỗ Văn Em',          '1990-06-18', N'Nam',  '0911000005'),
(N'Hoàng Thị Phương',   '1997-09-05', N'Nữ',   '0911000006'),
(N'Vũ Minh Giang',      '1993-04-27', N'Nam',  '0911000007'),
(N'Bùi Thị Hà',         '2001-12-14', N'Nữ',   '0911000008'),
(N'Đinh Văn Inh',       '1988-08-03', N'Nam',  '0911000009'),
(N'Cao Thị Kim',         '1999-02-19', N'Nữ',   '0911000010'),
(N'Phan Văn Long',      '1994-05-11', N'Nam',  '0911000011'),
(N'Lý Thị Mai',         '1996-10-25', N'Nữ',   '0911000012'),
(N'Ngô Văn Nam',        '1991-07-07', N'Nam',  '0911000013'),
(N'Tô Thị Oanh',        '2002-03-16', N'Nữ',   '0911000014'),
(N'Hồ Văn Phúc',        '1989-01-22', N'Nam',  '0911000015'),
(N'Dương Thị Quỳnh',    '1997-06-09', N'Nữ',   '0911000016'),
(N'Châu Văn Rồng',      '1993-11-30', N'Nam',  '0911000017'),
(N'Lâm Thị Sen',        '2000-08-17', N'Nữ',   '0911000018'),
(N'Trịnh Văn Thắng',    '1986-04-04', N'Nam',  '0911000019'),
(N'Mai Thị Uyên',       '1998-09-28', N'Nữ',   '0911000020'),
(N'Nguyễn Văn Vinh',    '1995-12-01', N'Nam',  '0911000021'),
(N'Võ Thị Xuân',        '1992-02-14', N'Nữ',   '0911000022'),
(N'Đặng Văn Yên',       '1990-07-23', N'Nam',  '0911000023'),
(N'Huỳnh Thị Zung',     '2003-05-06', N'Nữ',   '0911000024'),
(N'Bùi Văn Khải',       '1987-10-12', N'Nam',  '0911000025');
GO

-- Phiếu đăng ký (25 phiếu)
-- Lưu ý: Trigger kiểm tra gói hiệu lực sẽ được tạo SAU khi insert dữ liệu mẫu
INSERT INTO PhieuDangKy (pdk_NgayDangKy, hv_ID, gt_ID, pdk_NgayBatDau, pdk_NgayKetThuc, pdk_SoTien, pdk_TrangThai) VALUES
('2026-03-01', 1,  1, '2026-03-01', '2026-03-31', 300000,  N'Hết hạn'),
('2026-01-10', 2,  2, '2026-01-10', '2026-04-10', 750000,  N'Hết hạn'),
('2026-02-15', 3,  3, '2026-02-15', '2026-08-14', 1300000, N'Còn hiệu lực'),
('2025-12-01', 4,  4, '2026-01-01', '2026-12-31', 2200000, N'Còn hiệu lực'),
('2026-03-20', 5,  5, '2026-03-20', '2026-04-19', 800000,  N'Hết hạn'),
('2026-04-01', 6,  1, '2026-04-01', '2026-04-30', 300000,  N'Còn hiệu lực'),
('2026-02-01', 7,  6, '2026-02-01', '2026-04-30', 2000000, N'Còn hiệu lực'),
('2026-03-15', 8,  2, '2026-03-15', '2026-06-13', 750000,  N'Còn hiệu lực'),
('2025-11-01', 9,  3, '2025-11-01', '2026-04-29', 1300000, N'Còn hiệu lực'),
('2026-04-10', 10, 4, '2026-04-10', '2027-04-10', 2200000, N'Còn hiệu lực'),
('2026-01-05', 11, 5, '2026-01-05', '2026-02-04', 800000,  N'Hết hạn'),
('2026-04-05', 12, 1, '2026-04-05', '2026-05-05', 300000,  N'Còn hiệu lực'),
('2026-03-01', 13, 6, '2026-03-01', '2026-05-29', 2000000, N'Còn hiệu lực'),
('2026-02-20', 14, 2, '2026-02-20', '2026-05-21', 750000,  N'Còn hiệu lực'),
('2025-10-01', 15, 3, '2025-10-01', '2026-03-30', 1300000, N'Hết hạn'),
('2026-04-15', 16, 4, '2026-04-15', '2027-04-15', 2200000, N'Còn hiệu lực'),
('2026-03-10', 17, 5, '2026-03-10', '2026-04-09', 800000,  N'Hết hạn'),
('2026-04-01', 18, 1, '2026-04-01', '2026-04-30', 300000,  N'Còn hiệu lực'),
('2026-02-10', 19, 6, '2026-02-10', '2026-05-10', 2000000, N'Còn hiệu lực'),
('2026-01-20', 20, 2, '2026-01-20', '2026-04-20', 750000,  N'Hết hạn'),
('2026-04-08', 21, 3, '2026-04-08', '2026-10-05', 1300000, N'Còn hiệu lực'),
('2026-03-25', 22, 5, '2026-03-25', '2026-04-24', 800000,  N'Còn hiệu lực'),
('2026-04-01', 23, 4, '2026-04-01', '2027-04-01', 2200000, N'Còn hiệu lực'),
('2026-02-01', 24, 1, '2026-02-01', '2026-03-03', 300000,  N'Hết hạn'),
('2026-04-10', 25, 6, '2026-04-10', '2026-07-09', 2000000, N'Còn hiệu lực');
GO

-- Đăng ký huấn luyện viên (25 bản ghi)
INSERT INTO DangKyHLV (hv_ID, hlv_ID, pdk_ID) VALUES
(3,  1, 3),  (4,  3, 4),  (7,  4, 7),  (9,  1, 9),  (10, 2, 10),
(13, 4, 13), (14, 2, 14), (16, 1, 16), (19, 4, 19), (21, 1, 21),
(22, 5, 22), (23, 3, 23), (25, 4, 25), (1,  2, 1),  (2,  5, 2),
(6,  2, 6),  (8,  5, 8),  (12, 2, 12), (15, 1, 15), (17, 3, 17),
(18, 5, 18), (20, 3, 20), (24, 2, 24), (5,  3, 5),  (11, 1, 11);
GO


-- =============================================================
-- PHẦN 3: VIEWS (3 VIEW)
-- =============================================================

-- View 1: Hội viên đang có gói tập còn hiệu lực
CREATE VIEW vw_HoiVienConHieuLuc AS
    SELECT
        hv.hv_ID,
        hv.hv_HoTen,
        hv.hv_NgaySinh,
        hv.hv_GioiTinh,
        hv.hv_SDT,
        gt.gt_Ten                       AS TenGoiTap,
        pdk.pdk_NgayBatDau              AS NgayBatDau,
        pdk.pdk_NgayKetThuc             AS NgayKetThuc,
        DATEDIFF(DAY, GETDATE(), pdk.pdk_NgayKetThuc) AS SoNgayCon
    FROM HoiVien hv
    INNER JOIN PhieuDangKy pdk ON hv.hv_ID  = pdk.hv_ID
    INNER JOIN GoiTap      gt  ON pdk.gt_ID = gt.gt_ID
    WHERE pdk.pdk_TrangThai = N'Còn hiệu lực'
      AND pdk.pdk_NgayKetThuc >= CAST(GETDATE() AS DATE);
GO

-- View 2: Hội viên đã hết hạn gói tập
CREATE VIEW vw_HoiVienHetHan AS
    SELECT
        hv.hv_ID,
        hv.hv_HoTen,
        hv.hv_GioiTinh,
        hv.hv_SDT,
        gt.gt_Ten                                       AS TenGoiTap,
        pdk.pdk_NgayKetThuc                             AS NgayHetHan,
        DATEDIFF(DAY, pdk.pdk_NgayKetThuc, GETDATE())   AS SoNgayQuaHan
    FROM HoiVien hv
    INNER JOIN PhieuDangKy pdk ON hv.hv_ID  = pdk.hv_ID
    INNER JOIN GoiTap      gt  ON pdk.gt_ID = gt.gt_ID
    WHERE pdk.pdk_TrangThai = N'Hết hạn'
       OR pdk.pdk_NgayKetThuc < CAST(GETDATE() AS DATE);
GO

-- View 3: Thống kê doanh thu theo từng gói tập
CREATE VIEW vw_DoanhThuTheoGoiTap AS
    SELECT
        gt.gt_ID,
        gt.gt_Ten                   AS TenGoiTap,
        gt.gt_GiaTien               AS DonGia,
        COUNT(pdk.pdk_ID)           AS TongLuotDangKy,
        SUM(pdk.pdk_SoTien)         AS TongDoanhThu,
        AVG(pdk.pdk_SoTien)         AS DoanhThuTrungBinh
    FROM GoiTap gt
    LEFT JOIN PhieuDangKy pdk ON gt.gt_ID = pdk.gt_ID
    GROUP BY gt.gt_ID, gt.gt_Ten, gt.gt_GiaTien;
GO

-- =============================================================
-- PHẦN 4: STORED PROCEDURES (4 SP)
-- =============================================================

-- SP 1: Tìm kiếm hội viên theo tên, SĐT hoặc gói tập
CREATE PROCEDURE sp_TimKiemHoiVien
    @HoTen   NVARCHAR(100) = NULL,
    @SDT     NVARCHAR(15)  = NULL,
    @TenGoi  NVARCHAR(100) = NULL
AS
BEGIN
    SELECT DISTINCT
        hv.hv_ID,
        hv.hv_HoTen,
        hv.hv_NgaySinh,
        hv.hv_GioiTinh,
        hv.hv_SDT,
        gt.gt_Ten           AS TenGoiTap,
        pdk.pdk_TrangThai   AS TrangThai
    FROM HoiVien hv
    LEFT JOIN PhieuDangKy pdk ON hv.hv_ID  = pdk.hv_ID
    LEFT JOIN GoiTap      gt  ON pdk.gt_ID = gt.gt_ID
    WHERE
        (@HoTen  IS NULL OR hv.hv_HoTen LIKE N'%' + @HoTen  + N'%')
    AND (@SDT    IS NULL OR hv.hv_SDT   LIKE     '%' + @SDT  +     '%')
    AND (@TenGoi IS NULL OR gt.gt_Ten   LIKE N'%' + @TenGoi  + N'%');
END;
GO

-- SP 2: Tìm kiếm đăng ký theo ngày / tháng / năm
CREATE PROCEDURE sp_TimKiemDangKyTheoThoiGian
    @Ngay  INT = NULL,
    @Thang INT = NULL,
    @Nam   INT = NULL
AS
BEGIN
    SELECT
        pdk.pdk_ID,
        pdk.pdk_NgayDangKy,
        hv.hv_HoTen         AS TenHoiVien,
        hv.hv_SDT,
        gt.gt_Ten            AS TenGoiTap,
        pdk.pdk_NgayBatDau,
        pdk.pdk_NgayKetThuc,
        pdk.pdk_SoTien,
        pdk.pdk_TrangThai
    FROM PhieuDangKy pdk
    INNER JOIN HoiVien hv ON pdk.hv_ID = hv.hv_ID
    INNER JOIN GoiTap  gt ON pdk.gt_ID = gt.gt_ID
    WHERE
        (@Ngay  IS NULL OR DAY  (pdk.pdk_NgayDangKy) = @Ngay)
    AND (@Thang IS NULL OR MONTH(pdk.pdk_NgayDangKy) = @Thang)
    AND (@Nam   IS NULL OR YEAR (pdk.pdk_NgayDangKy) = @Nam)
    ORDER BY pdk.pdk_NgayDangKy DESC;
END;
GO

-- SP 3: Thống kê doanh thu theo tháng / năm
CREATE PROCEDURE sp_ThongKeDoanhThu
    @Thang INT = NULL,
    @Nam   INT = NULL
AS
BEGIN
    SELECT
        YEAR (pdk.pdk_NgayDangKy) AS Nam,
        MONTH(pdk.pdk_NgayDangKy) AS Thang,
        gt.gt_Ten                  AS TenGoiTap,
        COUNT(pdk.pdk_ID)          AS SoLuotDangKy,
        SUM(pdk.pdk_SoTien)        AS DoanhThu
    FROM PhieuDangKy pdk
    INNER JOIN GoiTap gt ON pdk.gt_ID = gt.gt_ID
    WHERE
        (@Thang IS NULL OR MONTH(pdk.pdk_NgayDangKy) = @Thang)
    AND (@Nam   IS NULL OR YEAR (pdk.pdk_NgayDangKy) = @Nam)
    GROUP BY YEAR(pdk.pdk_NgayDangKy), MONTH(pdk.pdk_NgayDangKy), gt.gt_Ten
    ORDER BY Nam, Thang, DoanhThu DESC;
END;
GO

-- SP 4: Cập nhật hàng loạt trạng thái hội viên hết hạn
CREATE PROCEDURE sp_CapNhatTrangThaiHetHan
AS
BEGIN
    UPDATE PhieuDangKy
    SET pdk_TrangThai = N'Hết hạn'
    WHERE pdk_NgayKetThuc < CAST(GETDATE() AS DATE)
      AND pdk_TrangThai   = N'Còn hiệu lực';

    PRINT CAST(@@ROWCOUNT AS NVARCHAR) + N' phiếu đã được cập nhật sang "Hết hạn".';
END;
GO
-- Goi tap Dky Nhieu nhat
CREATE PROCEDURE sp_GoiTapDangKyNhieuNhat
AS
BEGIN
    SELECT TOP 1
        gt.gt_Ten,
        COUNT(*) AS SoLuongDangKy
    FROM PhieuDangKy pdk
    JOIN GoiTap gt ON pdk.gt_ID = gt.gt_ID
    GROUP BY gt.gt_Ten
    ORDER BY SoLuongDangKy DESC
END
GO

--Cap nhat trang thai CREATE TRIGGER trg_CapNhatTrangThai
CREATE TRIGGER trg_CapNhatTrangThai
ON PhieuDangKy
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE p
    SET pdk_TrangThai =
        CASE
            WHEN i.pdk_NgayKetThuc < CAST(GETDATE() AS DATE)
                THEN N'Hết hạn'
            ELSE N'Còn hiệu lực'
        END
    FROM PhieuDangKy p
    JOIN inserted i ON p.pdk_ID = i.pdk_ID
END
GO
--Danh sách hội viên còn hiệu lực--
SELECT hv.hv_HoTen, pdk.pdk_NgayKetThuc, pdk.pdk_TrangThai
FROM HoiVien hv
JOIN PhieuDangKy pdk ON hv.hv_ID = pdk.hv_ID
WHERE pdk.pdk_TrangThai = N'Còn hiệu lực'

--Thống kê doanh thu theo tháng--
SELECT MONTH(pdk_NgayDangKy) AS Thang,
       SUM(pdk_SoTien) AS DoanhThu
FROM PhieuDangKy
GROUP BY MONTH(pdk_NgayDangKy)
ORDER BY Thang

--Top gói tập được đăng ký nhiều nhất--
SELECT TOP 3 gt.gt_Ten, COUNT(*) AS SoLuongDangKy
FROM PhieuDangKy pdk
JOIN GoiTap gt ON pdk.gt_ID = gt.gt_ID
GROUP BY gt.gt_Ten
ORDER BY SoLuongDangKy DESC

--Danh sách hội viên đã hết hạn--
SELECT hv.hv_HoTen, pdk.pdk_NgayKetThuc
FROM HoiVien hv
JOIN PhieuDangKy pdk ON hv.hv_ID = pdk.hv_ID
WHERE pdk.pdk_TrangThai = N'Hết hạn'





-----8 Truy Vấn SQL Quan Trọng-----
-----1. Thống Kê Doanh Thu Theo Tháng-----
SELECT 
    MONTH(pdk_NgayDangKy) AS Thang,
    SUM(pdk_SoTien) AS DoanhThu
FROM PhieuDangKy
GROUP BY MONTH(pdk_NgayDangKy)
ORDER BY Thang;

-----2. Danh Sách Hội Viên Hết Hạn-----
SELECT 
    hv.hv_HoTen, 
    pdk.pdk_NgayKetThuc
FROM HoiVien hv
JOIN PhieuDangKy pdk 
    ON hv.hv_ID = pdk.hv_ID
WHERE pdk.pdk_TrangThai = N'Hết hạn';

-----3. Top 3 Gói Tập Được Đăng Ký Nhiều Nhất-----
SELECT 
    hv.hv_HoTen, 
    pdk.pdk_NgayKetThuc
FROM HoiVien hv
JOIN PhieuDangKy pdk 
    ON hv.hv_ID = pdk.hv_ID
WHERE pdk.pdk_TrangThai = N'Hết hạn';

----4. Danh Sách Hội Viên Còn Hiệu Lực-----
SELECT 
    hv.hv_HoTen, 
    pdk.pdk_NgayKetThuc
FROM HoiVien hv
JOIN PhieuDangKy pdk 
    ON hv.hv_ID = pdk.hv_ID
WHERE pdk.pdk_TrangThai = N'Hết hạn';

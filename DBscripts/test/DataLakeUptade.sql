-- CREATE DATABASE DataLakeDatabase;
-- GO

USE DataLakeDatabase;
GO


-- TABLES DECLARATION

CREATE TABLE DataLake
(
    Id             INT,
    Details        NVARCHAR(255),
    Color          TEXT,
    LastUpdateDate DATETIME,
    Created        DATE,
    ExpirationDate DATETIME
);
GO

CREATE TABLE Delta
(
    Id             INT,
    Details        NVARCHAR(255),
    Color          TEXT,
    LastUpdateDate DATETIME,
    Created        DATE,
    ExpirationDate DATETIME
);
GO


--  DATA INSERTION

INSERT INTO DataLake (Id, Details, Color, LastUpdateDate, Created, ExpirationDate)
VALUES (4, 'iure', 'aqua', '1979-04-23 05:28:41', '2008-09-24', '2020-06-21 16:17:08'),
       (5, 'ut', 'navy', '1975-09-01 01:24:41', '1994-10-17', '1986-04-04 02:43:28'),
       (6, 'qui', 'gray', '2013-01-09 17:23:06', '1974-12-19', '2017-09-09 21:42:10'),
       (7, 'ducimus', 'green', '1975-08-11 19:15:56', '2006-02-05', '2014-10-11 00:21:43'),
       (8, 'et', 'fuchsia', '1991-12-05 20:45:04', '1975-02-10', '2008-07-06 15:03:32'),
       (9, 'delectus', 'purple', '1999-04-13 04:00:57', '2002-10-28', '1982-01-10 13:21:18'),
       (10, 'atque', 'olive', '1975-04-15 11:51:50', '1989-08-02', '1985-07-11 22:06:26'),
       (11, 'vitae', 'olive', '2020-02-16 19:39:36', '2001-10-19', '1973-03-14 05:06:48'),
       (12, 'vero', 'navy', '2008-05-15 20:41:19', '2021-01-18', '1971-10-24 08:13:11'),
       (13, 'quis', 'purple', '2008-11-20 00:59:21', '1970-04-28', '1995-08-06 01:24:33')
GO

INSERT INTO Delta (Id, Details, Color, LastUpdateDate, Created, ExpirationDate)
VALUES (10, 'u', 'olive', '2021-03-28 01:01:01', '1989-08-02', '1985-07-11 22:06:26'),
       (11, 'p', 'olive', '2021-03-28 01:01:01', '2001-10-19', '1973-03-14 05:06:48'),
       (12, 'd', 'navy', '2021-03-28 01:01:01', '2021-01-18', '1971-10-24 08:13:11'),
       (13, 'a', 'purple', '2021-03-28 01:01:01', '1970-04-28', '1995-08-06 01:24:33'),
       (21, 't', 'navy', '2021-03-28 01:01:01', '2021-03-28', '1971-10-24 08:13:11')
GO


-- STORED PROCEDURE DECLARATION

CREATE PROCEDURE UpdateDataLakeTable
AS
BEGIN
    MERGE DataLake WITH (SERIALIZABLE) AS DL
    USING Delta AS D
    ON DL.Id = D.Id
    WHEN MATCHED THEN
        UPDATE
        SET DL.Details        = D.Details,
            DL.Color          = D.Color,
            DL.LastUpdateDate = D.LastUpdateDate,
            DL.Created        = D.Created,
            DL.ExpirationDate = D.ExpirationDate
    WHEN NOT MATCHED THEN
        INSERT (Id, Details, Color, LastUpdateDate, Created, ExpirationDate)
        VALUES (D.Id, D.Details, D.Color, D.LastUpdateDate, D.Created, D.ExpirationDate);
END
GO


-- TEST

BEGIN
    DECLARE @result INT
    EXEC
        @result = UpdateDataLakeTable
    SELECT @result AS result
    SELECT * FROM DataLake
END


-- RESULT

-- Id   Details     Color   LastUpdateDate              Created         ExpirationDate
-- 4	iure	    aqua	1979-04-23 05:28:41.000 	2008-09-24  	2020-06-21 16:17:08.000
-- 5	ut  	    navy	1975-09-01 01:24:41.000	    1994-10-17	    1986-04-04 02:43:28.000
-- 6	qui 	    gray	2013-01-09 17:23:06.000	    1974-12-19	    2017-09-09 21:42:10.000
-- 7	ducimus	    green	1975-08-11 19:15:56.000	    2006-02-05	    2014-10-11 00:21:43.000
-- 8	et	        fuchsia	1991-12-05 20:45:04.000	    1975-02-10	    2008-07-06 15:03:32.000
-- 9	delectus	purple	1999-04-13 04:00:57.000	    2002-10-28	    1982-01-10 13:21:18.000
-- 10	u	        olive	2021-03-28 01:01:01.000	    1989-08-02	    1985-07-11 22:06:26.000
-- 11	p	        olive	2021-03-28 01:01:01.000	    2001-10-19	    1973-03-14 05:06:48.000
-- 12	d       	navy	2021-03-28 01:01:01.000	    2021-01-18	    1971-10-24 08:13:11.000
-- 13	a	        purple	2021-03-28 01:01:01.000	    1970-04-28	    1995-08-06 01:24:33.000
-- 21	t	        navy	2021-03-28 01:01:01.000	    2021-03-28	    1971-10-24 08:13:11.000



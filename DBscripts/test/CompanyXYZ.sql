-- CREATE DATABASE CompanyXYZ;
-- GO

USE CompanyXYZ;
GO


-- TABLES DECLARATION

CREATE TABLE Position
(
    IdPosition INT NOT NULL PRIMARY KEY,
    Name       NVARCHAR(255),
    Deduction  INT,
    Times      INT,
    Salary     INT
);
GO

CREATE TABLE Department
(
    IdDepartment INT NOT NULL PRIMARY KEY,
    Name         NVARCHAR(255),
);
GO

CREATE TABLE Employee
(
    IdEmployee   INT NOT NULL PRIMARY KEY,
    Name         NVARCHAR(255),
    LastName     NVARCHAR(255),
    IdPosition   INT,
    IdDepartment INT,

    CONSTRAINT FK_Position FOREIGN KEY (IdPosition) REFERENCES dbo.Position (IdPosition),
    CONSTRAINT FK_Department FOREIGN KEY (IdDepartment) REFERENCES dbo.Department (IdDepartment)
);
GO


--  DATA INSERTION

INSERT INTO Position (IdPosition, Name, Deduction, Times, Salary)
VALUES (11, 'Sales Manager', 100, 5, 300),
       (22, 'Sales Rep', 20, 4, 100),
       (33, 'CEO', 350, 3, 900)
GO

INSERT INTO Department (IdDepartment, Name)
VALUES (111, 'IT'),
       (222, 'HR'),
       (333, 'SALES')
GO

INSERT INTO Employee (IdEmployee, Name, LastName, IdPosition, IdDepartment)
VALUES (1, 'Fernando', 'Soto', 11, 222),
       (2, 'Erick', 'Santos', 22, 333),
       (3, 'Maria', 'Martinez', 22, 111),
       (4, 'Roberto', 'Gutierrez', 33, 111),
       (5, 'Marta', 'Martinez', 11, 333),
       (6, 'Juan', 'Calvo', 33, 222)
GO


-- STORE PROCEDURE DECLARATION

CREATE PROCEDURE SalariesByDepartment
AS
BEGIN
    SELECT D.Name AS 'Department', SUM((P.Salary - P.Deduction) * P.Times) AS 'Real Salary'
    FROM Department D
             INNER JOIN Employee E on D.IdDepartment = E.IdDepartment
             INNER JOIN Position P on E.IdPosition = P.IdPosition
    GROUP BY D.Name

END
GO


-- TEST

BEGIN
    DECLARE @result INT
    EXEC
        @result = SalariesByDepartment
    SELECT @result AS result
END



-- RESULT

-- Department       Real Salary
--  HR	             2650
--  IT	             1970
--  SALES	         1320

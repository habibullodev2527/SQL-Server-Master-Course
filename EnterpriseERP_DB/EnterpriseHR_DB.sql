/*============================================================================
Project       : EnterpriseHR_DB
Version       : 1.0
Part          : 1.1
Author        : Habibullo Xayrullayev & ChatGPT
Database      : Microsoft SQL Server

===============================================================================

🇺🇿 O'zbekcha

Ushbu loyiha SQL Serverni Advanced darajada o'rganish uchun yaratilmoqda.

Bu database quyidagi mavzular uchun ishlatiladi:

✔ DDL
✔ DML
✔ Constraints
✔ Aggregate Functions
✔ GROUP BY
✔ HAVING
✔ PIVOT
✔ JOIN
✔ CTE
✔ Window Functions
✔ Views
✔ Stored Procedures
✔ Functions
✔ Triggers
✔ Transactions

Maqsad:

Professional Enterprise Database yaratish.

-------------------------------------------------------------------------------

🇬🇧 English

This database is designed for learning SQL Server at an Advanced level.

Topics covered:

✔ DDL
✔ DML
✔ Constraints
✔ Aggregate Functions
✔ GROUP BY
✔ HAVING
✔ PIVOT
✔ JOIN
✔ CTE
✔ Window Functions
✔ Views
✔ Stored Procedures
✔ Functions
✔ Triggers
✔ Transactions

Goal:

Build a Professional Enterprise Database.

============================================================================*/


/*============================================================================
DATABASE
============================================================================*/

IF DB_ID('EnterpriseHR_DB') IS NOT NULL
BEGIN
    ALTER DATABASE EnterpriseHR_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EnterpriseHR_DB;
END
GO

CREATE DATABASE EnterpriseHR_DB;
GO

USE EnterpriseHR_DB;
GO



/*============================================================================

TABLE : Departments

🇺🇿

Vazifasi

Kompaniyadagi barcha bo'limlarni saqlaydi.

Har bir xodim bitta bo'limga tegishli bo'ladi.

Kelajakda quyidagi jadvallar bilan bog'lanadi.

Employees

Projects

🇬🇧

Purpose

Stores all company departments.

Each employee belongs to one department.

Related tables

Employees

Projects

-------------------------------------------------------------------------------

Columns

DepartmentID

UZ

Bo'lim identifikatori.

Primary Key.

Auto Increment.

EN

Department identifier.

Primary Key.

Identity.

------------------------------------------------------------

DepartmentName

UZ

Bo'lim nomi.

Takrorlanishi mumkin emas.

EN

Department name.

Must be unique.

------------------------------------------------------------

Location

UZ

Bo'lim joylashgan shahar.

EN

Department location.

------------------------------------------------------------

Budget

UZ

Yillik budjet.

Manfiy bo'lishi mumkin emas.

EN

Annual budget.

Must be greater than zero.

============================================================================*/

CREATE TABLE Departments
(
    DepartmentID INT IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100) NOT NULL,
    Budget DECIMAL(15,2) NOT NULL,

    CONSTRAINT PK_Departments
        PRIMARY KEY (DepartmentID),

    CONSTRAINT UQ_Departments_DepartmentName
        UNIQUE (DepartmentName),

    CONSTRAINT CHK_Departments_Budget
        CHECK (Budget > 0)
);

GO



/*============================================================================
Sample Data
============================================================================*/

INSERT INTO Departments
(
    DepartmentName,
    Location,
    Budget
)
VALUES
('IT','Tashkent',500000000),
('Finance','Tashkent',350000000),
('Human Resources','Tashkent',180000000),
('Marketing','Samarkand',250000000),
('Sales','Fergana',450000000),
('Support','Bukhara',170000000),
('Research & Development','Tashkent',600000000),
('Logistics','Andijan',280000000);

GO



/*============================================================================

TABLE : Branches

🇺🇿

Kompaniyaning filiallari.

Har bir filialda bir nechta xodim ishlashi mumkin.

Relationship

Branches (1)

↓

Employees (∞)

🇬🇧

Stores company branches.

One branch can have many employees.

-------------------------------------------------------------------------------

Columns

BranchID

Primary Key

Identity

BranchName

Filial nomi.

City

Joylashgan shahar.

Phone

Unique telefon raqami.

Address

To'liq manzil.

============================================================================*/

CREATE TABLE Branches
(
    BranchID INT IDENTITY(1,1),

    BranchName NVARCHAR(100) NOT NULL,

    City NVARCHAR(100) NOT NULL,

    Phone VARCHAR(20) NOT NULL,

    Address NVARCHAR(250) NOT NULL,

    CONSTRAINT PK_Branches
        PRIMARY KEY (BranchID),

    CONSTRAINT UQ_Branches_Phone
        UNIQUE (Phone)
);

GO


/*============================================================================
Sample Data
============================================================================*/

INSERT INTO Branches
(
    BranchName,
    City,
    Phone,
    Address
)
VALUES

('Head Office',
'Tashkent',
'+998901111111',
'Amir Temur Street'),

('Chilonzor',
'Tashkent',
'+998902222222',
'Chilonzor District'),

('Samarkand Branch',
'Samarkand',
'+998903333333',
'Registan Street'),

('Fergana Branch',
'Fergana',
'+998904444444',
'Al-Fargoni Street'),

('Bukhara Branch',
'Bukhara',
'+998905555555',
'Bukhara City Center'),

('Andijan Branch',
'Andijan',
'+998906666666',
'Bobur Avenue');

GO


/*============================================================================

🇺🇿

Departments jadvalidagi barcha ma'lumotlarni ko'rish

🇬🇧

View all departments

============================================================================*/

SELECT *
FROM Departments;

GO

/*============================================================================

Filiallarni ko'rish

View all branches

============================================================================*/

SELECT *
FROM Branches;

GO


/*============================================================================

TABLE : Employees

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Ushbu jadval kompaniyadagi barcha xodimlar haqidagi ma'lumotlarni saqlaydi.

Bu EnterpriseHR_DB dagi eng asosiy jadval hisoblanadi.

Deyarli barcha SQL mavzulari aynan shu jadval orqali o'rganiladi.

Ishlatiladigan mavzular

✔ INNER JOIN
✔ LEFT JOIN
✔ RIGHT JOIN
✔ FULL JOIN
✔ SELF JOIN
✔ GROUP BY
✔ HAVING
✔ Window Functions
✔ Stored Procedures
✔ Triggers

Relationship

Departments (1) -------- (∞) Employees

Branches (1) -------- (∞) Employees

Employees (1) -------- (∞) Orders

Manager (1) -------- (∞) Employees


-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores all employees of the company.

This is the core table of EnterpriseHR_DB.

Most SQL lessons will use this table.

Used in

✔ JOIN
✔ Aggregate Functions
✔ Window Functions
✔ Procedures
✔ Triggers

Relationships

Departments (1) -------- (∞) Employees

Branches (1) -------- (∞) Employees

Manager (1) -------- (∞) Employees

===============================================================================
Columns
===============================================================================

EmployeeID

UZ:
Xodim identifikatori.
Primary Key.
Identity.

EN:
Employee identifier.
Primary Key.
Identity.

-------------------------------------------------------------------------------

FirstName

UZ:
Xodimning ismi.

EN:
Employee first name.

-------------------------------------------------------------------------------

LastName

UZ:
Xodimning familiyasi.

EN:
Employee last name.

-------------------------------------------------------------------------------

Gender

UZ:
Jinsi.

Faqat

'M'

yoki

'F'

bo'lishi mumkin.

EN:
Employee gender.

Allowed values:

'M'

or

'F'

-------------------------------------------------------------------------------

BirthDate

UZ:
Tug'ilgan sana.

EN:
Date of birth.

-------------------------------------------------------------------------------

HireDate

UZ:
Ishga kirgan sana.

EN:
Employment date.

-------------------------------------------------------------------------------

Salary

UZ:
Oylik maosh.

0 dan katta bo'lishi kerak.

EN:
Monthly salary.

Must be greater than zero.

-------------------------------------------------------------------------------

Email

UZ:
Email manzil.

Takrorlanishi mumkin emas.

EN:
Unique email address.

-------------------------------------------------------------------------------

Phone

UZ:
Telefon raqami.

Unique.

EN:
Unique phone number.

-------------------------------------------------------------------------------

Address

UZ:
Yashash manzili.

EN:
Home address.

-------------------------------------------------------------------------------

DepartmentID

UZ:
Departments jadvaliga Foreign Key.

EN:
References Departments table.

-------------------------------------------------------------------------------

BranchID

UZ:
Branches jadvaliga Foreign Key.

EN:
References Branches table.

-------------------------------------------------------------------------------

ManagerID

UZ:
Xodimning rahbari.

Employees jadvalining o'ziga bog'lanadi.

SELF JOIN uchun ishlatiladi.

EN:
Employee manager.

Self Reference.

-------------------------------------------------------------------------------

IsActive

UZ:
Faol xodimmi?

1 = Active

0 = Inactive

EN:
Employee status.

-------------------------------------------------------------------------------

CreatedDate

UZ:
Yaratilgan sana.

EN:
Creation date.

-------------------------------------------------------------------------------

ModifiedDate

UZ:
Oxirgi o'zgartirilgan sana.

EN:
Last modified date.

============================================================================*/

CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL,
    BirthDate DATE NOT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(12,2) NOT NULL,
    Email NVARCHAR(120) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address NVARCHAR(250) NOT NULL,
    DepartmentID INT NOT NULL,
    BranchID INT NOT NULL,
    ManagerID INT NULL,
    IsActive BIT NOT NULL
        CONSTRAINT DF_Employees_IsActive
        DEFAULT(1),
    CreatedDate DATETIME
        CONSTRAINT DF_Employees_CreatedDate
        DEFAULT(GETDATE()),
    ModifiedDate DATETIME NULL,

    CONSTRAINT PK_Employees
        PRIMARY KEY(EmployeeID),

    CONSTRAINT UQ_Employees_Email
        UNIQUE(Email),

    CONSTRAINT UQ_Employees_Phone
        UNIQUE(Phone),

    CONSTRAINT CHK_Employees_Gender
        CHECK(Gender IN ('M','F')),

    CONSTRAINT CHK_Employees_Salary
        CHECK(Salary > 0),

    CONSTRAINT FK_Employees_Departments
        FOREIGN KEY(DepartmentID)
        REFERENCES Departments(DepartmentID),

    CONSTRAINT FK_Employees_Branches
        FOREIGN KEY(BranchID)
        REFERENCES Branches(BranchID)
);

GO

/*============================================================================

🇺🇿

Nima uchun ManagerID ga hozir Foreign Key qo'shmadik?

Sababi jadval yaratilayotgan paytda Employees jadvali hali to'liq
yaratilmagan bo'ladi.

Shuning uchun Self Foreign Key ni keyingi qismda ALTER TABLE
orqali qo'shamiz.

Bu professional usul hisoblanadi.

-------------------------------------------------------------------------------

🇬🇧

Why didn't we create the ManagerID Foreign Key yet?

Because the Employees table is still being created.

The Self Foreign Key will be added later using ALTER TABLE.

This is a professional database design approach.

============================================================================*/


SELECT *
FROM Employees;
GO

/*============================================================================
TABLE : Employees
Sample Data

🇺🇿
Kompaniya xodimlari.

🇬🇧
Company employees.
============================================================================*/

INSERT INTO Employees
(
    FirstName,
    LastName,
    Gender,
    BirthDate,
    HireDate,
    Salary,
    Email,
    Phone,
    Address,
    DepartmentID,
    BranchID,
    ManagerID,
    IsActive
)
VALUES
('Ali','Karimov','M','1995-03-12','2021-01-15',9500000,'ali.karimov@erp.uz','998901000001','Tashkent',1,1,NULL,1),

('Vali','Tursunov','M','1996-05-10','2022-02-20',7800000,'vali.tursunov@erp.uz','998901000002','Tashkent',2,1,1,1),

('Aziza','Rahimova','F','1998-08-25','2023-04-18',6500000,'aziza.rahimova@erp.uz','998901000003','Samarkand',3,2,1,1),

('Madina','Aliyeva','F','1999-01-19','2024-03-11',6200000,'madina.aliyeva@erp.uz','998901000004','Fergana',4,3,2,1),

('Bekzod','Xolmatov','M','1994-11-30','2020-09-01',12000000,'bekzod.xolmatov@erp.uz','998901000005','Bukhara',5,4,1,1),

('Sardor','Ismoilov','M','1997-02-17','2021-05-14',8100000,'sardor.ismoilov@erp.uz','998901000006','Tashkent',6,1,5,1),

('Dilshod','Ergashev','M','1996-07-21','2022-06-10',7300000,'dilshod.ergashev@erp.uz','998901000007','Andijan',1,5,1,1),

('Nilufar','Abdullayeva','F','1998-10-09','2023-07-22',6700000,'nilufar.abdullayeva@erp.uz','998901000008','Namangan',2,5,2,1),

('Javohir','Qodirov','M','1995-12-15','2020-02-15',9800000,'javohir.qodirov@erp.uz','998901000009','Tashkent',5,1,5,1),

('Shahzoda','Rasulova','F','2000-03-01','2024-01-10',5600000,'shahzoda.rasulova@erp.uz','998901000010','Samarkand',3,2,3,1),

('Umid','Jo''rayev','M','1997-09-19','2022-08-18',7500000,'umid.jorayev@erp.uz','998901000011','Jizzakh',4,3,4,1),

('Bobur','Yusupov','M','1993-04-08','2019-06-01',13500000,'bobur.yusupov@erp.uz','998901000012','Tashkent',1,1,NULL,1),

('Malika','Karimova','F','1998-06-13','2023-05-09',6400000,'malika.karimova@erp.uz','998901000013','Fergana',6,4,6,1),

('Akmal','Ruziboyev','M','1992-02-28','2018-11-11',15000000,'akmal.ruziboyev@erp.uz','998901000014','Bukhara',2,4,NULL,1),

('Muhammad','Sobirov','M','1999-08-11','2024-02-05',5900000,'muhammad.sobirov@erp.uz','998901000015','Andijan',5,5,5,1),

('Sevara','Nurmatova','F','1997-07-05','2022-04-12',7100000,'sevara.nurmatova@erp.uz','998901000016','Namangan',1,5,12,1),

('Azamat','Hamroyev','M','1995-05-15','2021-10-01',8200000,'azamat.hamroyev@erp.uz','998901000017','Tashkent',2,1,14,1),

('Doston','Oripov','M','1998-09-22','2023-09-15',6800000,'doston.oripov@erp.uz','998901000018','Samarkand',4,2,4,1),

('Zarina','Mamatova','F','1996-12-10','2021-07-01',7600000,'zarina.mamatova@erp.uz','998901000019','Bukhara',3,4,3,1),

('Sherzod','Toshpo''latov','M','1994-01-01','2020-01-20',11000000,'sherzod.toshpolatov@erp.uz','998901000020','Tashkent',5,1,12,1);


/*============================================================================

TABLE : Employees

PART 1.2C

SELF FOREIGN KEY

===============================================================================

🇺🇿

ManagerID ustuni Employees jadvalining o'ziga bog'lanadi.

Bu degani:

Har bir xodimning rahbari ham Employees jadvalidagi boshqa
bir xodim hisoblanadi.

Bu bog'lanish keyinchalik SELF JOIN mavzusini o'rganishda ishlatiladi.

Misol:

Akmal
│
├── Ali
├── Vali
├── Aziza

Akmal ham Employees jadvalida mavjud.

-------------------------------------------------------------------------------

🇬🇧

ManagerID references Employees(EmployeeID).

Each employee may have another employee as a manager.

This relationship will be used in SELF JOIN lessons.

============================================================================*/


ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Manager
FOREIGN KEY (ManagerID)
REFERENCES Employees(EmployeeID);

GO

/*============================================================

🇺🇿

Barcha xodimlarni ko'rish

🇬🇧

View all employees

============================================================*/

SELECT *
FROM Employees;

GO

/*============================================================

Faol xodimlar

Active Employees

============================================================*/

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE IsActive = 1;

GO


/*============================================================

IT bo'limidagi xodimlar

Employees in IT Department

============================================================*/

SELECT
    FirstName,
    LastName,
    Salary
FROM Employees
WHERE DepartmentID = 1;

GO

/*============================================================

Eng katta maosh

Highest Salary

============================================================*/

SELECT MAX(Salary) AS HighestSalary
FROM Employees;

GO


/*============================================================

Eng kichik maosh

Lowest Salary

============================================================*/

SELECT MIN(Salary) AS LowestSalary
FROM Employees;

GO


/*============================================================

O'rtacha maosh

Average Salary

============================================================*/

SELECT AVG(Salary) AS AverageSalary
FROM Employees;

GO


/*============================================================

Faol xodimlar soni

Number of Active Employees

============================================================*/

SELECT COUNT(*) AS ActiveEmployees
FROM Employees
WHERE IsActive = 1;

GO

/*============================================================================

🇺🇿

Nima uchun ManagerID alohida Foreign Key?

Sababi kompaniyada menejer ham oddiy xodim hisoblanadi.

Shuning uchun alohida Managers jadvali yaratish shart emas.

Bu Database Normalization qoidalariga mos keladi.

Keyinchalik SELF JOIN orqali

Employee  ←→ Manager

bog'lanishini olamiz.

-------------------------------------------------------------------------------

🇬🇧

Why is ManagerID a Self Foreign Key?

Because managers are also employees.

There is no need to create a separate Managers table.

This follows database normalization principles.

SELF JOIN will be used later to retrieve

Employee ←→ Manager

relationships.

============================================================================*/



/*============================================================================

TABLE : Projects

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Ushbu jadval kompaniyada olib borilayotgan barcha loyihalarni saqlaydi.

Har bir loyiha bitta bo'limga tegishli bo'ladi.

Misol:

• CRM System
• ERP System
• Mobile Banking
• AI Chatbot

Relationship

Departments (1) -------- (∞) Projects

-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores all company projects.

Each project belongs to one department.

Relationship

Departments (1) -------- (∞) Projects

============================================================================*/

CREATE TABLE Projects
(
    ProjectID INT IDENTITY(1,1),

    ProjectName NVARCHAR(150) NOT NULL,

    DepartmentID INT NOT NULL,

    Budget DECIMAL(15,2) NOT NULL,

    StartDate DATE NOT NULL,

    EndDate DATE NULL,

    Status NVARCHAR(30) NOT NULL,

    CONSTRAINT PK_Projects
        PRIMARY KEY(ProjectID),

    CONSTRAINT CHK_ProjectBudget
        CHECK(Budget > 0),

    CONSTRAINT CHK_ProjectStatus
        CHECK(Status IN
        (
            'Planning',
            'In Progress',
            'Completed',
            'Cancelled'
        )),

    CONSTRAINT FK_Projects_Department
        FOREIGN KEY(DepartmentID)
        REFERENCES Departments(DepartmentID)
);

GO


INSERT INTO Projects
(
    ProjectName,
    DepartmentID,
    Budget,
    StartDate,
    EndDate,
    Status
)
VALUES
('Enterprise ERP System',1,1200000000,'2025-01-10',NULL,'In Progress'),

('HR Management System',3,300000000,'2025-02-15',NULL,'Planning'),

('Finance Automation',2,550000000,'2024-06-01','2025-05-20','Completed'),

('Marketing Analytics',4,250000000,'2025-03-01',NULL,'In Progress'),

('Sales CRM',5,450000000,'2025-04-10',NULL,'Planning'),

('Customer Support Portal',6,350000000,'2024-11-10',NULL,'In Progress'),

('Inventory System',5,700000000,'2025-05-01',NULL,'Planning'),

('AI Recommendation Engine',1,900000000,'2025-06-01',NULL,'Planning');

GO


/*============================================================================

TABLE : EmployeeProjects

===============================================================================

🇺🇿

Bu jadval Employees va Projects orasidagi

Many-to-Many

bog'lanishni saqlaydi.

Bitta xodim

↓

Ko'plab loyihalarda ishlashi mumkin.

Bitta loyiha

↓

Ko'plab xodimlarga ega bo'lishi mumkin.

Shuning uchun bridge table ishlatilmoqda.

-------------------------------------------------------------------------------

🇬🇧

Bridge table between

Employees

and

Projects.

Many employees can work on many projects.

============================================================================*/


CREATE TABLE EmployeeProjects
(
    EmployeeProjectID INT IDENTITY(1,1),

    EmployeeID INT NOT NULL,

    ProjectID INT NOT NULL,

    ProjectRole NVARCHAR(80) NOT NULL,

    HoursWorked INT NOT NULL,

    AssignedDate DATE NOT NULL,

    CONSTRAINT PK_EmployeeProjects
        PRIMARY KEY(EmployeeProjectID),

    CONSTRAINT CHK_HoursWorked
        CHECK(HoursWorked >= 0),

    CONSTRAINT FK_EP_Employee
        FOREIGN KEY(EmployeeID)
        REFERENCES Employees(EmployeeID),

    CONSTRAINT FK_EP_Project
        FOREIGN KEY(ProjectID)
        REFERENCES Projects(ProjectID)
);

GO



INSERT INTO EmployeeProjects
(
    EmployeeID,
    ProjectID,
    ProjectRole,
    HoursWorked,
    AssignedDate
)
VALUES

(1,1,'Project Manager',180,'2025-01-10'),

(2,1,'Backend Developer',165,'2025-01-12'),

(3,1,'Frontend Developer',150,'2025-01-12'),

(4,2,'HR Specialist',120,'2025-02-18'),

(5,3,'Finance Manager',210,'2024-06-02'),

(6,4,'Marketing Analyst',135,'2025-03-05'),

(7,5,'Sales Consultant',142,'2025-04-15'),

(8,6,'Support Engineer',175,'2024-11-15'),

(9,7,'Business Analyst',130,'2025-05-04'),

(10,8,'AI Engineer',160,'2025-06-05'),

(11,1,'Database Administrator',150,'2025-01-15'),

(12,8,'ML Engineer',175,'2025-06-10'),

(13,5,'Sales Manager',165,'2025-04-18'),

(14,3,'Financial Analyst',140,'2024-06-15'),

(15,2,'Recruiter',110,'2025-02-20'),

(16,4,'SEO Specialist',125,'2025-03-10'),

(17,7,'Inventory Controller',145,'2025-05-07'),

(18,6,'Support Specialist',150,'2024-11-20'),

(19,8,'Data Scientist',185,'2025-06-12'),

(20,1,'QA Engineer',155,'2025-01-18');

GO



-- Barcha loyihalar
SELECT *
FROM Projects;

-- Loyiha taqsimotlari
SELECT *
FROM EmployeeProjects;

-- Har bir loyihada nechta xodim ishlayapti?
SELECT
    ProjectID,
    COUNT(EmployeeID) AS EmployeeCount
FROM EmployeeProjects
GROUP BY ProjectID;


🇺🇿

Nima uchun EmployeeProjects jadvali kerak?

Agar EmployeeID ni to'g'ridan-to'g'ri Projects jadvaliga yozsak,
bitta loyiha faqat bitta xodimga tegishli bo'lib qoladi.

Aslida esa:

1 loyiha → 20 ta xodim

1 xodim → 5 ta loyiha

bo'lishi mumkin.

Shuning uchun Many-to-Many relationship ishlatiladi.

🇬🇧

Why do we need EmployeeProjects?

A project can have many employees,
and an employee can work on many projects.

This is a classic Many-to-Many relationship,
implemented using a bridge table.




/*============================================================================

TABLE : Categories

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Mahsulotlarni kategoriyalarga ajratish uchun ishlatiladi.

Misollar

• Laptop
• Monitor
• Printer
• Networking
• Furniture

Relationship

Categories (1)
        │
        │
        ▼
Products (∞)

Har bir kategoriyada ko'plab mahsulotlar bo'lishi mumkin.

-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores product categories.

Examples

• Laptop
• Monitor
• Printer
• Networking
• Furniture

Relationship

Categories (1)
        │
        ▼
Products (∞)

One category can contain many products.

============================================================================*/



CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1),

    CategoryName NVARCHAR(100) NOT NULL,

    Description NVARCHAR(300),

    CONSTRAINT PK_Categories
        PRIMARY KEY(CategoryID),

    CONSTRAINT UQ_Categories_Name
        UNIQUE(CategoryName)
);

GO


INSERT INTO Categories
(
    CategoryName,
    Description
)
VALUES
('Laptop','Notebook computers'),

('Desktop','Desktop computers'),

('Monitor','Computer monitors'),

('Printer','Printing devices'),

('Networking','Network devices'),

('Furniture','Office furniture'),

('Accessories','Computer accessories'),

('Software','Licensed software');

GO


/*============================================================================

TABLE : Products

===============================================================================

🇺🇿

Vazifasi

Kompaniya sotadigan barcha mahsulotlarni saqlaydi.

Kelajakda quyidagi mavzularda ishlatiladi.

✔ JOIN

✔ GROUP BY

✔ HAVING

✔ Window Functions

✔ Inventory Reports

Relationship

Categories (1)

↓

Products (∞)

-------------------------------------------------------------------------------

🇬🇧

Purpose

Stores all company products.

Used for

✔ Inventory

✔ Reports

✔ JOIN

✔ GROUP BY

✔ Window Functions

Relationship

Categories (1)

↓

Products (∞)

===============================================================================

Columns

ProductID

Primary Key

Identity

-------------------------------------------------------------------------------

ProductName

Mahsulot nomi

-------------------------------------------------------------------------------

CategoryID

Foreign Key

-------------------------------------------------------------------------------

SKU

Stock Keeping Unit

Mahsulot kodi

Unique

-------------------------------------------------------------------------------

UnitPrice

Narxi

-------------------------------------------------------------------------------

StockQuantity

Ombordagi soni

-------------------------------------------------------------------------------

ReorderLevel

Minimal zaxira

Agar StockQuantity bundan kamaysa

qayta buyurtma qilish kerak.

-------------------------------------------------------------------------------

Discontinued

1 = Sotuvda emas

0 = Sotuvda

============================================================================*/



CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1),

    ProductName NVARCHAR(150) NOT NULL,

    CategoryID INT NOT NULL,

    SKU VARCHAR(30) NOT NULL,

    UnitPrice DECIMAL(12,2) NOT NULL,

    StockQuantity INT NOT NULL,

    ReorderLevel INT NOT NULL,

    Discontinued BIT NOT NULL
        DEFAULT(0),

    CreatedDate DATETIME
        DEFAULT(GETDATE()),

    CONSTRAINT PK_Products
        PRIMARY KEY(ProductID),

    CONSTRAINT UQ_Products_SKU
        UNIQUE(SKU),

    CONSTRAINT CHK_Products_Price
        CHECK(UnitPrice>0),

    CONSTRAINT CHK_Products_Stock
        CHECK(StockQuantity>=0),

    CONSTRAINT CHK_Products_Reorder
        CHECK(ReorderLevel>=0),

    CONSTRAINT FK_Products_Category
        FOREIGN KEY(CategoryID)
        REFERENCES Categories(CategoryID)
);

GO


INSERT INTO Products
(
ProductName,
CategoryID,
SKU,
UnitPrice,
StockQuantity,
ReorderLevel,
Discontinued
)

VALUES

('Dell Latitude 5540',1,'LAP001',14500000,25,5,0),

('HP ProBook 450',1,'LAP002',13200000,18,5,0),

('Lenovo ThinkPad E16',1,'LAP003',15600000,12,4,0),

('Dell OptiPlex 7010',2,'DES001',10800000,10,3,0),

('HP EliteDesk 800',2,'DES002',11500000,9,3,0),

('LG 24 Monitor',3,'MON001',2600000,40,8,0),

('Samsung 27 Monitor',3,'MON002',3900000,22,6,0),

('Canon LBP2900',4,'PRN001',3200000,13,4,0),

('HP LaserJet Pro',4,'PRN002',6100000,8,2,0),

('Cisco Router',5,'NET001',8200000,11,3,0),

('Cisco Switch 24-Port',5,'NET002',5600000,14,3,0),

('Office Chair',6,'FUR001',1800000,35,10,0),

('Office Desk',6,'FUR002',3400000,20,5,0),

('Wireless Mouse',7,'ACC001',180000,120,20,0),

('Mechanical Keyboard',7,'ACC002',650000,70,15,0),

('Microsoft Office 365',8,'SOF001',1500000,9999,0,0),

('Windows 11 Pro',8,'SOF002',2200000,9999,0,0),

('Logitech Webcam',7,'ACC003',890000,45,10,0),

('TP-Link Router',5,'NET003',1250000,30,8,0),

('Brother Printer',4,'PRN003',4800000,9,2,0);

GO


-- Barcha kategoriyalar
SELECT *
FROM Categories;

GO

-- Barcha mahsulotlar
SELECT *
FROM Products;

GO

-- Omborda 20 tadan kam qolgan mahsulotlar
SELECT
ProductName,
StockQuantity
FROM Products
WHERE StockQuantity<20;

GO

-- Eng qimmat mahsulot
SELECT TOP 1 *
FROM Products
ORDER BY UnitPrice DESC;

GO


/*============================================================================

🇺🇿

SKU nima?

SKU (Stock Keeping Unit)

Har bir mahsulot uchun yagona kod.

Masalan

LAP001

NET002

ACC005

Real kompaniyalarda mahsulotlar
ProductID emas,

aynan SKU orqali qidiriladi.

-------------------------------------------------------------------------------

🇬🇧

What is SKU?

Stock Keeping Unit

A unique code for each product.

In real companies

products are searched by SKU
rather than ProductID.

============================================================================*/




/*============================================================================

TABLE : Suppliers

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Ushbu jadval kompaniyaga mahsulot yetkazib beruvchi
barcha supplierlarni saqlaydi.

Misollar:

• Dell Uzbekistan
• HP Uzbekistan
• Cisco Partner
• Artel
• Lenovo Distributor

Relationship

Suppliers (1)
      │
      ▼
SupplierProducts (∞)

-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores all suppliers.

Examples:

• Dell
• HP
• Cisco
• Lenovo

Relationship

Suppliers (1)
      │
      ▼
SupplierProducts (∞)

============================================================================*/




CREATE TABLE Suppliers
(
    SupplierID INT IDENTITY(1,1),

    SupplierName NVARCHAR(150) NOT NULL,

    ContactPerson NVARCHAR(100) NOT NULL,

    Phone VARCHAR(20) NOT NULL,

    Email NVARCHAR(120),

    Country NVARCHAR(80),

    City NVARCHAR(80),

    IsActive BIT NOT NULL
        DEFAULT(1),

    CONSTRAINT PK_Suppliers
        PRIMARY KEY(SupplierID),

    CONSTRAINT UQ_SupplierName
        UNIQUE(SupplierName),

    CONSTRAINT UQ_SupplierPhone
        UNIQUE(Phone)
);

GO


INSERT INTO Suppliers
(
SupplierName,
ContactPerson,
Phone,
Email,
Country,
City
)

VALUES

('Dell Uzbekistan','Aziz Karimov','998901111001','dell@erp.uz','Uzbekistan','Tashkent'),

('HP Uzbekistan','Ali Tursunov','998901111002','hp@erp.uz','Uzbekistan','Tashkent'),

('Lenovo Central Asia','Bekzod Xasanov','998901111003','lenovo@erp.uz','Uzbekistan','Tashkent'),

('Cisco Partner','Jasur Ergashev','998901111004','cisco@erp.uz','Uzbekistan','Tashkent'),

('Canon Distributor','Dilshod Rahimov','998901111005','canon@erp.uz','Uzbekistan','Samarkand'),

('Microsoft Licensing','Madina Aliyeva','998901111006','microsoft@erp.uz','Ireland','Dublin'),

('Logitech Official','Umid Sobirov','998901111007','logitech@erp.uz','Switzerland','Lausanne'),

('TP-Link Uzbekistan','Azamat Karimov','998901111008','tplink@erp.uz','China','Shenzhen');

GO



/*============================================================================

TABLE : SupplierProducts

===============================================================================

🇺🇿

Bridge Table

Products

∞ ------------- ∞

Suppliers

Nima uchun?

Laptopni faqat bitta supplier emas,
bir nechta supplier yetkazib berishi mumkin.

Shuningdek bitta supplier ham
ko'plab mahsulotlarni sotishi mumkin.

-------------------------------------------------------------------------------

🇬🇧

Bridge table

Many-to-Many

Products

∞ -------- ∞

Suppliers

============================================================================*/



CREATE TABLE SupplierProducts
(
    SupplierProductID INT IDENTITY(1,1),

    SupplierID INT NOT NULL,

    ProductID INT NOT NULL,

    SupplierPrice DECIMAL(12,2) NOT NULL,

    DeliveryDays INT NOT NULL,

    IsPreferredSupplier BIT NOT NULL
        DEFAULT(0),

    CONSTRAINT PK_SupplierProducts
        PRIMARY KEY(SupplierProductID),

    CONSTRAINT FK_SP_Supplier
        FOREIGN KEY(SupplierID)
        REFERENCES Suppliers(SupplierID),

    CONSTRAINT FK_SP_Product
        FOREIGN KEY(ProductID)
        REFERENCES Products(ProductID),

    CONSTRAINT CHK_SupplierPrice
        CHECK(SupplierPrice>0),

    CONSTRAINT CHK_DeliveryDays
        CHECK(DeliveryDays>0)
);

GO



INSERT INTO SupplierProducts
(
SupplierID,
ProductID,
SupplierPrice,
DeliveryDays,
IsPreferredSupplier
)

VALUES

(1,1,13800000,5,1),

(2,2,12600000,4,1),

(3,3,14900000,7,1),

(4,10,7800000,10,1),

(4,11,5300000,8,1),

(5,8,2900000,5,1),

(5,9,5600000,7,0),

(6,16,1350000,1,1),

(6,17,2050000,1,1),

(7,14,150000,4,1),

(7,15,610000,5,1),

(7,18,820000,5,0),

(8,19,1150000,3,1),

(1,3,15100000,8,0),

(2,1,14000000,6,0),

(3,2,12800000,5,0),

(5,20,4500000,6,1);

GO


-- Barcha supplierlar
SELECT *
FROM Suppliers;

GO

-- Supplier va mahsulot bog'lanishlari
SELECT *
FROM SupplierProducts;

GO

-- Eng arzon supplier narxlari
SELECT
ProductID,
MIN(SupplierPrice) AS LowestSupplierPrice
FROM SupplierProducts
GROUP BY ProductID;

GO


/*============================================================================

🇺🇿

Nega SupplierID ni Products jadvaliga qo'shmadik?

Sababi:

Dell Laptop

↓

Dell

HP Store

ABC Technology

uchalasi ham sotishi mumkin.

Shuning uchun

Many-to-Many

relationship ishlatiladi.

-------------------------------------------------------------------------------

🇬🇧

Why isn't SupplierID stored directly
inside Products?

Because one product may have multiple suppliers.

Therefore

Many-to-Many

relationship is required.

============================================================================*/


/*============================================================================

TABLE : Customers

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Ushbu jadval kompaniyaning barcha mijozlarini saqlaydi.

Mijoz:
- Jismoniy shaxs
- Yuridik shaxs (Kompaniya)

Har bir mijoz ko'plab buyurtmalar berishi mumkin.

Relationship

Customers (1)
      │
      ▼
Orders (∞)

-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores all customers.

A customer may be

• Individual

• Company

Relationship

Customers (1)
      │
      ▼
Orders (∞)

============================================================================*/

CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1),

    CompanyName NVARCHAR(150) NOT NULL,

    ContactPerson NVARCHAR(100) NOT NULL,

    Phone VARCHAR(20) NOT NULL,

    Email NVARCHAR(120),

    Country NVARCHAR(80) NOT NULL,

    City NVARCHAR(80) NOT NULL,

    Address NVARCHAR(250),

    CreatedDate DATETIME
        DEFAULT(GETDATE()),

    IsActive BIT
        DEFAULT(1),

    CONSTRAINT PK_Customers
        PRIMARY KEY(CustomerID),

    CONSTRAINT UQ_Customers_Phone
        UNIQUE(Phone),

    CONSTRAINT UQ_Customers_Email
        UNIQUE(Email)
);

GO


INSERT INTO Customers
(
    CompanyName,
    ContactPerson,
    Phone,
    Email,
    Country,
    City,
    Address
)
VALUES
('Tech Solutions LLC','Ali Karimov','998911000001','info@techsolutions.uz','Uzbekistan','Tashkent','Amir Temur Street'),

('Digital World','Aziza Rahimova','998911000002','sales@digitalworld.uz','Uzbekistan','Samarkand','Registan Street'),

('Smart Office','Bekzod Xasanov','998911000003','office@smartoffice.uz','Uzbekistan','Bukhara','City Center'),

('IT Group','Madina Aliyeva','998911000004','admin@itgroup.uz','Uzbekistan','Andijan','Bobur Avenue'),

('Future Systems','Jasur Ergashev','998911000005','contact@future.uz','Uzbekistan','Fergana','Al-Fargoni Street'),

('Alpha Trade','Umid Sobirov','998911000006','info@alpha.uz','Uzbekistan','Namangan','Navoi Street'),

('Global Business','Dilshod Qodirov','998911000007','sales@global.uz','Uzbekistan','Tashkent','Yunusobod'),

('Mega Market','Shahzoda Rasulova','998911000008','info@mega.uz','Uzbekistan','Nukus','Central Avenue'),

('Premium Service','Sherzod Hamroyev','998911000009','support@premium.uz','Uzbekistan','Jizzakh','Mustaqillik Street'),

('Ideal Tech','Malika Karimova','998911000010','info@idealtech.uz','Uzbekistan','Tashkent','Chilonzor');

GO



/*============================================================================

TABLE : Orders

===============================================================================

🇺🇿

Vazifasi

Har bir mijozning buyurtmasini saqlaydi.

Har bir buyurtma

• bitta mijozga

• bitta sotuv menejeriga

tegishli bo'ladi.

Relationship

Customers (1)
        │
        ▼
Orders (∞)

Employees (1)
        │
        ▼
Orders (∞)

-------------------------------------------------------------------------------

🇬🇧

Purpose

Stores customer orders.

Each order belongs to

• one customer

• one employee

============================================================================*/

CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1),

    CustomerID INT NOT NULL,

    EmployeeID INT NOT NULL,

    OrderDate DATE NOT NULL,

    RequiredDate DATE NOT NULL,

    ShippedDate DATE NULL,

    Status NVARCHAR(30) NOT NULL,

    ShippingAddress NVARCHAR(250),

    Notes NVARCHAR(500),

    CreatedDate DATETIME
        DEFAULT(GETDATE()),

    CONSTRAINT PK_Orders
        PRIMARY KEY(OrderID),

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY(CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT FK_Orders_Employees
        FOREIGN KEY(EmployeeID)
        REFERENCES Employees(EmployeeID),

    CONSTRAINT CHK_OrderStatus
        CHECK
        (
            Status IN
            (
                'Pending',
                'Processing',
                'Shipped',
                'Delivered',
                'Cancelled'
            )
        )
);

GO


INSERT INTO Orders
(
CustomerID,
EmployeeID,
OrderDate,
RequiredDate,
ShippedDate,
Status,
ShippingAddress,
Notes
)
VALUES

(1,5,'2025-01-10','2025-01-15','2025-01-14','Delivered','Tashkent','Urgent'),

(2,7,'2025-01-15','2025-01-20','2025-01-18','Delivered','Samarkand',''),

(3,6,'2025-02-02','2025-02-08',NULL,'Processing','Bukhara','Priority'),

(4,9,'2025-02-15','2025-02-21',NULL,'Pending','Andijan',''),

(5,10,'2025-03-01','2025-03-06','2025-03-05','Delivered','Fergana',''),

(6,5,'2025-03-18','2025-03-25',NULL,'Processing','Namangan',''),

(7,8,'2025-04-10','2025-04-15',NULL,'Pending','Tashkent',''),

(8,7,'2025-04-20','2025-04-26','2025-04-25','Delivered','Nukus',''),

(9,6,'2025-05-05','2025-05-10',NULL,'Cancelled','Jizzakh','Customer cancelled'),

(10,9,'2025-05-12','2025-05-18','2025-05-16','Shipped','Tashkent','');

GO


-- Barcha mijozlar
SELECT *
FROM Customers;

GO

-- Barcha buyurtmalar
SELECT *
FROM Orders;

GO

-- Yetkazib berilgan buyurtmalar
SELECT *
FROM Orders
WHERE Status='Delivered';

GO

-- Bekor qilingan buyurtmalar
SELECT *
FROM Orders
WHERE Status='Cancelled';

GO



/*============================================================================

🇺🇿

Nima uchun CustomerName ni Orders jadvaliga yozmadik?

Sababi:

Database Normalization.

Customer ma'lumotlari faqat Customers jadvalida saqlanadi.

Orders jadvali esa faqat CustomerID ni saqlaydi.

Bu ortiqcha ma'lumot takrorlanishini oldini oladi.

-------------------------------------------------------------------------------

🇬🇧

Why don't we store CustomerName in Orders?

Because of Database Normalization.

Customer information is stored only once
inside the Customers table.

Orders stores only CustomerID.

============================================================================*/

/*--
🇺🇿

Nima uchun Orders jadvalida EmployeeID mavjud?

Javob:

Chunki har bir buyurtmani qaysi xodim rasmiylashtirganini bilishimiz kerak.

🇬🇧

Why does Orders contain EmployeeID?

Because every order should be linked to the employee who created it.

--*/


/*============================================================================

TABLE : OrderDetails

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Buyurtma tarkibidagi mahsulotlarni saqlaydi.

Har bir yozuv:

• Bitta buyurtma
• Bitta mahsulot

ni ifodalaydi.

Relationship

Orders (1)
      │
      ▼
OrderDetails (∞)

Products (1)
      │
      ▼
OrderDetails (∞)

-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores products included in each order.

Each record represents

• One Order

• One Product

Relationship

Orders (1)
      │
      ▼
OrderDetails (∞)

Products (1)
      │
      ▼
OrderDetails (∞)

============================================================================*/


CREATE TABLE OrderDetails
(
    OrderDetailID INT IDENTITY(1,1),

    OrderID INT NOT NULL,

    ProductID INT NOT NULL,

    Quantity INT NOT NULL,

    UnitPrice DECIMAL(12,2) NOT NULL,

    Discount DECIMAL(5,2)
        DEFAULT(0),

    CONSTRAINT PK_OrderDetails
        PRIMARY KEY(OrderDetailID),

    CONSTRAINT FK_OrderDetails_Order
        FOREIGN KEY(OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Product
        FOREIGN KEY(ProductID)
        REFERENCES Products(ProductID),

    CONSTRAINT CHK_OrderDetails_Quantity
        CHECK(Quantity>0),

    CONSTRAINT CHK_OrderDetails_Price
        CHECK(UnitPrice>0),

    CONSTRAINT CHK_OrderDetails_Discount
        CHECK(Discount>=0 AND Discount<=100)
);

GO


INSERT INTO OrderDetails
(
OrderID,
ProductID,
Quantity,
UnitPrice,
Discount
)

VALUES

(1,1,2,14500000,5),

(1,14,2,180000,0),

(2,6,4,2600000,10),

(2,15,5,650000,0),

(3,10,1,8200000,3),

(3,19,2,1250000,0),

(4,3,3,15600000,5),

(5,8,2,3200000,0),

(5,18,1,890000,0),

(6,13,6,3400000,7),

(7,2,2,13200000,5),

(8,5,1,11500000,0),

(8,17,10,2200000,15),

(9,4,1,10800000,0),

(10,20,2,4800000,4);

GO



SELECT *
FROM OrderDetails;


/*============================================================================

🇺🇿

Nega UnitPrice Products jadvalidan olinmaydi?

Sababi:

Mahsulot narxi vaqt o'tishi bilan o'zgarishi mumkin.

Masalan:

2025-yilda Laptop = 14 500 000

2026-yilda Laptop = 15 700 000

Eski buyurtmalarning narxi o'zgarmasligi uchun
UnitPrice OrderDetails jadvalida ham saqlanadi.

-------------------------------------------------------------------------------

🇬🇧

Why do we store UnitPrice here?

Because product prices change over time.

Old orders should keep the original selling price.

Therefore UnitPrice is stored inside OrderDetails.

============================================================================*/


/*============================================================================

TABLE : Payments

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Ushbu jadval mijozlarning to'lovlarini saqlaydi.

Bir buyurtma uchun:

• 1 ta to'lov
yoki

• Bir nechta qisman to'lov bo'lishi mumkin.

Misol

Order #15

01. Cash          2 000 000

02. Card          5 000 000

03. Bank          3 000 000

Relationship

Orders (1)
      │
      ▼
Payments (∞)

-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores customer payments.

One order may have

• one payment

or

• multiple partial payments.

Relationship

Orders (1)

↓

Payments (∞)

============================================================================*/


CREATE TABLE Payments
(
    PaymentID INT IDENTITY(1,1),

    OrderID INT NOT NULL,

    PaymentDate DATE NOT NULL,

    PaymentMethod NVARCHAR(30) NOT NULL,

    Amount DECIMAL(15,2) NOT NULL,

    TransactionReference NVARCHAR(100) NULL,

    PaymentStatus NVARCHAR(20) NOT NULL,

    Notes NVARCHAR(300),

    CreatedDate DATETIME
        DEFAULT(GETDATE()),

    CONSTRAINT PK_Payments
        PRIMARY KEY(PaymentID),

    CONSTRAINT FK_Payments_Orders
        FOREIGN KEY(OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT CHK_PaymentAmount
        CHECK(Amount>0),

    CONSTRAINT CHK_Payments_PaymentMethod
	CHECK
	(
		PaymentMethod IN
		(
			'Cash',
			'Card',
			'Bank Transfer',
			'Click',
			'Payme'
		)
	),

    CONSTRAINT CHK_PaymentStatus
        CHECK
        (
            PaymentStatus IN
            (
                'Pending',
                'Completed',
                'Failed',
                'Refunded'
            )
        )
);

GO
INSERT INTO Payments
(
    OrderID,
    PaymentDate,
    PaymentMethod,
    Amount,
    TransactionReference,
    PaymentStatus,
    Notes
)
VALUES
(1,'2025-01-14','Card',29360000,'TXN100001','Completed',NULL),

(2,'2025-01-18','Cash',13650000,NULL,'Completed',NULL),

(3,'2025-02-05','Bank Transfer',8450000,'BNK45001','Completed',NULL),

(4,'2025-02-16','Click',5000000,'CLK22001','Pending','First Payment'),

(4,'2025-02-20','Click',12000000,'CLK22002','Completed','Final Payment'),

(5,'2025-03-05','Payme',7290000,'PAY33001','Completed',NULL),

(6,'2025-03-19','Bank Transfer',18972000,'BNK45002','Completed',NULL),

(7,'2025-04-10','Cash',26400000,NULL,'Completed',NULL),

(8,'2025-04-25','Card',33200000,'TXN100010','Completed',NULL),

(9,'2025-05-06','Card',10800000,'TXN100011','Refunded','Order Cancelled'),

(10,'2025-05-16','Bank Transfer',9216000,'BNK45003','Completed',NULL);


SELECT *
FROM Payments;




/*============================================================================

🇺🇿

Nima uchun Payments alohida jadval?

Sababi

Bitta buyurtma

↓

Bir nechta to'lovga ega bo'lishi mumkin.

Misol

Cash

+

Card

+

Bank

Shu sababli

Orders

↓

Payments

One-to-Many

relationship ishlatiladi.

-------------------------------------------------------------------------------

🇬🇧

Why is Payments a separate table?

One order may have

multiple payments.

Example

Cash

+

Card

+

Bank Transfer

Therefore

Orders

↓

Payments

uses

One-to-Many

relationship.

============================================================================*/


/*============================================================================

TABLE : Attendance

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Xodimlarning ishga kelish davomatini saqlaydi.

Har bir yozuv:

• Bitta xodim
• Bitta sana

uchun yaratiladi.

Relationship

Employees (1)
      │
      ▼
Attendance (∞)

-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores employee attendance records.

Each record represents

• One Employee
• One Date

Relationship

Employees (1)
      │
      ▼
Attendance (∞)

============================================================================*/



CREATE TABLE Attendance
(
    AttendanceID INT IDENTITY(1,1),

    EmployeeID INT NOT NULL,

    AttendanceDate DATE NOT NULL,

    CheckIn TIME NULL,

    CheckOut TIME NULL,

    Status NVARCHAR(20) NOT NULL,

    Notes NVARCHAR(250),

    CONSTRAINT PK_Attendance
        PRIMARY KEY(AttendanceID),

    CONSTRAINT FK_Attendance_Employees
        FOREIGN KEY(EmployeeID)
        REFERENCES Employees(EmployeeID),

    CONSTRAINT CHK_Attendance_Status
        CHECK
        (
            Status IN
            (
                'Present',
                'Absent',
                'Late',
                'Leave'
            )
        ),

    CONSTRAINT UQ_Attendance
        UNIQUE(EmployeeID, AttendanceDate)
);

GO


INSERT INTO Attendance
(
EmployeeID,
AttendanceDate,
CheckIn,
CheckOut,
Status,
Notes
)

VALUES

(1,'2025-07-01','08:55','18:02','Present',NULL),

(2,'2025-07-01','09:18','18:01','Late','Traffic'),

(3,'2025-07-01',NULL,NULL,'Leave','Annual Leave'),

(4,'2025-07-01',NULL,NULL,'Absent','No Notification'),

(5,'2025-07-01','08:40','17:55','Present',NULL),

(6,'2025-07-01','08:58','18:05','Present',NULL),

(7,'2025-07-01','09:10','18:03','Late',NULL),

(8,'2025-07-01','08:47','17:59','Present',NULL),

(9,'2025-07-01',NULL,NULL,'Absent','Sick'),

(10,'2025-07-01','08:51','18:07','Present',NULL),

(11,'2025-07-01','08:56','18:01','Present',NULL),

(12,'2025-07-01','09:22','18:15','Late','Meeting'),

(13,'2025-07-01','08:49','17:58','Present',NULL),

(14,'2025-07-01',NULL,NULL,'Leave','Business Trip'),

(15,'2025-07-01','08:52','18:04','Present',NULL);

GO


SELECT *
FROM Attendance;



/*============================================================================

🇺🇿

Nega Attendance jadvalida
EmployeeID + AttendanceDate
UNIQUE?

Sababi

Bir xodim

Bir kunda

faqat bitta davomat yozuviga ega bo'lishi kerak.

-------------------------------------------------------------------------------

🇬🇧

Why EmployeeID + AttendanceDate is UNIQUE?

Because

One employee

should have only one attendance record

per day.

============================================================================*/



/*============================================================================

TABLE : Salaries

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Xodimlarning oylik maoshlarini saqlaydi.

Har bir yozuv:

• Bitta xodim
• Bitta oy

uchun yaratiladi.

Maosh tarkibi:

Asosiy maosh
+
Bonus
+
Qo'shimcha ish haqi (Overtime)
-
Soliq (Tax)
=
Sof maosh (Net Salary)

Relationship

Employees (1)
      │
      ▼
Salaries (∞)

-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores employee payroll information.

Each record represents

• One Employee
• One Payroll Month

Salary Formula

Basic Salary
+
Bonus
+
Overtime
-
Tax
=
Net Salary

Relationship

Employees (1)
      │
      ▼
Salaries (∞)

============================================================================*/



CREATE TABLE Salaries
(
    SalaryID INT IDENTITY(1,1),

    EmployeeID INT NOT NULL,

    PayrollMonth DATE NOT NULL,

    BasicSalary DECIMAL(12,2) NOT NULL,

    Bonus DECIMAL(12,2)
        DEFAULT(0),

    OvertimePay DECIMAL(12,2)
        DEFAULT(0),

    Tax DECIMAL(12,2)
        DEFAULT(0),

    NetSalary DECIMAL(12,2) NOT NULL,

    PaymentDate DATE NOT NULL,

    PaymentMethod NVARCHAR(30)
        DEFAULT('Bank Transfer'),

    Notes NVARCHAR(300),

    CONSTRAINT PK_Salaries
        PRIMARY KEY(SalaryID),

    CONSTRAINT FK_Salaries_Employees
        FOREIGN KEY(EmployeeID)
        REFERENCES Employees(EmployeeID),

    CONSTRAINT UQ_SalaryMonth
        UNIQUE(EmployeeID, PayrollMonth),

    CONSTRAINT CHK_BasicSalary
        CHECK(BasicSalary>0),

    CONSTRAINT CHK_Bonus
        CHECK(Bonus>=0),

    CONSTRAINT CHK_Overtime
        CHECK(OvertimePay>=0),

    CONSTRAINT CHK_Tax
        CHECK(Tax>=0),

    CONSTRAINT CHK_NetSalary
        CHECK(NetSalary>0),

    CONSTRAINT CHK_PaymentMethod
        CHECK
        (
            PaymentMethod IN
            (
                'Cash',
                'Card',
                'Bank Transfer'
            )
        )
);

GO

INSERT INTO Salaries
(
EmployeeID,
PayrollMonth,
BasicSalary,
Bonus,
OvertimePay,
Tax,
NetSalary,
PaymentDate,
PaymentMethod,
Notes
)

VALUES

(1,'2025-07-01',9500000,500000,300000,980000,9320000,'2025-07-31','Bank Transfer',NULL),

(2,'2025-07-01',7800000,250000,150000,820000,7380000,'2025-07-31','Bank Transfer',NULL),

(3,'2025-07-01',6500000,300000,200000,690000,6310000,'2025-07-31','Card',NULL),

(4,'2025-07-01',6200000,0,100000,630000,5670000,'2025-07-31','Bank Transfer','Absent 1 day'),

(5,'2025-07-01',12000000,1200000,500000,1300000,12400000,'2025-07-31','Bank Transfer',NULL),

(6,'2025-07-01',8100000,400000,250000,850000,7900000,'2025-07-31','Cash',NULL),

(7,'2025-07-01',7300000,200000,180000,760000,6920000,'2025-07-31','Bank Transfer',NULL),

(8,'2025-07-01',6700000,150000,90000,680000,6260000,'2025-07-31','Bank Transfer',NULL),

(9,'2025-07-01',9800000,700000,350000,1050000,9800000,'2025-07-31','Card',NULL),

(10,'2025-07-01',5600000,100000,50000,560000,5190000,'2025-07-31','Bank Transfer',NULL);

GO

/*============================================================================

TABLE : Leaves

===============================================================================

🇺🇿 O'zbekcha

Vazifasi

Xodimlarning barcha ta'tillarini saqlaydi.

Misollar

• Annual Leave

• Sick Leave

• Maternity Leave

• Business Trip

• Unpaid Leave

Relationship

Employees (1)

↓

Leaves (∞)

-------------------------------------------------------------------------------

🇬🇧 English

Purpose

Stores employee leave requests.

Examples

• Annual Leave

• Sick Leave

• Maternity Leave

• Business Trip

• Unpaid Leave

Relationship

Employees (1)

↓

Leaves (∞)

============================================================================*/

CREATE TABLE Leaves
(
    LeaveID INT IDENTITY(1,1),

    EmployeeID INT NOT NULL,

    LeaveType NVARCHAR(30) NOT NULL,

    StartDate DATE NOT NULL,

    EndDate DATE NOT NULL,

    TotalDays INT NOT NULL,

    LeaveStatus NVARCHAR(20) NOT NULL,

    ApprovedBy INT NULL,

    Reason NVARCHAR(300),

    CreatedDate DATETIME
        CONSTRAINT DF_Leaves_CreatedDate
        DEFAULT(GETDATE()),

    CONSTRAINT PK_Leaves
        PRIMARY KEY(LeaveID),

    CONSTRAINT FK_Leaves_Employee
        FOREIGN KEY(EmployeeID)
        REFERENCES Employees(EmployeeID),

    CONSTRAINT FK_Leaves_ApprovedBy
        FOREIGN KEY(ApprovedBy)
        REFERENCES Employees(EmployeeID),

    CONSTRAINT CHK_Leaves_Type
        CHECK
        (
            LeaveType IN
            (
                'Annual',
                'Sick',
                'Maternity',
                'Business Trip',
                'Unpaid'
            )
        ),

    CONSTRAINT CHK_Leaves_Status
        CHECK
        (
            LeaveStatus IN
            (
                'Pending',
                'Approved',
                'Rejected'
            )
        ),

    CONSTRAINT CHK_Leaves_TotalDays
        CHECK(TotalDays>0),

    CONSTRAINT CHK_Leaves_Date
        CHECK(StartDate<=EndDate)
);

GO



INSERT INTO Leaves
(
    EmployeeID,
    LeaveType,
    StartDate,
    EndDate,
    TotalDays,
    LeaveStatus,
    ApprovedBy,
    Reason
)
VALUES
(3,'Annual','2025-07-01','2025-07-10',10,'Approved',1,'Summer Vacation'),

(4,'Sick','2025-06-15','2025-06-18',4,'Approved',2,'Medical Treatment'),

(5,'Business Trip','2025-08-05','2025-08-09',5,'Approved',1,'Client Meeting'),

(6,'Annual','2025-09-01','2025-09-07',7,'Pending',NULL,'Family Vacation'),

(7,'Unpaid','2025-10-01','2025-10-05',5,'Approved',2,'Personal Reason'),

(8,'Sick','2025-07-20','2025-07-22',3,'Rejected',1,'Medical Leave'),

(9,'Annual','2025-11-10','2025-11-20',11,'Pending',NULL,'Travel'),

(10,'Business Trip','2025-08-12','2025-08-16',5,'Approved',5,'Conference'),

(11,'Annual','2025-12-01','2025-12-14',14,'Approved',1,'Holiday'),

(12,'Unpaid','2025-07-15','2025-07-17',3,'Approved',5,'Family Event');

GO



SELECT *
FROM Leaves;



/*============================================================================

🇺🇿

ApprovedBy nima uchun EmployeeID?

Sababi

Rahbar ham xodim hisoblanadi.

Shuning uchun alohida Managers jadvali kerak emas.

-------------------------------------------------------------------------------

🇬🇧

Why is ApprovedBy referencing Employees?

Because managers are also employees.

No separate Managers table is required.

============================================================================*/




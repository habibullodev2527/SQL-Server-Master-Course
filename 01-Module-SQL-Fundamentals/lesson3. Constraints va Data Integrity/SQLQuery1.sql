--🎤 Interview Corner
--1. PRIMARY KEY va UNIQUE o'rtasidagi farq nima?
--Javob: Primary key jadvalda bitta, Unique esa bir nechta bo'lishi mumkin. 
--2. NOT NULL va CHECK o'rtasidagi farq nima?
--Javob: Not Null - Jadvalda biror ustun qiymatlari bo'sh qolib ketmasligini ya'ni har doim qiymat kiritish kerakligini anglatadi.
-- Check - bu biror ustunga cheklov o'rnatish uchun ishlatiladi. 
--3. IDENTITY(1,1) nimani anglatadi?
--Javob: Avtomatik id berish uchun ishlatiladi. birinchi 1 - seed ikkinchi 1 - increment. har safar bittaga oshadi.
--4.DEFAULT qachon ishlatiladi?
--Javob: Biror ustunga jadvala yaratilayotganda oldindan qiymat berish uchun ishlatiladi.
--5.Nima uchun CHECK constraint muhim?
--Javob: Jadvalning biror ustuniga cheklovlar qo'llashda va kod xavfsizligi hamda professionalligi uchun muhim.

create database HomeworkConstraintsDB;
go 
use HomeworkConstraintsDB;

--🟢 Easy (1–5)

--Task1. Students jadvalini yarating:
--StudentID → INT IDENTITY(1,1) PRIMARY KEY
--FullName → NVARCHAR(100) NOT NULL
--Age → INT CHECK (Age >= 16)
--Country → NVARCHAR(50) DEFAULT 'Uzbekistan'

create table Students (
	StudentID int identity(1,1) PRIMARY KEY,
	FullName nvarchar(100) NOT NULL,
	Age int CHECK(Age >= 16),
	Country nvarchar(50) DEFAULT 'Uzbekistan'
);

--task2. 5 ta talaba qo'shing. StudentID va Country ustunlariga qiymat bermang.

insert into Students (FullName, Age) values
('Ali Karimov', 20),
('Sodiq Sharipov', 23),
('Anvar Oliov', 21),
('Olim Jamilov', 22),
('Akobir Asadov', 19);

--task3. Age = 14 bo'lgan talaba qo'shib ko'ring. Nima sodir bo'lishini yozing.

insert into Students (FullName, Age) values
('Azamat Anvarov', 14);

--bu malumotni qo'shib bo'lmaydi. Xatolik berdi. Chunki biz jadval yaratayotganda Age ustuniga CHECK(Age >= 16) constraintni 
--qo'llaganmiz. Yosh 16ga teng yoki undan katta bo'lishi kerak.

--task4. FullName = NULL bo'lgan talaba qo'shib ko'ring. Nima sodir bo'lishini yozing.

insert into Students (FullName, Age) values
(Null, 18);

--bu malumotni qo'shib bo'lmaydi. Xatolik berdi. Chunki biz jadval yaratayotganda Fullname ustuniga Not Null constraintni 
--qo'llaganmiz. Fullname Null ya'ni bo'sh bo'lmasligi kerak.

--task5. SELECT * FROM Students; natijasini tekshiring va StudentID hamda Country qanday to'ldirilganini izohlang.

select *from Students;

--StudentID ga identity(1,1) yordamida avtomatik 1 taga oshib boradi, Country Default 'Uzbekistan' qiymati berilgan.

--🟡 Medium (6–10)

--task6. Products jadvalini yarating:
--ProductID → INT IDENTITY(100,5) PRIMARY KEY
--ProductName → NVARCHAR(100) NOT NULL
--Price → DECIMAL(10,2) CHECK (Price > 0)
--Stock → INT DEFAULT 0

create table Products (
	ProductID int identity(100, 5) PRIMARY KEY,
	ProductName nvarchar(100) NOT NULL,
	Price Decimal(10,2) CHECK (Price > 0),
	Stock int DEFAULT 0
);

--task7. 5 ta mahsulot qo'shing. Ayrimlarida Stock qiymatini bermang.

insert into Products (ProductName, Price, Stock) values
('Laptop', 5000000, 2),
('TV', 8000000, DEFAULT),
('Joystick', 200000, 4),
('Phone', 3000000, 3),
('Book', 100000, DEFAULT);

--task8. Price = -50000 bo'lgan mahsulot qo'shib ko'ring. Natijani yozing.

insert into Products (ProductName, Price, Stock) values
('Water', -50000, DEFAULT);

--bu malumotni qo'shib bo'lmaydi. Xatolik berdi. Chunki biz jadval yaratayotganda price ustuniga CHECK(Price > 0) constraintni 
--qo'llaganmiz. Price 0 dan katta bo'lishi kerak.

--task9. ProductName = NULL bo'lgan mahsulot qo'shib ko'ring. Natijani yozing.

insert into Products (ProductName, Price, Stock) values
(NULL, 50000, DEFAULT);

--bu malumotni qo'shib bo'lmaydi. Xatolik berdi. Chunki biz jadval yaratayotganda ProductName ustuniga Not Null constraintni 
--qo'llaganmiz. ProductName Null ya'ni bo'sh bo'lmasligi kerak.

--task10. SELECT * FROM Products; natijasini tahlil qiling.

select *from Products;

--🔴 Hard (11–15)

--task11. Employees jadvalini quyidagi constraintlar bilan yarating:
--EmployeeID → INT IDENTITY(1,1) PRIMARY KEY
--FullName → NVARCHAR(100) NOT NULL
--Email → NVARCHAR(150) UNIQUE
--Salary → DECIMAL(12,2) CHECK (Salary >= 3000000)
--IsActive → BIT DEFAULT 1
--HireDate → DATE NOT NULL

create table Employees (
	EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
	Fullname  NVARCHAR(100) NOT NULL,
	Email NVARCHAR(150) UNIQUE,
	Salary DECIMAL(12,2) CHECK (Salary >= 3000000),
	IsActive BIT DEFAULT 1,
	HireDate DATE NOT NULL
);

--task12. Nima uchun har bir constraint tanlanganini qisqacha izohlang.

--1. EmployeeID - id identity yordamida 1 dan boshlab har safar 1 taga oshib boradi va Primary key bu id takrorlanmasligini bildiradi.
--2. Fullname - Not Null bo'sh bo'lishi mumkin emas. Har doim qiymat kiritish shart.
--3. Email - Unique har bir employee yagona emailga ega bo'ladi ya'ni bir birini emaili o'xshash bo'lmaydi. 
--4. Salary - Check cheklovi o'rnatilgan. Salary 3000000 dan katta yoki teng bo'lishi kerak.
--5. IsActive - Default ishlatib oldindan qiymat berilgan.
--6. HireDate - Not Null bo'sh bo'lishi mumkin emas. Har doim qiymat kiritish shart.

--task13. 10 ta xodim qo'shing. Kamida ikkitasida IsActive qiymatini yozmang va DEFAULT ishlashini kuzating.

insert into Employees(Fullname, Email, Salary, IsActive, HireDate) values
('Ali Valiyev', 'ali@gmail.com', 4500000, 0, '2025-07-17'),
('Alimardon Anvarov', 'alimardon@mail.ru', 5500000, 1, '2024-01-11'),
('Azam Umidov', 'azam@mail.ru', 4000000, 0, '2026-01-17'),
('Javohir Shukurov', 'javoh03@gmail.com', 4300000, 0, '2025-02-27'),
('Abubakr Karimov', 'karimov@email.uz', 6500000, DEFAULT, '2024-05-27'),
('Olim Komilov', 'olim@yahoo.com', 4000000, 0, '2025-12-17'),
('Umid Aripov', 'umid02@mai.ru', 5200000, DEFAULT, '2023-12-15'),
('Javlon Alimov', 'javlon@gmail.com', 4700000, 0, '2024-11-18'),
('Umrbek Jamilov', 'jamilov@mail.ru', 5200000, 0, '2025-12-25'),
('Avazbek Obidov', 'avazbekolimov22@email.uz', 3500000, 1, '2025-12-17');

--task14. Bir xil Email bilan yana bitta xodim qo'shib ko'ring. Qanday xato chiqqanini yozing va sababini tushuntiring.

insert into Employees(Fullname, Email, Salary, IsActive, HireDate) values
('Akobir Jamilov', 'jamilov@mail.ru', 7200000, 0, '2024-10-15');

--Ma'lumot qo'shilmaydi. Chunki Email ustuniga UNIQUE constraintni ishlatganmiz. O'xshash email bo'lishi mumkin emas!

--task15. Salary = 2500000 bo'lgan xodim qo'shib ko'ring. CHECK constraint qanday ishlaganini izohlang.

insert into Employees(Fullname, Email, Salary, IsActive, HireDate) values
('Akobir Jamilov', 'jamilov@gmail.com', 2500000, 0, '2024-10-15');

--Ma'lumot qo'shilmaydi. Chunki Salary ustuniga CHECK constraintni ishlatganmiz. Salary 3000000 dan katta yoki teng bo'lishi kerak.

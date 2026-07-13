--🔴 Easy (1–5)

--task1. TrainingDB nomli database yarating va unga o'ting.

create database TrainingDB;
go 
use TrainingDB;

--task2. Students jadvalini yarating (StudentID, FullName, Age).

create table Students (
	StudentID int,
	FullName varchar(100),
	Age int
);

--task3. Students jadvaliga 5 ta talaba qo'shing.

insert into Students (StudentID, FullName, Age) values
(1, 'Ali Karimov', 20),
(2, 'Jahongir Komilov', 22),
(3, 'Sadriddin Sayfiddinov', 23),
(4, 'Azamat Olimov', 19),
(5, 'Davron Choriyev', 21);

--task4. Students jadvalidagi Age ustunini yangilang (StudentID = 3 uchun).

update Students set age = 24
where StudentID = 3;

--task5. StudentID = 5 bo'lgan talabani o'chiring.

delete from Students where StudentID = 5;

--🔴 Medium (6–10) 

--task6. Courses jadvalini yarating (CourseID, CourseName, DurationMonths, Price).

create table Courses (
	CourseID int, 
	CourseName varchar(50),
	DurationMonths int,
	Price decimal(10,2)
);

--task7. Courses jadvaliga 5 ta kurs qo'shing.

insert into Courses(CourseID, CourseName, DurationMonths, Price) values
(1, 'Maths', 10, 1200000),
(2, 'Python', 6, 2300000),
(3, 'Power BI', 3, 2150000),
(4, 'SQL', 3, 2400000),
(5, 'Physics', 10, 1000000);

--task8. Courses jadvaliga TeacherName ustunini ALTER TABLE yordamida qo'shing.

alter table Courses
add TeacherName varchar(50);

--task9. TeacherName ustunining turini 50 belgidan 100 belgiga o'zgartiring.

alter table Courses 
alter column TeacherName varchar(100);

--task10. Courses jadvalidagi barcha ma'lumotlarni TRUNCATE TABLE yordamida o'chiring.

truncate table Courses;

--🔴 Hard (11–15)

--task11. Employees jadvalini yarating. Quyidagi ustunlar uchun mos Data Typelarni o'zing tanlang:
--EmployeeID
--FullName
--BirthDate
--Salary
--IsActive
--HireDate

create table Employees (
	EmployeeID int,
	Fullname varchar(100),
	BirthDate date,
	Salary decimal(10,2),
	IsActive char(3), -- IsActive BIT NOT NULL, bu tavsiya etiladi ekan. boolean ga o'xshash 1 va 0 qiymat qaytaradi. active - 1. inactive - 9
	HireDate date
);

--task12. Nima uchun aynan shu Data Typelarni tanlaganingni izohlang.

--EmployeeID int - Id uchun int mos va shu har doim tavsiya etiladi.
--Fullname varchar(100) - Fullname bir nechta belgilardan tashkil topadi.
--BirthDate date - vaqtga oid shuning uchun date ishlatiladi.
--Salary decimal(10,2) - ish haqi uchun bu data type eng to'g'ri tanlov.
--IsActive char(3) - 3 ta belgi yetadi. yes/no.
--HireDate date - vaqtga oid shuning uchun date ishlatiladi.

--task13. Employees jadvaliga 10 ta xodim qo'shing.

insert into Employees(EmployeeID, Fullname, BirthDate, Salary, IsActive, HireDate) values
(1, 'Ali Valiyev', '2000-05-10', 4500000, 'yes', '2025-07-17'),
(2, 'Alimardon Anvarov', '2001-08-18', 5500000, 'yes', '2024-01-11'),
(3, 'Azam Umidov', '1999-10-10', 4000000, 'no', '2026-01-17'),
(4, 'Javohir Shukurov', '2003-04-13', 4300000, 'yes', '2025-02-27'),
(5, 'Abubakr Karimov', '1998-11-21', 6500000, 'no', '2024-05-27'),
(6, 'Olim Komilov', '2000-09-11', 4000000, 'no', '2025-12-17'),
(7, 'Umid Aripov', '2001-12-12', 5200000, 'yes', '2023-12-15'),
(8, 'Javlon Alimov', '2003-09-19', 4700000, 'yes', '2024-11-18'),
(9, 'Umrbek Jamilov', '2002-12-11', 5200000, 'no', '2025-12-25'),
(10, 'Avazbek Obidov', '2004-11-13', 3500000, 'yes', '2025-12-17');

--task14. 3 nafar xodimning maoshini yangilang.

update Employees set Salary = 5500000
where EmployeeID = 4;

update Employees set Salary = 5700000
where EmployeeID = 7;

update Employees set Salary = 6200000
where EmployeeID = 8;

--task15. Faqat ishdan bo'shagan (faol emas) xodimlarni o'chiring.

delete from Employees where IsActive = 'no';

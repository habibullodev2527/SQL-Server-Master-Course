--🎤 Interview Corner
--1. SELECT * nima uchun tavsiya etilmaydi?
--Javob: Masalan bizda Employees jadvali bor. Jadvalda 50 ta ustun bor. Biz faqat 2 ta ustunni ishlatamiz. 
--SELECT * yozadigan bo'lsak bizga jadvalning barcha ustunlari ulardagi ma'lumotlar keladi. Bu: ortiqcha xotira,
--QISQA JAVOB UCHUN - **SELECT *** katta jadvallarda ortiqcha I/O (Input/Output) va Network Traffic keltirib chiqaradi.
--ortiqcha tarmoq trafigi, sekinroq ishlash degani.
--Shuning uchun real loyihalarda:		SELECT EmployeeID, FullName FROM Employees; ko'proq ishlatiladi.

--2. = va <> o'rtasidagi farq nima?
--Javob: = bu tenglikni <> bu esa teng emaslikni bildiradigan Comparison Operators.

--3. AND va OR qanday ishlaydi?
--Javob: AND - Barcha shartlar bajarilishi kerak. OR - Kamida bittasi bajarilishi kerak.

--4. NOT operatori nima qiladi?
--Javob: NOT - Shartni teskarisiga aylantiradi.

--5. Qachon qavs ishlatish kerak?
--Javob: Murakkab shartlar bilan ishlaganda qavslar kerak.


use TrainingDB;

drop table Employees;

CREATE TABLE Employees
(
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) UNIQUE,
    Salary DECIMAL(12,2) CHECK (Salary >= 3000000),
    IsActive BIT DEFAULT 1,
    HireDate DATE NOT NULL,
	Department NVARCHAR(50) NOT NULL
);

INSERT INTO Employees
(FullName, Email, Salary, IsActive, HireDate, Department)
VALUES
('Ali Valiyev', 'ali@gmail.com', 4500000, 1, '2024-01-15', 'IT'),
('Vali Karimov', 'vali@gmail.com', 5200000, 1, '2023-06-10', 'HR'),
('Jasur Ahmedov', 'jasur@gmail.com', 6800000, 1, '2025-02-18', 'Finance'),
('Madina Ismoilova', 'madina@gmail.com', 3900000, 0, '2022-09-12', 'Sales'),
('Aziza Rasulova', 'aziza@gmail.com', 7500000, 1, '2024-05-20', 'IT'),
('Bekzod Tursunov', 'bekzod@gmail.com', 4700000, 1, '2023-11-01', 'Marketing'),
('Dilshod Ergashev', 'dilshod@gmail.com', 5600000, 0, '2025-03-15', 'Finance'),
('Sardor Yoqubov', 'sardor@gmail.com', 6200000, 1, '2021-07-25', 'HR'),
('Nodira Karimova', 'nodira@gmail.com', 4100000, 1, '2024-08-09', 'Sales'),
('Oybek Xasanov', 'oybek@gmail.com', 8000000, 1, '2025-01-30', 'IT'),
('Javohir Qodirov', 'javohir@gmail.com', 3500000, 0, '2022-04-11', 'Support'),
('Malika Xolmatova', 'malika@gmail.com', 4900000, 1, '2023-12-05', 'Marketing'),
('Akmal Jo''rayev', 'akmal@gmail.com', 5800000, 1, '2025-06-01', 'Finance'),
('Umid Rustamov', 'umid@gmail.com', 7100000, 1, '2024-03-19', 'IT'),
('Sevara Rahimova', 'sevara@gmail.com', 4300000, 0, '2021-10-14', 'HR'),
('Sherzod Nabiyev', 'sherzod@gmail.com', 6600000, 1, '2023-02-22', 'Sales'),
('Gulbahor Sobirova', 'gulbahor@gmail.com', 5400000, 1, '2024-11-18', 'Finance'),
('Bobur Abdullayev', 'bobur@gmail.com', 3700000, 0, '2022-06-30', 'Support'),
('Zarina Saidova', 'zarina@gmail.com', 6000000, 1, '2025-04-08', 'Marketing'),
('Kamron Ergashev', 'kamron@gmail.com', 8200000, 1, '2023-08-17', 'IT');

--🟢 Easy (1–5)

--task1. Barcha xodimlarni chiqar.

select *
from Employees;

--task2. Faqat FullName va Salary ustunlarini chiqar.

select FullName,
	   Salary
from Employees;

--task3. Maoshi 5 000 000 dan katta xodimlarni chiqar.

select 
	Fullname,
	Salary
from Employees
where Salary > 5000000;

--task4. Department = 'IT' bo'lgan xodimlarni chiqar.

select 
	FullName,
	Department
from Employees
where Department = 'IT';
	  
--task5. IsActive = 1 bo'lgan xodimlarni chiqar.

select 
	FullName,
	IsActive
from Employees
where IsActive = 1;

--🟡 Medium (6–10)

--task6. Maoshi 4 000 000 dan katta va faol (IsActive = 1) xodimlarni chiqar.

select 
	FullName,
	Salary,
	IsActive
from Employees
where Salary > 4000000 
and IsActive = 1;

--task7. HR yoki Finance bo'limidagi xodimlarni chiqar.

select 
	FullName,
	Department
from Employees
where Department = 'HR'
or Department = 'Finance';

--task8. Faol bo'lmagan (IsActive = 0) xodimlarni chiqar.

select 
	FullName,
	IsActive
from Employees
where IsActive = 0;

--task9. Maoshi 6 000 000 dan katta yoki IT bo'limida ishlaydigan xodimlarni chiqar.

select 
	FullName,
	Salary,
	Department
from Employees
where Salary > 6000000 
or Department = 'IT';

--task10. Department = 'Sales' bo'lmagan xodimlarni chiqar.

select 
	FullName,
	Department
from Employees
where Department <> 'Sales';

--🔴 Hard (11–15)

--task11. Faqat 2024-yildan keyin ishga kirgan va maoshi 5 000 000 dan yuqori bo'lgan xodimlarni chiqar.

select 
	FullName,
	Salary,
	HireDate
from Employees
where HireDate > '2024-12-31'
and Salary > 5000000;

--task12. HR yoki IT bo'limida ishlaydigan va faol bo'lgan xodimlarni chiqar.

select 
	FullName,
	IsActive,
	Department
from Employees
where (Department = 'HR'
or Department = 'IT')
and IsActive = 1;

--task13. Maoshi 3 000 000 dan kichik yoki 8 000 000 dan katta bo'lgan xodimlarni chiqar.

select 
	FullName,
	Salary
from Employees
where Salary < 3000000
or Salary > 8000000;

--task14. Finance bo'limida ishlamaydigan va faol bo'lgan xodimlarni chiqar.

select 
	FullName,
	IsActive,
	Department
from Employees
where Department <> 'Finance'
and IsActive = 1;

--task15.Qavsdan foydalanib quyidagi shartni yoz:
--HR yoki IT bo'limi
--va
--maoshi 5 000 000 dan katta
--va
--faol xodimlar

select
	FullName,
	Salary,
	IsActive,
	Department
from Employees
where (Department = 'HR'
or Department = 'IT')
and Salary > 5000000
and IsActive = 1;


--🏆 Bonus Challenge

--Quyidagi shartni bitta SELECT bilan yoz:

--Maoshi 4 000 000 dan yuqori yoki Finance bo'limida ishlaydigan, lekin faol bo'lmagan xodimlarni chiqar.

--Bu yerda AND, OR va qavslarni to'g'ri ishlatishing kerak.

select 
	FullName,
	Salary,
	IsActive,
	Department
from Employees
where (Salary > 4000000
or Department = 'Finance')
and IsActive = 0;
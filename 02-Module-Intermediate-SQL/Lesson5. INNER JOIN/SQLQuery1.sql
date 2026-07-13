--🎤 Top 10 Interview Questions

--1. INNER JOIN nima?

--Javob: ikkala jadvalda mos keladigan yozuvlarni qaytaradi.

--2. JOIN va INNER JOIN farqi bormi?

--Javob: farqi yo'q.

--3. ON nima vazifa bajaradi?

--Javob: ON ikki jadvalni birlashtirish (JOIN) shartini belgilaydi. Qaysi ustunlar bo'yicha ma'lumotlar mos kelishini aniqlaydi.

--4. PK va FK nima?

--Javob:
--PK (Primary Key - Asosiy Kalit)
--Qisqa javob: Jadvaldagi har bir qatorni unikal identifikatsiya qiluvchi ustun (yoki ustunlar majmuasi).

--Xususiyatlari:
--✅ Unikal (takrorlanmaydi)
--✅ NULL bo'lishi mumkin EMAS
--✅ Har bir jadvalda faqat 1 ta PK bo'ladi

--FK (Foreign Key - Tashqi Kalit)
--Qisqa javob: Boshqa jadvalning PK ga murojaat qiluvchi ustun. Jadvalar orasidagi bog'lanishni ta'minlaydi.

--Xususiyatlari:
--✅ Boshqa jadvaldagi PK ga ishora qiladi
--✅ NULL bo'lishi MUMKIN
--✅ Bir nechta FK bo'lishi MUMKIN
--✅ Referential Integrity (ma'lumotlar yaxlitligi) ni ta'minlaydi

--5. INNER JOIN qaysi yozuvlarni qaytaradi?

--Javob: INNER JOIN faqat ikkala jadvalda ham ON shartiga mos keladigan yozuvlarni qaytaradi. Biror jadvalda mos kelmasa, u qator chiqmaydi.

--6. INNER JOINda WHERE ishlatish mumkinmi?

--Javob: Ha, mumkin!

--7. INNER JOINni 3 ta jadval bilan ishlatish mumkinmi?

--Javob: Ha, mumkin!

--8. Ambiguous column name xatosi nima?

--Javob: Xatolik SQL qaysi jadvalning ustunini ishlatishni bilmaganda yuz beradi. 
--Bunda ustun nomi ikkala jadvalda ham mavjud bo'lib, siz qaysi birini nazarda tutganingizni aniq ko'rsatmagan bo'lasiz.

--9. Alias nima uchun ishlatiladi?

--Javob: Alias (taxallus) – jadval yoki ustunga vaqtinchalik nom berish uchun ishlatiladi. 
--Bu so'rovni qisqartiradi, o'qishni osonlashtiradi va noaniqliklarni (ambiguous) bartaraf qiladi.

--10. INNER JOIN va CROSS JOIN farqi nima?

--Javob: INNER JOIN → faqat shartga mos kelgan yozuvlarni birlashtiradi
--CROSS JOIN → barcha yozuvlarni bir-biri bilan kombinatsiyalaydi (shartsiz)



--📝 Practice (15 ta)

use TrainingDB;

DROP TABLE IF EXISTS Departments;

CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);

INSERT INTO Departments VALUES
(1,'IT'),
(2,'Finance'),
(3,'HR'),
(4,'Marketing'),
(5, 'Sales'),
(6, 'Support');

ALTER TABLE Employees
ADD DepartmentID INT;

UPDATE Employees
SET DepartmentID = 1
WHERE EmployeeID IN (1,3,6,17);

UPDATE Employees
SET DepartmentID = 2
WHERE EmployeeID IN (2,5,8);

UPDATE Employees
SET DepartmentID = 3
WHERE EmployeeID IN (4,7,11);

UPDATE Employees
SET DepartmentID = 4
WHERE EmployeeID IN (9,10,12, 19);

UPDATE Employees
SET DepartmentID = 5
WHERE EmployeeID IN (15,18,20);

UPDATE Employees
SET DepartmentID = 6
WHERE EmployeeID IN (13, 14,16);

ALTER TABLE Employees
DROP COLUMN Department;


--🟢 Easy (1–5)

--1. Employees va Departments jadvallarini INNER JOIN qiling.

SELECT
    E.FullName,
    D.DepartmentName
FROM Employees E
INNER JOIN Departments D
    ON E.DepartmentID = D.DepartmentID;

2. FullName va DepartmentName ni chiqaring.

SELECT
    E.FullName,
    D.DepartmentName
FROM Employees E
INNER JOIN Departments D
    ON E.DepartmentID = D.DepartmentID;

--3. FullName, DepartmentName va Salary ni chiqaring.

SELECT
    E.FullName,
    D.DepartmentName,
	E.Salary
FROM Employees E
INNER JOIN Departments D
    ON E.DepartmentID = D.DepartmentID;

--4. Faqat IT bo'limidagi xodimlarni chiqaring.

SELECT
    e.FullName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'IT';

--5. Natijani Salary DESC bo'yicha saralang.

SELECT
    e.FullName,
    d.DepartmentName,
	e.Salary
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'IT'
ORDER BY e.Salary DESC;

--🟡 Medium (6–10)

--6. Har bir xodimning:

--Ismi
--Bo'limi
--Ishga kirgan sanasi

--ni chiqaring.

SELECT
    e.FullName,
    d.DepartmentName,
	e.HireDate
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

--7. Faqat Finance bo'limidagi faol xodimlarni chiqaring.

SELECT
    e.FullName,
    d.DepartmentName,
	e.IsActive
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Finance'
	AND e.IsActive=1;;

--8. DepartmentName bo'yicha A → Z tartibida saralang.

SELECT
    e.FullName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
ORDER BY d.DepartmentName;

--9. Salary > 6000000 bo'lgan xodimlarni chiqaring.

SELECT
    e.FullName,
    d.DepartmentName,
	e.Salary
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 6000000;

--10. DepartmentName va Salary bo'yicha saralang.


SELECT
    e.FullName,
    d.DepartmentName,
	e.Salary
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
ORDER BY d.DepartmentName, e.Salary;


--🔴 Hard (11–15)

--11. INNER JOIN + GROUP BY:

--Har bir bo'limdagi:

--xodimlar soni,
--jami maosh.


SELECT
    d.DepartmentName,
	COUNT(*) as EmployeesCount,
	SUM(e.Salary) as TotalSalary
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;


--12. INNER JOIN + HAVING:

--Jami maoshi 15 000 000 dan yuqori bo'lgan bo'limlarni chiqaring.

SELECT
    d.DepartmentName,
	SUM(e.Salary) as TotalSalary
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
HAVING SUM(e.Salary) > 15000000;

--13. Har bir bo'lim uchun:
--EmployeesCount
--AverageSalary
--HighestSalary

SELECT
    d.DepartmentName,
	COUNT(*) as EmployeesCount,
	AVG(e.Salary) as AverageSalary,
	MAX(e.Salary) as HighestSalary
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

--14. Faqat 2025-yilda ishga kirgan xodimlarni bo'lim nomi bilan chiqaring.

SELECT
	e.FullName,
    d.DepartmentName,
	e.HireDate
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate between '2025-01-01' 
	and '2025-12-31';

--14. CEO Dashboard:

--Chiqsin:

--DepartmentName
--EmployeesCount
--ActiveEmployees
--TotalSalary
--AverageSalary

--Natijani AverageSalary DESC bo'yicha saralang.

SELECT
    d.DepartmentName,
	COUNT(*) as EmployeesCount,
	SUM(CASE WHEN e.IsActive = 1 THEN 1 ELSE 0 END) as ActiveEmployees,
	SUM(e.Salary) as TotalSalary,
	AVG(e.Salary) as AverageSalary
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AverageSalary DESC;


--🏢 Real Business Case
--Task 16 — HR Department Report

--HR direktori quyidagi hisobotni so'radi:

--| Employee | Department | HireDate | Salary | Status |

--Shartlar:

--Status ni CASE yordamida yarating:
--IsActive = 1 → Active
--IsActive = 0 → Inactive
--Faqat faol xodimlarni chiqaring.
--Natijani bo'lim, so'ng maosh bo'yicha kamayish tartibida saralang.


SELECT
	e.FullName AS Employee,
    d.DepartmentName,
	e.HireDate,
	e.Salary,
	e.IsActive,
	CASE
		WHEN e.IsActive = 1 THEN 'Active'
		ELSE 'InActive'
	END AS Status
FROM Employees e
INNER JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE e.IsActive = 1
ORDER BY d.DepartmentName, e.Salary DESC;
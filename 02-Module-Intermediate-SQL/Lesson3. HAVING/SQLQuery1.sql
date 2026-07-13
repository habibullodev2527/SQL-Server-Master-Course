--🎤 Top 10 Interview Questions

--1. HAVING nima qiladi?

--Javob: HAVING — GROUP BY hosil qilgan guruhlarni filtrlaydi.

--2. WHERE va HAVING farqi nima?

--Javob: WHERE → qatorlarni filtrlaydi.
--HAVING → guruhlarni filtrlaydi.

--3. HAVING GROUP BYsiz ishlaydimi?

--Javob: yo'q, ishlamaydi.

--4. COUNT(*) > 5 qayerda yoziladi?

--Javob: Having da yoziladi. 

--5. HAVING SUM(Salary) ishlatish mumkinmi?

--Javob: Ha, mumkin!

--6. HAVING AVG() ishlatish mumkinmi?

--Javob: Ha, mumkin!

--7. SQL bajarilish tartibi qanday?

--Javob: 
--FROM

--↓

--WHERE

--↓

--GROUP BY

--↓

--HAVING

--↓

--SELECT

--↓

--ORDER BY

--8. WHERE nega COUNT()ni bilmaydi?

--Javob: WHERE COUNT() ni "bilmaydi", chunki u guruhlashdan oldin ishlaydi.

--9. HAVING performancega ta'sir qiladimi?

--Javob: Ha, ta'sir qiladi.

--10. WHERE va HAVINGni birga ishlatish mumkinmi?

--Javob: Ha, mumkin!



--📝 Practice (15 ta)

use TrainingDB;

--🟢 Easy (1–5)

--1. Kamida 2 ta xodim mavjud bo'lgan bo'limlarni chiqaring.

select
	Department,
	COUNT(*) as TotalCount
from Employees
group by Department
having COUNT(*) >= 2;

--2. Jami maoshi 15 000 000 dan yuqori bo'lgan bo'limlarni chiqaring.

select
	Department,
	SUM(Salary) as TotalSalary
from Employees
group by Department
having SUM(Salary) > 15000000;

--3. O'rtacha maoshi 6 000 000 dan yuqori bo'lgan bo'limlarni chiqaring.

select
	Department,
	AVG(Salary) as AvgSalary
from Employees
group by Department
having AVG(Salary) > 6000000;

--4. Eng katta maoshi 8 000 000 dan yuqori bo'lgan bo'limlarni chiqaring.

select
	Department,
	MAX(Salary) as HighestSalary
from Employees
group by Department
having MAX(Salary) > 8000000;

--5. Eng kichik maoshi 4 000 000 dan yuqori bo'lgan bo'limlarni chiqaring.

select
	Department,
	MIN(Salary) as LowestSalary
from Employees
group by Department
having MIN(Salary) > 4000000;


--🟡 Medium (6–10)

--6. Faqat faol xodimlar bo'yicha guruhlang va kamida 2 ta faol xodim bo'lgan bo'limlarni chiqaring.

select
	Department,
	IsActive,
	COUNT(*) as ActiveEmployees
from Employees
where IsActive = 1
group by Department
having COUNT(*) >= 2;

--7. Har bir bo'lim uchun:

--xodimlar soni,
--jami maosh,

--va jami maoshi 20 000 000 dan yuqori bo'lgan bo'limlarni chiqaring.

select
	Department,
	COUNT(*) as TotalCount,
	SUM(Salary) as TotalSalary
from Employees
group by Department
having SUM(Salary) > 20000000;

--8. Har bir bo'lim uchun o'rtacha maoshni hisoblang va 7 000 000 dan yuqori bo'lganlarini chiqaring.

select
	Department,
	AVG(Salary) as AverageSalary
from Employees
group by Department
having AVG(Salary) > 7000000;

9. 2025-yilda ishga kirgan xodimlarni guruhlang va kamida 2 ta xodim bo'lgan bo'limlarni chiqaring.

select
	Department,
	Count(*) as TotalCount
from Employees
where HireDate between '2025-01-01'
	and '2025-12-31'
group by Department
having Count(*) >= 2;

--10. Department va IsActive bo'yicha guruhlang, faqat 3 tadan ko'p xodim bo'lgan guruhlarni chiqaring.

select
	Department,
	IsActive,
	Count(*) as TotalCount
from Employees
group by Department, IsActive
having Count(*) > 3;


--🔴 Hard (11–15)

--11. CEO Analytics Report:

--Har bir bo'lim uchun:

--EmployeesCount
--ActiveEmployees
--TotalSalary
--AverageSalary

--va faqat:

--EmployeesCount ≥ 3
--AverageSalary ≥ 6 000 000

--bo'lgan bo'limlarni chiqaring.

select
	Department,
	Count(*) as EmployeesCount,
	SUM(case when IsActive = 1 then 1 else 0 end) as ActiveEmployees,
	SUM(Salary) as TotalSalary,
	AVG(Salary) as AverageSalary
from Employees
group by Department
having Count(*) >= 3
	and AVG(Salary) >= 6000000;

--12. Faqat IT va Finance bo'limlari uchun:
--EmployeesCount
--HighestSalary
--LowestSalary

--va eng katta maoshi 8 000 000 dan yuqori bo'lgan bo'limlarni chiqaring.

select
	Department,
	COUNT(*) as EmployeesCount,
	MAX(Salary) as HighestSalary,
	MIN(Salary) as LowestSalary
from Employees
where Department in ('IT', 'Finance')
group by Department
having MAX(Salary) > 8000000;

--13. Har bir bo'lim uchun:
--ActiveEmployees
--InactiveEmployees

--va kamida 1 ta faol hamda 1 ta faol bo'lmagan xodim mavjud bo'lgan bo'limlarni chiqaring.

select
	Department,
	SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) as ActiveEmployees,
	SUM(CASE WHEN IsActive = 0 THEN 1 ELSE 0 END) as InActiveEmployees
from Employees
group by Department
having SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) >= 1
	and SUM(CASE WHEN IsActive = 0 THEN 1 ELSE 0 END) >= 1;

--14. 2024-yildan keyin ishga kirgan xodimlar bo'yicha:
--Department
--EmployeesCount
--AverageSalary

--va o'rtacha maoshi 6 500 000 dan yuqori bo'lgan bo'limlarni chiqaring.

select
	Department,
	COUNT(*) as EmployeesCount,
	AVG(Salary) as AverageSalary
from Employees
where HireDate >= '2025-01-01'
group by Department
having AVG(Salary) >= 6500000;

--15. Bitta SQL so'rov yozing.

--Natija quyidagi ustunlardan iborat bo'lsin:

--Department
--EmployeesCount
--TotalSalary
--AverageSalary
--HighestSalary
--LowestSalary

--va faqat:

--EmployeesCount ≥ 2
--TotalSalary ≥ 20 000 000
--AverageSalary ≥ 6 000 000

--bo'lgan bo'limlar chiqsin.

select
	Department,
	COUNT(*) as EmployeesCount,
	SUM(Salary) as TotalSalary,
	Avg(Salary) as AverageSalary,
	MAX(Salary) as HighestSalary,
	MIN(Salary) as LowestSalary
from Employees
group by Department
having COUNT(*) >= 2
	and SUM(Salary) >= 20000000
	and Avg(Salary) >= 6000000;

--🏢 Real Business Case
--Task 16 — Executive Salary Dashboard

--CEO faqat quyidagi shartlarga mos bo'lgan bo'limlarni ko'rmoqchi:

--👥 Kamida 3 ta xodim
--💰 Jami maosh 25 000 000 dan yuqori
--📈 O'rtacha maosh 6 500 000 dan yuqori

--Natijada quyidagilar chiqsin:

--Department
--EmployeesCount
--ActiveEmployees
--TotalSalary
--AverageSalary
--HighestSalary

--Natijani AverageSalary DESC bo'yicha tartiblang.


select
	Department,
	COUNT(*) as EmployeesCount,
	SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) AS ActiveEmployees,
	SUM(Salary) as TotalSalary,
	Avg(Salary) as AverageSalary,
	MAX(Salary) as HighestSalary,
	MIN(Salary) as LowestSalary
from Employees
group by Department
having COUNT(*) >= 3
	and SUM(Salary) >= 25000000
	and Avg(Salary) >= 6500000
order by AverageSalary desc;
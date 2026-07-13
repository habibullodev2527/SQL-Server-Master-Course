use TrainingDB;

--🟢 EASY (1–10)

--Task 1

--Barcha xodimlarni FullName bo'yicha A → Z tartibida chiqaring.

select 
	FullName
from Employees
order by FullName;

--Task 2

--Eng yuqori maosh oluvchi 5 nafar xodimni chiqaring.

select top 5
	FullName,
	Salary
from Employees
order by Salary desc;

--Task 3

--Faqat IT bo'limidagi faol xodimlarni chiqaring.

select 
	FullName
from Employees
where Department = 'IT'
and IsActive = 1;

--Task 4

--2024-yilda ishga kirgan xodimlarni chiqaring.

select 
	FullName
from Employees
where HireDate >= '2024-01-01'
and HireDate <= '2024-12-31';

--Task 5

--Maoshi 5 mln–7 mln oralig'idagi xodimlarni chiqaring.

select 
	FullName
from Employees
where Salary > 5000000
and Salary < 7000000;

--Task 6

--Emaili gmail.com bilan tugaydigan xodimlarni chiqaring.

select
	FullName,
	Email
from Employees
where Email like '%gmail.com';

--Task 7

--Takrorlanmaydigan bo'limlarni chiqaring.

select DISTINCT
	Department
from Employees;

--Task 8

--SalaryLevel ustunini yarating:

--7 mln+ → High
--aks holda → Normal

--(CASE ishlating.)

select 
	FullName,
	Salary,
	case
		when Salary >= 7000000 then 'High'
		else 'Normal'
	end as SalaryLevel
from Employees;

--Task 9

--Status ustunini yarating:

--1 → Active
--0 → Inactive

--(IIF ishlating.)

select
	FullName,
	IsActive,
	IIF(IsActive = 1, 'Active', 'Inactive') as Status
from Employees;

--Task 10

--ITEmployees va FinanceEmployees jadvallarini UNION qiling.

select  
	FullName
from ITEmployees

UNION

select  
	FullName
from FinanceEmployees;

--🟡 MEDIUM (11–20)

--Task 11

--ITEmployees va FinanceEmployees orasidagi umumiy xodimlarni toping.

select  
	FullName
from ITEmployees

INTERSECT

select  
	FullName
from FinanceEmployees;     

--Task 12

--Faqat ITEmployees jadvalida mavjud xodimlarni chiqaring.


select  
	FullName
from ITEmployees

EXCEPT

select  
	FullName
from FinanceEmployees;

--Task 13

--Maoshi 6 mln dan yuqori va faol bo'lgan xodimlarni chiqaring.


select  
	FullName
from Employees
where Salary > 6000000
and IsActive = 1;

--Task 14

--Department:

--IT → Technical
--Finance → Business
--qolganlari → Other

--(CASE ishlating.)

select
	Department,
	case
		when Department = 'IT' then 'Technical'
		when Department = 'Finance' then 'Business'
		else 'Other'
	end as DeptStatus
from Employees;

--Task 15

--Eng yuqori maosh oluvchi 3 nafar faol xodimni chiqaring.

select top 3
	FullName
from Employees
where IsActive = 1
order by Salary desc;

--Task 16

--2-sahifadagi 5 ta xodimni chiqaring.

--(OFFSET FETCH)

select 
	FullName
from Employees
order by EmployeeID
OFFSET 5 ROWS 
FETCH NEXT 5 ROWS ONLY;

--Task 17

--A yoki J harfi bilan boshlanadigan xodimlarni chiqaring.

select 
	FullName
from Employees
where FullName like '[AJ]%';

--Task 18

--Employees jadvalida HR bo'limi mavjudligini IF EXISTS yordamida tekshiring.

IF EXISTS (
    SELECT 1 
    FROM Employees 
    WHERE Department = 'HR'
)
    PRINT 'YES'
ELSE
    PRINT 'NO';

--Task 19

--WHILE yordamida 1 dan 10 gacha sonlar yig'indisini hisoblang.

DECLARE @i int = 1;
DECLARE @sum int = 0;

WHILE @i <= 10
BEGIN
	SET @sum = @sum + @i;
	SET @i += 1;
END
PRINT @sum;

--Task 20

--UNION ALL va ORDER BY yordamida ikkala jadvalni alifbo tartibida chiqaring.

select  
	FullName
from ITEmployees

UNION ALL

select  
	FullName
from FinanceEmployees
order by FullName;


--🔴 HARD (21–30)

--Task 21

--Quyidagi ustunni yarating:

--EmployeeCategory

--IT + Salary ≥ 7 mln → Premium
--Finance + Salary ≥ 6 mln → Business Premium
--IsActive = 0 → Inactive Employee
--qolganlari → Standard

select 
	FullName,
	Department,
	Salary,
	IsActive,
	case
		when Department = 'IT' 
			and Salary >= 7000000 then 'Premium'
		when Department = 'Finance' 
			and Salary >= 6000000 then 'Business Premium'
		when IsActive = 0 then 'Inactive Employee'
		else 'Standart'
	end as EmployeeCategory
from Employees;


--Task 22

--Faqat faol xodimlardan:

--Salary DESC
--TOP (5)

--chiqaring.

select top 5
	FullName
from Employees
where IsActive = 1
order by Salary desc;

--Task 23

--INTERSECT yordamida:

--faol xodimlar
--2024-yildan keyin ishga kirgan xodimlar

--kesishmasini toping.

select
	FullName
from Employees
where IsActive = 1

INTERSECT

select 
	FullName
from Employees
where HireDate >= '2025-01-01';

--Task 24

--EXCEPT yordamida:

--barcha faol xodimlar
--minus
--IT bo'limidagi faol xodimlar

select
	FullName
from Employees
where IsActive = 1

EXCEPT

select 
	FullName
from Employees
where Department = 'IT'
and IsActive = 1;

--Task 25

--CASE yordamida:

--8 mln+ → Grade A
--6–8 mln → Grade B
--5–6 mln → Grade C
--aks holda → Grade D


select 
	FullName,
	Salary,
	case
		when Salary >= 8000000 then 'Grade A'
		when Salary >= 6000000 
			and Salary < 8000000 then 'Grade B'
		when Salary >= 5000000 
			and Salary < 6000000 then 'Grade C'
		else 'Grade D'
	end as SalaryLevel
from Employees;


--Task 26

--IF yordamida tekshiring.

--Agar:

--Employees

--jadvalida

--15 tadan ko'p yozuv bo'lsa

--Enough Data

--aks holda

--Need More Data

DECLARE @RowCount int = (select Count(*) from Employees);

IF @RowCount > 15
	PRINT 'Enough Data'
ELSE
	PRINT 'Need More Data';


--Task 27

--WHILE

--1 dan 20 gacha

--faqat

--5 ga karrali sonlarni chiqaring.

DECLARE @i int = 1;

WHILE @i <= 20
BEGIN
	IF @i % 5 = 0
		PRINT @i;
	SET @i = @i + 1;
END;

--Task 28

--UNION

--natijasini

--EmployeeName

--nomi bilan chiqaring.

--(Alias ishlating.)

select  
	FullName as EmployeeName
from ITEmployees

UNION

select  
	FullName as EmployeeName
from FinanceEmployees;

--Task 29

--DISTINCT

--Department

--va

--IsActive

--kombinatsiyalarini chiqaring.

select DISTINCT
	Department,
	IsActive
from Employees
order by Department, IsActive;

--Task 30

--Bitta so'rov yozing.

--Shartlar:

--Department → IT, Finance
--Salary → 5 mln–8 mln
--HireDate → 2023–2025
--IsActive → 1
--Natija → Salary DESC

select 
	FullName,
	Department,
	Salary,
	HireDate,
	IsActive
from Employees
where Department in ('IT', 'Finance')
and Salary between 5000000 and 8000000
and HireDate between '2023-01-01' and '2025-12-31'
and IsActive = 1
order by Salary desc;

--🏢 REAL BUSINESS CASE (31–35)

--Task 31 — HR Report

--HR menejeri quyidagilarni so'radi:

--Faol xodimlar.
--Salary DESC.
--Faqat TOP 10.

select top 10
	FullName,
	IsActive,
	Salary
from Employees
where IsActive = 1
order by Salary desc;

--Task 32 — Finance Report

--Finance bo'limi:

--6 mln dan yuqori maosh oluvchilar.
--Department bo'yicha saralash.

select
	FullName,
	Salary,
	Department
from Employees
where Department = 'Finance'
and Salary > 6000000
order by Department;

--Task 33 — CEO Report

--Har bir xodim uchun:

--Quyidagi ustunlarni chiqaring:

--FullName
--Department
--Salary
--Status
--SalaryLevel

--Shartlar
--Status ustunini CASE yordamida yarating:
--IsActive = 1 → Active
--IsActive = 0 → Inactive
--SalaryLevel ustunini CASE yordamida yarating:
--Salary >= 7000000 → High Salary
--Salary >= 5000000 → Medium Salary
--Aks holda → Low Salary
--Natijani:
--avval Department bo'yicha (A → Z),
--so'ng Salary bo'yicha (DESC)
--tartiblang.
--Quyidagi ustun nomlaridan (alias) foydalaning:
--Asl ustun	Alias
--FullName	EmployeeName
--Department	Department
--Salary	MonthlySalary
--Status	Status
--SalaryLevel	SalaryLevel

select 
	FullName as EmployeeName,
	Department,
	Salary as MonthlySalary,
	case 
		when IsActive = 1 then 'Active'
		else 'InActive'
	end as Status,
	case
		when Salary >= 7000000 then 'High Salary'
		when Salary >= 5000000 then 'Medium Salary'
		else 'Low Salary'
	end as SalaryLevel
from Employees
order by Department, Salary desc;


--Task 34 — Audit Report

--Audit bo'limi:

--Faol bo'lmagan

--hamma xodimlarni

--alifbo tartibida.

select
	FullName,
	Department,
	IsActive
from Employees
where IsActive = 0
order by FullName;

--Task 35 — Recruitment Report

--Recruiter

--2025-yilda ishga kirgan

--IT

--xodimlarini

--maosh bo'yicha kamayish tartibida ko'rmoqchi.

select
	FullName,
	HireDate,
	Department,
	Salary
from Employees
where HireDate between '2025-01-01' and '2025-12-31'
and Department = 'IT'
order by Salary desc;
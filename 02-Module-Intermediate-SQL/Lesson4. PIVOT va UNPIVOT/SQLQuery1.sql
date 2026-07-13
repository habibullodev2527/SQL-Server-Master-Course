--🎤 Top 10 Interview Questions

--1. PIVOT nima?

--Javob: PIVOT — qatorlarni ustunlarga aylantiradi.

--2. UNPIVOT nima?

--Javob: UNPIVOT — ustunlarni qatorlarga aylantiradi.

--3. PIVOT nima uchun aggregate function talab qiladi?

--Javob: PIVOT satrlarni ustunlarga aylantirganda, bir katakka bir nechta qiymat tushishi mumkin. 
--Aggregate function (SUM, COUNT, AVG va h.k.) shu qiymatlarni bitta qiymatga jamlab beradi.

--4. GROUP BY va PIVOT farqi nima?

--Javob: GROUP BY → satrlar soni kamayadi (guruhlar bo'yicha)
--PIVOT → ustunlar soni ko'payadi (guruhlar ustunlarga aylanadi)

--5. PIVOT qachon ishlatiladi?

--Javob: Ma'lumotlarni o'qish va tahlil qilish oson bo'lishi uchun satrlardagi kategoriyalarni ustunlarga aylantirish kerak bo'lganda.

--6. UNPIVOT qachon ishlatiladi?

--Javob: Ustunlardagi ma'lumotlarni satrlarga aylantirib, normalizatsiya qilish yoki tahlil qilish uchun mos formatga keltirish kerak bo'lganda.

--7. PIVOT ichida COUNT() ishlatish mumkinmi?

--Javob: Ha, mumkin!

--8. AVG() bilan PIVOT ishlatish mumkinmi?

--Javob: Ha, mumkin!

--9. IN() qismi nima vazifa bajaradi?

--Javob: Qaysi qiymatlar alohida ustunlarga aylanishini belgilaydi.

--10. PIVOT Power BI va Excel bilan qanday bog'liq?

--Javob: SQL PIVOT, Excel PivotTable va Power BI Pivot xuddi shu tushuncha asosida ishlaydi - ma'lumotlarni gorizontal formatga keltirib, interaktiv tahlil qilish imkonini beradi.



--📝 Practice (15 ta)

use TrainingDB;

DROP TABLE IF EXISTS Sales;

CREATE TABLE Sales
(
    EmployeeName NVARCHAR(100),
    Department NVARCHAR(30),
    SalesAmount INT
);

INSERT INTO Sales VALUES
('Ali','IT',100),
('Vali','IT',200),
('Aziza','Finance',300),
('Kamron','HR',150),
('Bobur','Finance',250),
('Madina','HR',100),
('Jasur','IT',150);


--🟢 Easy (1–5)

--1. GROUP BY yordamida har bir bo'limning jami savdosini chiqaring.

select
	Department,
	SUM(SalesAmount) as TotalSalesAmount
from Sales
group by Department;

--2. PIVOT yordamida bo'limlarni ustunlarga aylantiring (SUM(SalesAmount)).

select *
from 
(
	select
		Department,
		SalesAmount
	from Sales
) as SourceTable

PIVOT

(
	SUM(SalesAmount)

	For Department

	in 

	(
		[IT],
		[Finance],
		[HR]
	)
) as PivotTable;

--3. PIVOT yordamida har bir bo'limdagi xodimlar sonini chiqaring (COUNT).

select *
from 
(
	select
		EmployeeName,
		Department
	from Sales
) as SourceTable

PIVOT

(
	COUNT(EmployeeName)

	For Department

	in 

	(
		[IT],
		[Finance],
		[HR]
	)
) as PivotTable;


--4. PIVOT yordamida o'rtacha savdoni chiqaring (AVG).


select *
from 
(
	select
		Department,
		SalesAmount
	from Sales
) as SourceTable

PIVOT

(
	AVG(SalesAmount)

	For Department

	in 

	(
		[IT],
		[Finance],
		[HR]
	)
) as PivotTable;

--5. GROUP BY va PIVOT natijalarini taqqoslab farqini yozing.

--GROUP BY = Ma'lumotni "saqlash" formati (normalizatsiya)
--PIVOT    = Ma'lumotni "ko'rsatish" formati (denormalizatsiya)

--GROUP BY → natija vertikal ko'rinishda.
--PIVOT → natija gorizontal ko'rinishda.


--🟡 Medium (6–10)

--6. Faqat IT va Finance bo'limlarini PIVOT qiling.


select *
from 
(
	select
		Department,
		SalesAmount
	from Sales
) as SourceTable

PIVOT

(
	SUM(SalesAmount)

	For Department

	in 

	(
		[IT],
		[Finance]
	)
) as PivotTable;

--7. SalesAmount > 100 bo'lgan yozuvlar bo'yicha PIVOT yarating.


select *
from 
(
	select
		Department,
		SalesAmount
	from Sales
	where SalesAmount > 100
) as SourceTable

PIVOT

(
	SUM(SalesAmount)

	For Department

	in 

	(
		[IT],
		[Finance],
		[HR]
	)
) as PivotTable;

--8. UNPIVOT yordamida quyidagi jadvalni qator ko'rinishiga o'tkazing:
--IT	Finance	HR
--450	550	250

CREATE TABLE SalesPivot
(
    IT INT,
    Finance INT,
    HR INT
);

INSERT INTO SalesPivot
VALUES (450,550,250);

SELECT
    Department,
    SalesAmount
FROM SalesPivot
UNPIVOT
(
    SalesAmount
    FOR Department IN (IT, Finance, HR)
) AS U;


--9. PIVOT yordamida bo'limlar bo'yicha eng katta savdoni (MAX) chiqaring.

select *
from 
(
	select
		Department,
		SalesAmount
	from Sales
) as SourceTable

PIVOT

(
	MAX(SalesAmount)

	For Department

	in 

	(
		[IT],
		[Finance],
		[HR]
	)
) as PivotTable;

--10. PIVOT yordamida bo'limlar bo'yicha eng kichik savdoni (MIN) chiqaring.

select *
from 
(
	select
		Department,
		SalesAmount
	from Sales
) as SourceTable

PIVOT

(
	MIN(SalesAmount)

	For Department

	in 

	(
		[IT],
		[Finance],
		[HR]
	)
) as PivotTable;



--🔴 Hard (11–15)

--11. CEO Dashboard:

--Bitta PIVOT so'rovi yozing.

--Natijada:

--IT_Total	Finance_Total	HR_Total

--ko'rinishidagi hisobot hosil bo'lsin.

select 
	IT as IT_Total,
    Finance as Finance_Total,
    HR as HR_Total
from 
(
	select
		Department,
		SalesAmount
	from Sales
) as SourceTable

PIVOT

(
	SUM(SalesAmount)

	For Department

	in 

	(
		[IT],
		[Finance],
		[HR]
	)
) as PivotTable;

--12. Employees jadvalidan foydalanib, har bir bo'limdagi xodimlar sonini PIVOT yordamida chiqaring.

select *
from 
(
	select
		EmployeeID,
		Department
	from Employees
) as SourceTable

PIVOT

(
	Count(EmployeeID)

	For Department

	in 
	
	(
		[IT],
		[Finance],
		[HR],
		[Marketing],
		[Sales],
		[Support]
	)
) as PivotTable;

--13. Employees jadvalidan foydalanib, har bir bo'limning o'rtacha maoshini PIVOT yordamida chiqaring.

select *
from 
(
	select
		Department,
		Salary
	from Employees
) as SourceTable

PIVOT

(
	Avg(Salary)

	For Department

	in 
	
	(
		[IT],
		[Finance],
		[HR],
		[Marketing],
		[Sales],
		[Support]
	)
) as PivotTable;

--14. Sales jadvalidagi ma'lumotlarni avval GROUP BY bilan, keyin PIVOT bilan chiqaring va natijalarni taqqoslang.

select
	Department,
	SUM(SalesAmount) as TotalSalesAmount
from Sales
group by Department;


select *
from 
(
	select
		Department,
		SalesAmount
	from Sales
) as SourceTable

PIVOT

(
	SUM(SalesAmount)

	For Department

	in 

	(
		[IT],
		[Finance],
		[HR]
	)
) as PivotTable;

--15. O'z so'zlaring bilan quyidagilarni tushuntiring:
--PIVOT qachon ishlatiladi?
--UNPIVOT qachon ishlatiladi?
--GROUP BY va PIVOT orasidagi asosiy farq nima?

--GROUP BY = ma'lumotni guruhlab beradi (vertikal)

--PIVOT = guruhlarni ustun qilib chiqaradi (gorizontal)

--UNPIVOT = ustunlarni qator qilib chiqaradi 


--🏢 Real Business Case
--Task 16 — Monthly Sales Dashboard

--CEO quyidagi ko'rinishdagi hisobotni xohlaydi:

--IT	Finance	HR
--Jami savdo	Jami savdo	Jami savdo

--Shartlar:

--PIVOT ishlatilsin.
--SUM(SalesAmount) ishlatilsin.
--Natija bitta qator bo'lsin.
--Ustun nomlari tushunarli bo'lsin (IT_Total, Finance_Total, HR_Total kabi).

select 
	IT as IT_Total,
    Finance as Finance_Total,
    HR as HR_Total
from 
(
	select
		Department,
		SalesAmount
	from Sales
) as SourceTable

PIVOT

(
	SUM(SalesAmount)

	For Department

	in 

	(
		[IT],
		[Finance],
		[HR]
	)
) as PivotTable;
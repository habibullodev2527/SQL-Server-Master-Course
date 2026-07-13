--🎤 Top 10 Interview Questions

--1. CASE va IIF farqi nima?
--Javob: Case - bir nechta shart uchun, IIF - bitta shartni tekshirish uchun tekshiradi.

--2. CASE va IF farqi nima?
--Javob: Case - selectda ishlatiladi. IF - SQL kodning o'zini boshqaradi.

--3. WHILE nima vazifa bajaradi?
--Javob: SQL da WHILE — takrorlash sikli. Berilgan shart TRUE bo‘lsa, kod blokini qayta-qayta bajaradi.

--4. BREAK nima qiladi?
--Javob: Siklni to'xtatadi.

--5. CONTINUE nima qiladi?
--Javob: Joriy aylanishni o'tkazib yuboradi.

--6. IF EXISTS qachon ishlatiladi?
--Javob: IF EXISTS SQL da obyekt yoki ma'lumot mavjudligini tekshirish uchun ishlatiladi.

--7. WHILE qachon ishlatmaslik kerak?
--Javob: Oddiy ma'lumot tanlash, o‘zgartirish yoki o‘chirishda (SELECT, UPDATE, DELETE).
--Agar bitta SQL so'rovi bilan muammoni hal qilish mumkin bo'lsa, WHILE ishlatmaslik kerak.
--Katta jadvallarda (performans juda pasayadi).
--Set-based operatsiyalarni (bitta so‘rov bilan) bajarish mumkin bo‘lsa.

--Qoida: Agar bir so‘rov bilan hal qilsa bo‘lsa — WHILE ishlatmang.
--WHILE faqat haqiqiy tsikl kerak bo‘lganda ishlatiladi.

--8. Infinite loop nima?
--Javob: Infinite loop — abadiy sikl. 
--Shart har doim TRUE bo‘lib qoladigan sikl. Dastur to‘xtamay, cheksiz ishlaydi.

--9. IIF nechta shartni tekshiradi?
--Javob: bitta shartni 

--10. BEGIN...END nima uchun kerak?
--Javob: BEGIN...END SQL da bir nechta buyruqni bir guruhga birlashtirish uchun kerak.



--📝 Practice (15 ta)

use TrainingDB;

--🟢 Easy (1–5)

--1. Salary >= 6000000 bo'lsa High, aks holda Low chiqaring (IIF bilan).

select 
	FullName,
	Salary,
	IIF(Salary >= 6000000, 'High', 'Low') as SalaryStatus
from Employees;

--2. IsActive qiymatini Active yoki Inactive qilib chiqaring (IIF bilan).

select 
	FullName,
	IsActive,
	IIF(IsActive = 1, 'Active', 'Inactive') as Status
from Employees;

--3. @Age = 20 o'zgaruvchisini yarating va IF yordamida Adult yoki Minor chiqaring.

declare @Age int = 20;

IF @Age >= 18
BEGIN
	PRINT 'Adult';
END
ELSE
BEGIN
	PRINT 'Minor';
END

--4. WHILE yordamida 1 dan 10 gacha sonlarni chiqaring. 

DECLARE @i INT = 1;

WHILE @i <= 10
BEGIN

    PRINT @i;

    SET @i = @i + 1;

END;

--5. WHILE yordamida 2 dan 20 gacha juft sonlarni chiqaring.

declare @i int = 2;

WHILE @i <= 20
BEGIN

	PRINT @i;

	SET @i = @i + 2;

END;

--🟡 Medium (6–10)

--6. @Score = 85 uchun:

--90+ → A
--80+ → B
--70+ → C
--aks holda → F

--(IF...ELSE IF yordamida)

declare @Score int = 85;

IF @Score >= 90
	PRINT 'A';
ELSE IF @Score >= 80
	PRINT 'B';
ELSE IF @Score >= 70
	PRINT 'C';
ELSE
	PRINT 'F';

--7. WHILE yordamida 1 dan 100 gacha yig'indini hisoblang.

declare @i int = 1;
declare @sum int = 0;

WHILE @i <= 100
BEGIN
	
	SET @sum = @sum + @i;

	SET @i = @i + 1;

END;

PRINT @sum;

--8. WHILE yordamida 10 dan 1 gacha teskari tartibda chiqaring.

declare @i int = 10;

WHILE @i >= 1
BEGIN

	PRINT @i;

	SET @i = @i - 1;

END;

--9. IF EXISTS yordamida Employees jadvalida Finance bo'limi mavjudligini tekshiring.

IF EXISTS 
(
	select * 
	from Employees
	where Department = 'Finance'
)
BEGIN
	PRINT 'Yes';
END
ELSE
BEGIN
	PRINT 'No';
END;

--10. IIF yordamida Salary >= 7000000 bo'lsa Premium, aks holda Standard chiqaring.

select
	Salary,
	IIF(Salary >= 7000000, 'Premium', 'Standard') as SalaryStatus
from Employees;

--🔴 Hard (11–15)

--11. WHILE yordamida 1 dan 20 gacha sonlardan faqat 3 ga karrali sonlarni chiqaring.

declare @i int = 1;

WHILE @i <= 20
BEGIN

	IF @i % 3 = 0         
        PRINT @i;
    
    SET @i = @i + 1;

END;

--12. IF EXISTS yordamida:
--agar faol bo'lmagan xodim mavjud bo'lsa Inactive Employees Found,
--aks holda All Employees Active
--degan xabar chiqaring.

IF EXISTS 
(
	select *
	from Employees
	where IsActive = 0
)
BEGIN
	PRINT 'Inactive Employees Found';
END
ELSE
BEGIN
	PRINT 'All Employees Active';
END;

--13. WHILE yordamida 1 dan 10 gacha sonlarning kvadratini (1, 4, 9, ...) chiqaring.

declare @i int = 1;

WHILE @i <= 10
BEGIN
	
	PRINT @i * @i;

	SET @i = @i + 1;

END;

--14. IIF yordamida:
--Salary >= 7000000 → High
--aks holda Low

--va shu bilan birga Departmentni ham chiqaring.

select
	Salary,
	IIF(Salary >= 7000000, 'High', 'Low') as SalaryStatus,
	Department
from Employees;

--15. IF yordamida quyidagini tekshiring:
--agar Employees jadvalida 20 tadan ortiq xodim bo'lsa:
--Enough Employees
--aks holda:
--Need More Employees

DECLARE @Count INT;

SELECT @Count = COUNT(*) FROM Employees;

IF @Count > 20
    PRINT 'Enough Employees';
ELSE
    PRINT 'Need More Employees'; 
	


--🏆 Bonus Challenge

--HR bo'limi quyidagi tekshiruvni so'radi:

--Agar IT bo'limida kamida bitta xodim bo'lsa:
--IT Department Exists
--Aks holda:
--No IT Department

--So'ng WHILE yordamida 1 dan 5 gacha sonlarni chiqaring.

--Bularni bitta skript ichida yozing.

IF EXISTS
(
    SELECT 1
    FROM Employees
    WHERE Department = 'IT'
)
BEGIN
    PRINT 'IT Department Exists';
END
ELSE
BEGIN
    PRINT 'No IT Department';
END;

DECLARE @i INT = 1;

WHILE @i <= 5
BEGIN
    PRINT @i;
    SET @i += 1;
END;
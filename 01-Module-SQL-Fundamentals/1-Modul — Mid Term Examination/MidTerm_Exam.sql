📝 PART 1 — Theory (30 ball)

Har biri 2 ball.

1. SQL nima?

Javob: SQL (Structured Query Language) — bu relatsion bazalarni boshqarish uchun standart til.

2. DBMS va RDBMS farqi nima?

Javob: DBMS — umumiy ma'lumotlar bazasini boshqarish tizimi (keng tushuncha).
RDBMS — DBMS ning bir turi, lekin jadval va SQL asosida ishlaydi. Hozirgi kunda eng ko‘p ishlatiladigan turidir.


3. DDL va DML buyruqlarini sanang.

Javob: DDL (Data Definition Language). Ma'lumotlar bazasi strukturasini belgilash buyruqlari - CREATE, ALTER, DROP
DML (Data Manipulation Language). Ma'lumotlar bilan ishlash buyruqlari - SELECT, INSERT, UPDATE, DELETE

4. DELETE, TRUNCATE va DROP farqini tushuntiring.

Javob: DELETE - ma'lumotni o'chirish.
TRUNCATE - jadvalni tozalash (ma'lumotlarni o‘chiradi, lekin struktura qoladi).
DROP — ob'ektni butunlay o‘chirish.

5. Constraint nima? Qanday turlari bor?

Javob: Constraint — bu ma'lumotlar bazasidagi jadval ustunlariga qo'yiladigan cheklovlar (qoidalar).
U ma'lumotlarning to'g'ri, toza va izchil bo'lishini ta'minlaydi.

Constraint turi,Ma'nosi,Misol
PRIMARY KEY - Har bir qatorni noyob (unique) aniqlaydigan ustun. Takrorlanmaydi va NULL bo'lmaydi, id ustuni
FOREIGN KEY - Boshqa jadvalning Primary Key bilan bog'lanish (referential integrity), user_id → users(id)
UNIQUE - Ustundagi qiymatlar takrorlanmasligi kerak (lekin NULL bo'lishi mumkin),"Email, telefon"
NOT NULL - Ustun bo'sh (NULL) bo'lmasligi kerak,"Ism, familiya"
CHECK - Maxsus shartni tekshirish,"age >= 18, price > 0"
DEFAULT - Qiymat kiritilmaganda avtomatik qiymat beradi, status DEFAULT 'active'

6. WHERE va HAVING farqi nima?

(Izoh: HAVINGni hali to'liq o'tmaganmiz. Agar bilmasang, bu savolni o'tkazib yuborishing mumkin. Men uni baholashda hisobga olmayman.)

Javob: Where - filterlash uchun ishlatiladi.
Having - group by bilan birgalikda filterlash uchun ishlatiladi.

7. BETWEEN inclusive yoki exclusive?

Javob: INCLUSIVE

8. LIKE operatoridagi % va _ farqi nima?

Javob: % = ko‘p belgi (0 yoki undan ko‘p)
_ = bitta belgi

9. UNION va UNION ALL farqi nima?

Javob: UNION = birlashtir + takrorlarni tozala
UNION ALL = birlashtir + hammasini qoldir (tezroq)

10. CASE va IF farqi nima?

Javob: Oddiy bitta shart → IF() (qisqaroq)
Bir nechta shart yoki murakkabroq mantiq → CASE

11. INTERSECT nima qiladi?

Javob: INTERSECT — ikki yoki undan ortiq SELECT natijalaridan umumiy (takrorlanadigan) qatorlarni qaytaradi.

12. EXCEPT nima qiladi?

Javob: EXCEPT — birinchi SELECT natijasidan ikkinchi SELECT da mavjud bo‘lgan qatorlarni olib tashlaydi.

13. TOP ni ORDER BY siz ishlatish tavsiya etiladimi? Nega?

Javob: Yo‘q, tavsiya etilmaydi.
TOP ni ORDER BY siz ishlatish ko‘pincha xato yoki ishonchsiz natija beradi.

14. DISTINCT nima qiladi?

Javob: DISTINCT — SELECT so‘rovida takroriy qatorlarni olib tashlaydi va faqat noyob (unique) qatorlarni qaytaradi.

15. WHILE qachon ishlatiladi?

Javob: WHILE — bu tsikl (loop) operatori. SQL da u ma'lum bir shart bajarilguncha biror amalni qayta-qayta bajarish uchun ishlatiladi.



💻 PART 2 — Practical (50 ball)

Bizning Employees jadvalidan foydalaning.

use TrainingDB;

--Task 1

--Faol xodimlarni maosh bo'yicha kamayish tartibida chiqaring.

select
	Fullname,
	Salary, 
	IsActive
from Employees
where IsActive = 1
order by Salary desc;

--Task 2

--2024-yildan keyin ishga kirgan xodimlarni chiqaring.

select
	Fullname,
	HireDate
from Employees
where HireDate >= '2025-01-01';

--Task 3

--Maoshi

--5 mln–8 mln

--orasidagi

--Finance

--va

--IT

--xodimlarini chiqaring.

select
	Fullname,
	Salary, 
	Department
from Employees
where Salary > 5000000
and Salary < 8000000
and Department in ('Finance', 'IT');

--Task 4

--SalaryLevel

--yarating.

--8 mln+ → A
--6–8 mln → B
--5–6 mln → C
--qolganlari → D

select
	Fullname,
	Salary, 
	case
		when Salary >= 8000000 then 'A'
		when Salary >= 6000000
			and Salary < 8000000 then 'B'
		when Salary >= 5000000
			and Salary < 6000000 then 'C'
		else 'D'
	end as SalaryLevel
from Employees;

--Task 5

--Status

--yarating.

--IIF

--ishlating.

select
	FullName,
	IsActive,
	IIF(IsActive = 1, 'Active', 'InActive') as Status
from Employees;

--Task 6

--Eng yuqori maosh oluvchi

--TOP 5

--faol xodimlar.

select top 5
	Fullname,
	Salary, 
	IsActive
from Employees
where IsActive = 1
order by Salary desc;

--Task 7

--2-sahifadagi

--5 ta

--xodim.

select
	Fullname
from Employees
order by EmployeeID
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;

--Task 8

--ITEmployees

--va

--FinanceEmployees

--jadvalining

--kesishmasini toping.

select
	FullName
from ITEmployees

INTERSECT

select
	FullName
from FinanceEmployees;

--Task 9

--Faqat

--FinanceEmployees

--jadvalidagi

--xodimlarni chiqaring.

select
	FullName
from FinanceEmployees;

--Task 10

--CEO hisoboti.

--Chiqsin:

--EmployeeName
--Department
--MonthlySalary
--Status
--SalaryLevel

--Natija:

--Department

--↓

--Salary DESC

select
	FullName as EmployeeName,
	Department,
	Salary as MonthlySalary,
	IIF(IsActive = 1, 'Active', 'InActive') as Status,
	case
		when Salary >= 7000000 then 'High Salary'
		when Salary >= 5000000 then 'Medium Salary'
		else 'Low Salary'
	end as SalaryLevel
from Employees
order by Department, Salary desc;




--🏢 PART 3 — Mini Project (20 ball)
--Employee Reporting System

--Bitta SQL fayl yozing.

--Unda quyidagilar bo'lsin.

--1.

--Agar

--Employees

--jadvali

--10 tadan kam yozuvga ega bo'lsa

--Need More Employees

--aks holda

--Enough Employees

DECLARE @RowsCount int = (select Count(*) from Employees)

IF @RowsCount < 10
	PRINT 'Need More Employees';
ELSE
	PRINT 'Enough Employees';

--2.

--CASE

--yordamida

--EmployeeCategory

--yarating.

--Shartlar:

--IT + Salary ≥ 7 mln → Premium
--Finance + Salary ≥ 6 mln → Business
--HR → Human Resources
--IsActive = 0 → Inactive
--aks holda → Standard

select 
	FullName,
	Department,
	Salary,
	IsActive,
	case
		when Department = 'IT'
			and Salary >= 7000000 then 'Premium'
		when Department = 'Finance'
			and Salary >= 6000000 then 'Business'
		when Department = 'HR' then 'Human Resources'
		when IsActive = 0 then 'InActive'
		else 'Standart'
	end as EmployeeCategory
from Employees;

--3.

--Faqat

--Premium

--xodimlarni chiqaring.

select 
	FullName,
	Department,
	Salary,
	IsActive,
	case
		when Department = 'IT'
			and Salary >= 7000000 then 'Premium'
		when Department = 'Finance'
			and Salary >= 6000000 then 'Business'
		when Department = 'HR' then 'Human Resources'
		when IsActive = 0 then 'InActive'
		else 'Standart'
	end as EmployeeCategory
from Employees
where Department = 'IT'
	and Salary >= 7000000;

--4.

--Oxirida

--TOP 5

--eng katta maosh oluvchi

--faol xodimlarni chiqaring.

select top 5
	Fullname,
	Salary,
	IsActive
from Employees
where IsActive = 1
order by Salary desc;




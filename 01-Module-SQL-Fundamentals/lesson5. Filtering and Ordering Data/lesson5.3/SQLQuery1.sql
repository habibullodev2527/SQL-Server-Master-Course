--🎤 Top 10 Interview Questions

--1. ORDER BY yozilmasa natija tartibi kafolatlanadimi?
--Javob: Yo'q kafolatlanmaydi.

--2. ASC va DESC farqi nima?
--Javob: Asc - o'sish tartibida. Desc - kamayish tartibida.

--3. TOP va TOP WITH TIES farqi?
--Javob: Top teng miqdorlarni chiqarmaydi. Top with ties - tenglarni ham chiqaradi.

--4. DISTINCT nima qiladi?
--Javob: Duplicatelarni olib tashlaydi.

--5. DISTINCT va GROUP BY bir xilmi?
--Javob: Yo'q Distinct - Duplicatelarni olib tashlaydi.
--Group by - guruhlash vazifasini bajaradi.

--6. OFFSET FETCH nima uchun ishlatiladi?
--Javob: pagination (sahifalarga bo‘lish) uchun ishlatiladi.

--7. OFFSET FETCH ishlatish uchun qaysi buyruq majburiy?
--Javob: OFFSET FETCH ishlashi uchun ORDER BY majburiy hisoblanadi.

--8. Alias nima?
--Javob: Alias — ustun yoki jadvalga vaqtinchalik nom berish.

--9. Nima uchun JOINlarda alias ishlatiladi?
--Javob: Kodni qisqartirish uchun (uzun jadval nomlarini qayta-qayta yozmaslik)
--Kodni o‘qilishini osonlashtirish uchun
--Bir xil nomdagi ustunlarni farqlash uchun

--10. TOP ni ORDER BYsiz ishlatish tavsiya etiladimi?
--Javob: Yo'q tavsiya etilmaydi.

--📝 Practice (15 ta)

--Bizning Employees jadvalidan foydalanamiz.

use TrainingDB;

--🟢 Easy (1–5)

--1. Barcha xodimlarni Salary bo'yicha o'sish tartibida chiqaring.

select 
	FullName,
	Salary
from Employees
order by Salary;

--2. Barcha xodimlarni Salary bo'yicha kamayish tartibida chiqaring.

select 
	FullName,
	Salary
from Employees
order by Salary desc;

--3. Eng yuqori maosh oluvchi 5 nafar xodimni chiqaring.

select top 5
	FullName,
	Salary
from Employees
order by Salary desc;

--4. Takrorlanmaydigan Departmentlarni chiqaring.

select distinct
	Department
from Employees;

--5. FullName ustunini EmployeeName nomi bilan chiqaring.

select 
	FullName as EmployeeName
from Employees;

--🟡 Medium (6–10)

--6. Department bo'yicha, so'ng Salary DESC bo'yicha saralang.

select 
	FullName,
	Salary,
	Department
from Employees
order by Department, Salary desc;

--7. Ikkinchi sahifadagi 5 ta xodimni chiqaring (OFFSET FETCH).

select 
	EmployeeID,
	FullName
from Employees
order by EmployeeID
offset 5 rows
fetch next 5 rows only;

--8. IsActive = 1 bo'lgan xodimlardan eng yuqori maosh oluvchi 3 nafarini chiqaring.

select top 3
	FullName,
	Salary,
	IsActive
from Employees
where IsActive = 1
order by Salary desc;

--9. Department va IsActive kombinatsiyalarini takrorlanmas holda chiqaring.

select distinct
	Department,
	IsActive
from Employees;

--10. Employees jadvaliga e aliasini berib FullName va Departmentni chiqaring.

select 
	e.FullName,
	e.Department
from Employees e;

--🔴 Hard (11–15)

--11. Eng yuqori maosh oluvchi 10 nafar faol xodimni chiqaring.

select top 10
	e.FullName,
	e.Salary,
	e.IsActive
from Employees e
where e.IsActive = 1
order by e.Salary desc;

--12. Finance bo'limidagi xodimlarni maosh bo'yicha kamayish tartibida chiqaring va ustunlarga alias bering.

select
	e.FullName as EmployeeName,
	e.Salary as EmployeeSalary,
	e.Department as EmployeeDpt
from Employees e
where e.Department = 'Finance'
order by EmployeeSalary desc;

--13. 2024-yildan keyin ishga kirgan xodimlardan 2-sahifadagi 3 ta yozuvni chiqaring.

select 
	e.EmployeeID,
	e.FullName,
	e.HireDate
from Employees e
where e.HireDate >= '2025-01-01'
order by EmployeeID
offset 3 rows
fetch next 3 rows only;

--14. Takrorlanmaydigan Departmentlarni alifbo tartibida chiqaring.

select distinct
	Department
from Employees
order by Department;

--15. TOP (5) WITH TIES yordamida eng yuqori maosh oluvchilarni chiqaring va oddiy TOP (5) bilan farqini kuzating.

select top 5 with ties
	e.FullName,
	e.Salary
from Employees e
order by e.Salary desc;

select top 5
	e.FullName,
	e.Salary
from Employees e
order by e.Salary desc;

--bu yerda top 5 with ties va top 5 o'rtasida farq maoshi bir xil bo'lganlarini 1-sida chiqadi, 2-sida chiqmaydi. 
--Agar 5 - dan keyingisi shunday bo'lib to'g'ri kelib qolsa.



--🏆 Bonus Challenge

--Bitta so'rov yozing:

--Faqat faol (IsActive = 1) xodimlar.
--Salary bo'yicha kamayish tartibida.
--3-sahifadagi 4 ta yozuv.
--FullName → EmployeeName
--Salary → MonthlySalary

--Bu yerda quyidagilar ishlatilishi kerak:
--WHERE
--ORDER BY
--OFFSET FETCH
--AS

select 
	e.EmployeeID,
	e.FullName as EmployeeName,
	e.Salary as MonthlySalary,
	e.IsActive
from Employees e
where e.IsActive = 1
order by MonthlySalary desc
offset 8 rows 
fetch next 4 rows only;
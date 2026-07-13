--🎤 Top 10 Interview Questions

--1. GROUP BY nima qiladi?

--Javob: GROUP BY — bir xil qiymatlarga ega qatorlarni bitta guruhga birlashtiradi.

--2. GROUP BY va DISTINCT farqi nima?

--Javob: DISTINCT — faqat takrorlanuvchi qatorlarni olib tashlaydi (unique qiymatlar chiqaradi).
--GROUP BY — qatorlarni guruhlaydi va har bir guruh bo‘yicha hisoblash (aggregation: COUNT, SUM, AVG va h.k.) imkonini beradi.

--3. WHERE va GROUP BY qaysi tartibda ishlaydi?

--Javob: WHERE har doim GROUP BY dan oldin ishlaydi.
--SQL bajarilish tartibi (Logical Order):

--FROM (jadvaldan ma'lumot olish)
--WHERE ← bu yerda filtrlanadi (individual qatorlar)
--GROUP BY ← guruhlash shu yerda sodir bo'ladi
--HAVING (guruhlangan natijalarni filtrlaydi)
--SELECT
--ORDER BY

--4. GROUP BY bilan COUNT() qanday ishlaydi?

--Javob: GROUP BY bir yoki bir nechta ustun bo‘yicha ma’lumotlarni guruhlaydi,
--COUNT() esa har bir guruhdagi qatorlar sonini hisoblaydi.

--5. GROUP BYda bir nechta ustun ishlatish mumkinmi?

--Javob: Ha, mumkin.

--6. Nega SELECTdagi barcha oddiy ustunlar GROUP BYda bo'lishi kerak?

--Javob: GROUP BY ishlatilganda, SELECT qismidagi barcha oddiy ustunlar (ya'ni aggregation funksiyasiz yozilgan ustunlar) GROUP BY da ham bo‘lishi shart.
--Nima uchun?
--Chunki GROUP BY har bir guruh uchun bitta qator chiqaradi. Agar SELECT da guruhlanmagan ustun bo‘lsa, o‘sha guruh ichida bir nechta turli qiymatlar bo‘lishi mumkin.
--DBMS qaysi qiymatni tanlashni bilmaydi — shuning uchun xatolik beradi.

--7. GROUP BYsiz AVG() ishlatish mumkinmi?

--Javob: Ha, mumkin.
--AVG() ni GROUP BY siz ham ishlatish mumkin. Bunda butun jadval bo‘yicha bitta umumiy o‘rtacha qiymat chiqadi.

--8. GROUP BY va ORDER BY birga ishlatiladimi?

--Javob: Ha, GROUP BY va ORDER BY birga juda tez-tez ishlatiladi.

--9. GROUP BYdan keyin HAVING nima uchun kerak?

--Javob: HAVING — guruhlangan natijalarni filtrlaydi. Ya'ni GROUP BY dan keyin ishlaydi.

--10. GROUP BYsiz bo'limlar kesimida hisobot olish mumkinmi?

--Javob: Yo‘q, odatda GROUP BY siz bo‘limlar kesimida (department bo‘yicha) to‘liq hisobot olish qiyin yoki imkonsiz.
--Nima uchun?
--Chunki siz har bir bo‘lim bo‘yicha alohida hisob (masalan, soni, o‘rtacha maosh, jami savdo va h.k.) olishni xohlaysiz. 
--Buning uchun ma’lumotlarni guruhlash kerak.




--📝 Practice (15 ta)

use TrainingDB;

--🟢 Easy (1–5)

--1. Har bir bo'limdagi xodimlar sonini chiqaring.

select
	Department,
	COUNT(*) as TotalCount
from Employees
group by Department;

--2. Har bir bo'limning jami maoshini chiqaring.

select
	Department,
	SUM(Salary) as TotalSalary
from Employees
group by Department;

--3. Har bir bo'limning o'rtacha maoshini chiqaring.

select
	Department,
	AVG(Salary) as AvgSalary
from Employees
group by Department;

--4. Har bir bo'limdagi eng katta maoshni chiqaring.

select
	Department,
	MAX(Salary) as MaxSalary
from Employees
group by Department;

--5. Har bir bo'limdagi eng kichik maoshni chiqaring.

select
	Department,
	MIN(Salary) as MinSalary
from Employees
group by Department;


--🟡 Medium (6–10)

--6. Faqat faol xodimlar bo'yicha har bir bo'limdagi xodimlar sonini chiqaring.

select
	Department,
	COUNT(*) as TotalCount
from Employees
where IsActive = 1
group by Department;

--7. Har bir bo'lim uchun:
--xodimlar soni,
--jami maosh,
--o'rtacha maosh.

select
	Department,
	COUNT(*) as TotalCount,
	SUM(Salary) as TotalSalary,
	AVG(Salary) as AvgSalary
from Employees
group by Department;

--8. Department va IsActive bo'yicha guruhlang va har bir guruhdagi xodimlar sonini chiqaring.

select
	Department,
	IsActive,
	COUNT(*) as TotalCount
from Employees
group by Department, IsActive;

--9. Har bir bo'limdagi eng yuqori maoshni chiqaring va natijani shu maosh bo'yicha kamayish tartibida saralang.

select
	Department,
	Max(Salary) as MaxSalary
from Employees
group by Department
order by MaxSalary desc;

--10. 2025-yilda ishga kirgan xodimlarni bo'limlar bo'yicha guruhlang va sonini chiqaring.

select
	Department,
	COUNT(*) as TotalCount
from Employees
where HireDate between '2025-01-01'
	and '2025-12-31'
group by Department;


--🔴 Hard (11–15)

--11. CEO hisoboti:
--Department
--EmployeesCount
--ActiveEmployees
--TotalSalary
--AverageSalary
--HighestSalary
--LowestSalary

--Eslatma: ActiveEmployees ustuni uchun SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) usulidan foydalanishga harakat qil.

select
	Department,
	COUNT(*) as EmployeesCount,
	SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) as ActiveEmployees,
	SUM(Salary) as TotalSalary,
	Avg(Salary) as AvgSalary,
	MAX(Salary) as HighestSalary,
	MIN(Salary) as LowestSalary
from Employees
group by Department;

--12. Faqat IT va Finance bo'limlari uchun:
--xodimlar soni,
--o'rtacha maosh,
--jami maosh.

select
	Department,
	COUNT(*) as TotalCount,
	AVG(Salary) as AvgSalary,
	SUM(Salary) as TotalSalary
from Employees
where Department in ('IT', 'Finance')
group by Department;

--13. Har bir bo'limdagi faol xodimlarning eng katta maoshini chiqaring.

select
	Department,
	MAX(Salary) as MaxSalary
from Employees
where IsActive = 1
group by Department;

--14. Har bir bo'lim bo'yicha:
--2025-yilda ishga kirgan xodimlar soni.

select
	Department,
	COUNT(*) as TotalCount
from Employees
where HireDate between '2025-01-01'
	and '2025-12-31'
group by Department;

--15. Bitta SQL so'rov yozing va quyidagilarni chiqaring:
--Department
--EmployeesCount
--ActiveEmployees
--InactiveEmployees
--AverageSalary
--TotalSalary

select
	Department,
	COUNT(*) as EmployeesCount,
	SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) as ActiveEmployees,
	SUM(CASE WHEN IsActive = 0 THEN 1 ELSE 0 END) as InActiveEmployees,
	Avg(Salary) as AvgSalary,
	SUM(Salary) as TotalSalary
from Employees
group by Department;



--🏢 Real Business Case
--Task 16 — HR Analytics Dashboard

--HR direktori quyidagi KPIlarni har bir bo'lim kesimida ko'rmoqchi:

--📁 Department
--👥 Total Employees
--✅ Active Employees
--❌ Inactive Employees
--💰 Total Salary
--📈 Average Salary
--🔺 Highest Salary
--🔻 Lowest Salary

--Natijani Average Salary bo'yicha kamayish tartibida saralang.

select
	Department,
	COUNT(*) as TotalEmployees,
	SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) as ActiveEmployees,
	SUM(CASE WHEN IsActive = 0 THEN 1 ELSE 0 END) as InActiveEmployees,
	SUM(Salary) as TotalSalary,
	Avg(Salary) as AvgSalary,
	MAX(Salary) as HighestSalary,
	MIN(Salary) as LowestSalary
from Employees
group by Department
order by AvgSalary desc;
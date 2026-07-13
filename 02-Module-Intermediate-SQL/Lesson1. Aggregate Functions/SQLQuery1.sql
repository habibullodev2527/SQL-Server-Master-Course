--🎤 Top 10 Interview Questions

--1. Aggregate Function nima?

--Javob: Aggregate Function — bu bir nechta qator ustida hisob-kitob qilib bitta natija qaytaradigan funksiya.

--2. COUNT(*) va COUNT(column) farqi?

--Javob: COUNT(*) - qatorlar sonini qaytaradi
--COUNT(column) - Biror ustun bo'yicha NULL bo'lmagan qiymatlar sanaladi.

--3. COUNT(DISTINCT) nima qiladi?

--Javob: Takrorlanmaydigan qiymatlar soni.

--4. SUM() qaysi data typelarda ishlaydi?

--Javob: int, float, decimal

--5. AVG() NULLlarni hisoblaydimi?

--Javob: yo'q hisoblamaydi.

--6. MIN() va MAX() faqat sonlar uchunmi?

--Javob: Yo‘q, faqat sonlar uchun emas.
--MIN() va MAX() funksiyalari turli xil ma’lumot turlarida ishlaydi.

--7. COUNT(*) va COUNT(1) farqi bormi?

--Javob: Farqi yo'q. Lekin Count(*) dan foydalanish tavsiya etiladi.

--8. SUM() va AVG()ni WHERE bilan ishlatish mumkinmi?

--Javob: WHERE agregatsiyadan oldin ishlaydi. Shuning uchun SUM() va AVG() funksiyalarini WHERE ichida ishlatib bo'lmaydi.
--Ular SELECT yoki keyinchalik o'rganadigan HAVING bilan ishlatiladi.

--9. COUNT(*) nima uchun COUNT(column)dan ko'proq natija berishi mumkin?

--Javob: Chunki Count(column) NULL bo'lgan qiymatlar sanalmaydi.

--10. Aggregate Function nechta qiymat qaytaradi?

--Javob: Aggregate Function har doim bitta qiymat qaytaradi.



--📝 Practice (15 ta)

use TrainingDB;

🟢 Easy (1–5)

--1. Employees jadvalidagi jami xodimlar sonini chiqaring.

select
	Count(*) as TotalEmployees
from Employees;

--2. Faol xodimlar sonini chiqaring.

select
	Count(*) as TotalEmployees
from Employees
where IsActive = 1;


--3. Eng katta maoshni chiqaring.

select
	Max(Salary) as MaxSalary
from Employees;

--4. Eng kichik maoshni chiqaring.

select
	Min(Salary) as MinSalary
from Employees;

--5. Barcha xodimlar maoshining yig'indisini chiqaring.

select
	Sum(Salary) as TotalSalary
from Employees;

--🟡 Medium (6–10)

--6. Faol xodimlarning o'rtacha maoshini chiqaring.

select
	Avg(Salary) as AvgSalary
from Employees
where IsActive = 1;

--7. IT bo'limidagi xodimlar sonini chiqaring.

select
	Count(*) as TotalDeptEmployees
from Employees
where Department = 'IT';

--8. Finance bo'limidagi jami maoshni chiqaring.

select
	Sum(Salary) as TotalDeptSalary
from Employees
where Department = 'Finance';

--9. Takrorlanmaydigan bo'limlar sonini chiqaring.

select
	Count(DISTINCT Department) as TotalDeptEmployees
from Employees;

--10. 2025-yilda ishga kirgan xodimlar sonini chiqaring.

select
	Count(*) as TotalEmployees
from Employees
where HireDate between '2025-01-01'
	and '2025-12-31';

--🔴 Hard (11–15)
--11. Faol xodimlar ichida:
--eng katta maosh,
--eng kichik maosh,
--o'rtacha maoshni bitta so'rovda chiqaring.

select
	Max(Salary) as MaxSalary,
	Min(Salary) as MinSalary,
	Avg(Salary) as AvgSalary
from Employees
where IsActive = 1;

--12. IT va Finance bo'limlaridagi xodimlarning jami maoshini chiqaring.

select
	Sum(Salary) as TotalSalary
from Employees
where Department in ('IT', 'Finance');

--13. Maoshi 6 mln dan yuqori bo'lgan xodimlar sonini chiqaring.

select
	Count(*) as TotalEmployees
from Employees
where Salary > 6000000;

--14. 2024-yildan keyin ishga kirgan faol xodimlar sonini chiqaring.

select
	Count(*) as TotalEmployees
from Employees
where IsActive = 1
	and HireDate >= '2025-01-01'

--15. Bitta so'rov yozing va quyidagilarni chiqaring:
--Jami xodimlar soni
--Faol xodimlar soni
--Eng katta maosh
--Eng kichik maosh
--O'rtacha maosh
--Jami maosh

select
	Count(*) as TotalEmployees,
	Count(case when IsActive=1 then 1 end) as ActiveEmployees,
	Max(Salary) as MaxSalary,
	Min(Salary) as MinSalary,
	Avg(Salary) as AvgSalary,
	Sum(Salary) as TotalSalary
from Employees;


--🏢 Real Business Case
--Task 16 — CEO Dashboard

--CEO kompaniya bo'yicha quyidagi KPI (Key Performance Indicators) ni so'radi:

--👥 Total Employees
--✅ Active Employees
--💰 Total Salary
--📈 Average Salary
--🔺 Highest Salary
--🔻 Lowest Salary

--Natijani bitta SQL so'rov bilan chiqaring va barcha ustunlarga tushunarli alias bering.

select
	Count(*) as TotalEmployees,
	Count(case when IsActive=1 then 1 else 0  end) as ActiveEmployees,
	Sum(Salary) as TotalSalary,
	Avg(Salary) as AvgSalary,
	Max(Salary) as HighestSalary,
	Min(Salary) as LowestSalary
from Employees;
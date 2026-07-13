--🎤 Top 10 Interview Questions

--1. CASE nima?
Javob: Sqlda shart operatori.

--2. CASE va IF o'rtasidagi farq nima?
--Javob: CASE — bu expression (ifoda). Uni SELECT da to'g'ridan-to'g'ri ustun sifatida ishlatish mumkin.
--IF — bu statement (buyruq). Uni faqat procedural kod ichida (stored procedure, function) ishlatish mumkin.

--3. ELSE yozilmasa nima bo'ladi?
--Javob: CASE da ELSE yozilmasa → NULL qaytaradi.

--4. CASE qaysi tartibda ishlaydi?
--Javob: Yuqoridan pastga tekshiradi.
--Birinchi to'g'ri shart bajariladi va to'xtaydi.

--5. CASEni ORDER BY ichida ishlatish mumkinmi?
--Javob: CASE ORDER BY ichida juda yaxshi ishlaydi (sortlash uchun).

--6. CASEni GROUP BY bilan ishlatish mumkinmi?
--Javob: Ha, mumkin.

--7. CASE ichida AND ishlatish mumkinmi?
--Javob: Ha, mumkin.

--8. CASE ichida CASE yozish mumkinmi?
--Javob: Ha, mumkin.

--9. CASE yangi ustun yaratadimi?
--Javob: Ha, yaratadi.

--10. CASE ma'lumotni o'zgartiradimi?
--Javob: Yo'q, o'zgartirmaydi.


--📝 Practice (15 ta)

use TrainingDB;

--🟢 Easy (1–5)

--1. Har bir xodim uchun IsActive qiymatini Active yoki Inactive ko'rinishida chiqaring.

select 
	FullName,
	case
		when IsActive = 1 then 'Active'
		else 'Inactive'
	end as Status
from Employees;

--2. Maoshi 5 000 000 dan katta bo'lsa High, aks holda Low chiqaring.

select 
	FullName,
	Salary,
	case
		when Salary > 5000000 then 'High'
		else 'Low'
	end as SalaryStatus
from Employees;

--3. Department = 'IT' bo'lsa Technical, aks holda Other chiqaring.

select 
	FullName,
	Department,
	case
		when Department = 'IT' then 'Technical'
		else 'Other'
	end as Status
from Employees;

--4. HireDate 2024-yildan keyin bo'lsa New Employee, aks holda Old Employee chiqaring.

select 
	FullName,
	HireDate,
	case
		when HireDate >= '2025-01-01' then 'New Employee'
		else 'Old Employee'
	end as Status
from Employees;

--5. Har bir xodim uchun SalaryLevel nomli yangi ustun yarating.

select
	FullName,
	Salary as SalaryLevel
from Employees;

--🟡 Medium (6–10)

--6. Maoshi:
--7 mln va undan yuqori → Excellent
--5–7 mln → Good
--aks holda → Average

select 
	FullName,
	Salary,
	case
		when Salary > 7000000 then 'Excellent'
		when Salary between 5000000 and 7000000 then 'Good'
		else 'Average'
	end as SalaryStatus
from Employees;

--7. Department:
--IT → Technical
--HR → Human Resources
--Finance → Finance Team
--qolganlari → Other

select 
	FullName,
	Department,
	case
		when Department = 'IT' then 'Technical'
		when Department = 'HR' then 'Human Resources'
		when Department = 'Finance' then 'Finance Team'
		else 'Other'
	end as Status
from Employees;

--8. Faol va maoshi 6 mln dan yuqori bo'lsa Bonus Eligible, aks holda Not Eligible.

select 
	FullName,
	Salary,
	IsActive,
	case
		when IsActive = 1 and Salary > 6000000 then 'Bonus Eligible'
		else 'Not Eligible'
	end as SalaryStatus
from Employees;

--9. ORDER BY CASE yordamida avval faol xodimlar, keyin faol bo'lmaganlarni chiqaring.

select 
	FullName,
	IsActive
from Employees
order by case
			when IsActive = 1 then 1
			else 2
		end;

--10. Salary bo'yicha:
--8 mln+ → Grade A
--6–8 mln → Grade B
--4–6 mln → Grade C
--qolganlari → Grade D

select 
	FullName,
	Salary,
	case
		when Salary > 8000000 then 'Grade A'
		when Salary between 6000000 and 8000000 then 'Grade B'
		when Salary between 4000000 and 6000000 then 'Grade C'
		else 'Grade D'
	end as SalaryStatus
from Employees;

--🔴 Hard (11–15)
--11. Quyidagi ustunni yarating:
--IT + Salary ≥ 7 mln → Senior IT
--IT + Salary < 7 mln → Junior IT
--Finance → Finance Staff
--HR → HR Staff
--qolganlari → General Employee

select 
	FullName,
	Salary,
	Department,
	case
		when Department = 'IT' and Salary >= 7000000 then 'Senior IT'
		when Department = 'IT' and Salary < 7000000 then 'Junior IT'
		when Department = 'Finance' then 'Finance Staff'
		when Department = 'HR' then 'HR Staff'
		else 'General Employee'
	end as EmployeeStatus
from Employees;

--12. CASE yordamida PerformanceLevel ustuni yarating:
--Salary ≥ 8 mln → Outstanding
--Salary ≥ 6 mln → Excellent
--Salary ≥ 5 mln → Good
--aks holda → Needs Improvement

select 
	FullName,
	Salary,
	case
		when Salary >= 8000000 then 'Outstanding'
		when Salary >= 6000000 then 'Excellent'
		when Salary >= 5000000 then 'Good'
		else 'Needs Improvement'
	end as PerformanceLevel
from Employees;

--13. CASEni ORDER BY ichida ishlatib:
--Finance birinchi
--IT ikkinchi
--qolganlari oxirida chiqsin.

select
	FullName,
	Department
from Employees
order by case
			when Department = 'Finance' then 1
			when Department = 'IT' then 2
			else 3
		end;

--14. CASE yordamida ExperienceLevel ustuni yarating:
--2025-yilda ishga kirgan → New Hire
--2024-yilda → Intermediate
--undan oldin → Experienced

select 
	FullName,
	HireDate,
	case
		when HireDate between '2025-01-01' and '2025-12-31' then 'New Hire'
		when HireDate between '2024-01-01' and '2024-12-31' then 'Intermediate'
		else 'Experienced'
	end as ExperienceLevel
from Employees;

--15. Salary, Department, IsActive uchalasiga qarab yagona EmployeeCategory ustuni yarating.
--Masalan:
--IT + Active + Salary ≥ 7 mln → Premium
--Finance + Active → Business
--Inactive → Former
--qolganlari → Standard

select 
	FullName,
	Salary,
	IsActive,
	Department,
	case
		when Department = 'IT' and IsActive = 1 and Salary >= 7000000 then 'Premium'
		when Department = 'Finance' and IsActive = 1 then 'Business'
		when IsActive = 0 then 'Former'
		else 'Standart'
	end as EmployeeCategory
from Employees;



--🏆 Bonus Challenge

--CEO quyidagi hisobotni so'radi:
--FullName	Department	Salary	Status	Category

--Bu yerda:
--Status → CASE orqali (Active / Inactive)
--Category:
--Salary ≥ 7 mln → High Income
--Salary ≥ 5 mln → Medium Income
--aks holda → Low Income

--Barcha ustunlarni bitta SELECT ichida chiqar.

select 
	FullName,
	Department,
	Salary,
	case 
		when IsActive = 1 then 'Active'
		else 'Inactive'
	end as Status,
	case
		when Salary >= 7000000 then 'High Income'
		when Salary >= 5000000 then 'Medium Income'
		else 'Low Income'
	end as Category
from Employees;
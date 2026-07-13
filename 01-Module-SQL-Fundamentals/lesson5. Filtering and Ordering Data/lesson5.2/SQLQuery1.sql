--🎤 Interview Corner

--1. BETWEEN inclusive yoki exclusive?
--Javob: BETWEEN — inclusive (qo'shib hisoblanadi).

--2. IN va OR o'rtasidagi farq?
--Javob: IN — qisqa, o'qilishi oson va ko'p qiymatlar uchun yaxshi.
--OR — ko'p qiymat bo'lsa, kod uzun va chalkash bo'ladi.

-- 3. % nimani bildiradi?
--Javob: % — "nima bo'lsa bo'lsin" yoki "0 yoki undan ko'p harf" degani.

--4. _ nimani bildiradi?
--Javob: _ (pastki chiziq) esa bitta harfni bildiradi.

--5. LIKE va = qachon ishlatiladi?
--Javob: =:
--Qiymat to‘liq bir xil bo‘lishi kerak bo‘lsa
--Raqamlar, ID lar, status lar bilan ishlashda
--Tezroq ishlaydi (indexdan foydalanadi)

--LIKE:
--Matn ichida qisman qidirish kerak bo‘lsa
--Boshlanishi, tugashi yoki ichida bo‘lishi kerak bo‘lsa
--% va _ wildcard lar bilan

--📝 Practice (15 ta)

use TrainingDB;

--🟢 Easy (1–5)

--Task1. Maoshi 4 000 000 va 6 000 000 orasidagi xodimlarni chiqaring.

select
	FullName,
	Salary
from Employees
where Salary between 4000000 and 6000000;

--Task2. IT, HR yoki Finance bo'limidagi xodimlarni chiqaring.

select
	FullName,
	Department
from Employees
where Department in ('IT', 'HR', 'Finance');

--Task3. Ismi A harfi bilan boshlanadigan xodimlarni chiqaring.

select
	FullName
from Employees
where FullName like 'A%';

--Task4. Emaili gmail.com bilan tugaydigan xodimlarni chiqaring.

select
	FullName,
	Email
from Employees
where Email like '%gmail.com';

--Task5. 2024-yilda ishga kirgan xodimlarni chiqaring.

select
	FullName,
	HireDate
from Employees
where HireDate between '2024-01-01' and '2024-12-31';

--🟡 Medium (6–10)

--Task6. IT va Finance bo'limidan tashqari barcha xodimlarni chiqaring.

select
	FullName,
	Department
from Employees
where Department not in ('IT', 'Finance');

--Task7. Maoshi 4 mln–7 mln orasida va faol bo'lgan xodimlarni chiqaring.

select
	FullName,
	Salary,
	IsActive
from Employees
where Salary between 4000000 and 7000000
and IsActive = 1;

--Task8. Familiyasi ov bilan tugaydigan xodimlarni chiqaring.

select
	FullName
from Employees
where FullName like '%ov';

--Task9. Ismida "bek" qatnashgan xodimlarni chiqaring.

select
	FullName
from Employees
where FullName like '%bek%';

--Task10. Ismi A yoki B harfi bilan boshlanadigan xodimlarni chiqaring.

select
	FullName
from Employees
where FullName like '[AB]%';

--🔴 Hard (11–15)

--Task11. HR, IT, Finance bo'limidagi, maoshi 5–8 mln orasidagi va 2024-yildan keyin ishga kirgan faol xodimlarni chiqaring.

select
	FullName,
	Salary,
	IsActive,
	HireDate,
	Department
from Employees
where Department in ('IT', 'HR', 'Finance')
and Salary between 5000000 and 8000000
and HireDate > '2024-12-31'
and IsActive = 1;

--Task12. Emaili gmail.com bilan tugaydigan, lekin Marketing bo'limida ishlamaydigan xodimlarni chiqaring.

select
	FullName,
	Email,
	Department
from Employees
where Email like '%gmail.com'
and Department <> 'Marketing';

--Task13. Ismi A bilan boshlanadigan yoki familiyasi ov bilan tugaydigan xodimlarni chiqaring.

select
	FullName
from Employees
where FullName like 'A%'
or FullName like '%ov';

--Task14. Ismi A yoki J bilan boshlanadigan va maoshi 6 mln dan yuqori xodimlarni chiqaring.

select
	FullName,
	Salary
from Employees
where FullName like '[AJ]%'
and Salary > 6000000;

--Task15. Support yoki Sales bo'limida ishlaydigan, faol bo'lmagan va 2022–2024 oralig'ida ishga kirgan xodimlarni chiqaring.

select
	FullName,
	IsActive,
	HireDate,
	Department
from Employees
where Department in ('Support', 'Sales')
and IsActive = 0
and HireDate between '2022-01-01' and '2024-12-31';


--🏆 Bonus Challenge

--Bitta so'rov yozing:

--Department → IT, Finance yoki Marketing
--Salary → 5 000 000–8 000 000
--HireDate → 2023–2025
--FullName → A yoki S harfi bilan boshlansin
--IsActive = 1

--Bu yerda quyidagi operatorlarning barchasi ishlatilishi kerak:
--IN
--BETWEEN
--LIKE
--AND
--OR

select
	FullName,
	Salary,
	IsActive,
	HireDate,
	Department
from Employees
where Department in ('IT', 'Finance', 'Marketing')
and Salary between 5000000 and 8000000
and HireDate between '2023-01-01' and '2025-12-31'
and FullName like '[AS]%'
and IsActive = 1;
--🎤 Top 10 Interview Questions

--1. UNION va UNION ALL farqi nima?
--Javob: Union		  |  Union all
--duplicate yo'q	  | Duplikate bor
--sekinroq ishlaydi   | Tezroq ishlaydi
--sort qiladi		  | Sort qilmaydi

--2. Qaysi biri tezroq?
--Javob: Union All tezroq

--3. INTERSECT nima qiladi?
--Javob: Ikkala SELECT'da ham mavjud qiymatlarni chiqaradi.

--4. EXCEPT nima qiladi?
--Javob: Birinchi SELECT'da bor, ikkinchisida yo'q.

--5. Set Operator ishlashi uchun qanday shartlar bajarilishi kerak?
--Javob: ikkala selectda ham ustunlar soni teng va data typelari bir xil bo'lishi kerak.

--6. ORDER BY qayerda yoziladi?
--Javob: kodni oxirgi qismida 

--7. UNION duplicate bilan qanday ishlaydi?
--Javob: duplicatelarni olib tashlaydi.

--8. UNION ALL duplicate bilan qanday ishlaydi?
--Javob: duplicatelarni olib tashlamaydi.

--9. EXCEPT va NOT IN bir xilmi?
--Javob: Yo'q, bir xil emas.
--EXCEPT — ikki so'rov orasidagi farqni topadi (to'liq qatorlar bo'yicha).
--NOT IN — bitta ustun qiymati ro'yxatda yo'qligini tekshiradi.
--Qisqa farq:
--EXCEPT kuchliroq va xavfsizroq (NULL bilan yaxshi ishlaydi).
--NOT IN oddiyroq, lekin NULL da muammo chiqarishi mumkin.

--10. INTERSECT va INNER JOIN o'rtasida qanday farq bor?
--Javob: INTERSECT — Set operatsiyasi (to‘liq moslik).
--INNER JOIN — Jadvalni bog‘lash (join sharti bo‘yicha).

--Tavsiya: Bitta ustun bo‘yicha bo‘lsa — JOIN tezroq va moslashuvchan. Ko‘p ustunli aniq moslik kerak bo‘lsa — INTERSECT qulay.



--📝 Practice (15 ta)

use TrainingDB;

--ITEmployees

CREATE TABLE ITEmployees
(
    FullName NVARCHAR(100)
);

INSERT INTO ITEmployees
VALUES
('Ali'),
('Kamron'),
('Aziza'),
('Jasur'),
('Malika');

--FinanceEmployees

CREATE TABLE FinanceEmployees
(
    FullName NVARCHAR(100)
);

INSERT INTO FinanceEmployees
VALUES
('Aziza'),
('Jasur'),
('Bobur'),
('Madina'),
('Malika');

--🟢 Easy (1–5)

--1. ITEmployees jadvalidagi barcha ismlarni chiqaring.

select
	FullName
from ITEmployees;

--2. FinanceEmployees jadvalidagi barcha ismlarni chiqaring.

select
	FullName
from FinanceEmployees;

--3. UNION yordamida ikkala jadvalni birlashtiring.

select
	FullName
from ITEmployees

Union

select
	FullName
from FinanceEmployees;

--4. UNION ALL yordamida birlashtiring.

select
	FullName
from ITEmployees

Union all

select
	FullName
from FinanceEmployees;

--5. Natijalarni taqqoslab, UNION va UNION ALL farqini yozing.

--Union bilan ishlaganda duplicatelar olib tashlandi.
--Union all bilan ishlaganda duplicatelar saqlandi.

--🟡 Medium (6–10)

--6. INTERSECT yordamida ikkala jadvalda ham mavjud bo'lgan xodimlarni chiqaring.

select
	FullName
from ITEmployees

INTERSECT

select
	FullName
from FinanceEmployees;

--7. EXCEPT yordamida faqat ITEmployees dagi xodimlarni chiqaring.

select
	FullName
from ITEmployees

EXCEPT

select
	FullName
from FinanceEmployees;

--8. EXCEPT yordamida faqat FinanceEmployees dagi xodimlarni chiqaring.


select
	FullName
from FinanceEmployees

EXCEPT

select
	FullName
from ITEmployees;

--9. UNION natijasini alifbo bo'yicha saralang.


select
	FullName
from ITEmployees

UNION

select
	FullName
from FinanceEmployees
order by FullName;

--10. UNION ALL natijasini alifbo bo'yicha kamayish tartibida saralang.

select
	FullName
from ITEmployees

UNION ALL

select
	FullName
from FinanceEmployees
order by FullName desc;

--🔴 Hard (11–15)

--11. Employees jadvalidan:
--IT bo'limidagi xodimlar
--va Finance bo'limidagi xodimlarni

--UNION yordamida chiqaring.

select
	FullName
from Employees
where Department = 'IT'

UNION

select
	FullName
from Employees
where Department = 'Finance';

--12. Xuddi shu vazifani UNION ALL bilan bajaring.

select
	FullName
from Employees
where Department = 'IT'

UNION ALL

select
	FullName
from Employees
where Department = 'Finance';

--13. Employees jadvalidan:
--faol (IsActive = 1)
--va maoshi 6000000 dan yuqori bo'lgan xodimlarni

--INTERSECT yordamida toping.

select
	FullName
from Employees
where IsActive = 1

INTERSECT

select
	FullName
from Employees
where Salary > 6000000;

--14. Employees jadvalidan:
--barcha faol xodimlar
--minus (EXCEPT)
--IT bo'limidagi faol xodimlar

--natijasini chiqaring.

select
	FullName
from Employees
where IsActive = 1

EXCEPT

select
	FullName
from Employees
where Department = 'IT' and IsActive = 1;

--15. UNION va UNION ALL o'rtasidagi performance farqini o'zingizning so'zlaringiz bilan yozing.

--UNION - duplicate yo'q, sekinroq ishlaydi, sort qiladi.
--UNION ALL - duplicate bor, tezroq ishlaydi, sort qilmaydi.



--🏆 Bonus Challenge

--CEO quyidagi hisobotni so'radi:

--IT bo'limidagi barcha xodimlar.
--Finance bo'limidagi barcha xodimlar.
--Takroriy ism faqat bir marta chiqishi kerak.
--Natija alifbo tartibida bo'lsin.

--Buni bitta SQL so'rov bilan yozing.

select
	FullName
from Employees
where Department = 'IT'

UNION

select
	FullName
from Employees
where Department = 'Finance'
order by FullName;
--🟢 Easy (1–5)

--task1. CSV fayl nima? Qisqacha izohlang.

--CSV (Comma Separated Values) — oddiy matnli fayl. Unda ma'lumotlar odatda vergul (,` ) bilan ajratiladi.

--task2. Excel va CSV o'rtasidagi farqni yozing.

--CSV — bu oddiy, universal va yengil ma'lumot saqlash formati.
--Excel — bu to‘liq dastur va format bilan birga keladigan kuchli jadval fayli.

--task3. SSMS orqali Import Wizard qaysi menyuda joylashgan?

--Database

--↓

--Right Click

--↓

--Tasks

--↓

--Import Flat File...

--yoki

--Tasks

--↓

--Import Data...

--task4. FIRSTROW = 2 nimani anglatadi?

--FIRSTROW = 2 degani: Ma'lumotlar 2-qatordan boshlanadi.
--Ya'ni:
--1-qator (birinchi qator) sarlavha (header), izoh yoki boshqa ma'lumot uchun ajratilgan.
--Haqiqiy ma'lumotlar (jadval) esa 2-qatordan boshlab o'qiladi.

--task5. FIELDTERMINATOR = ',' nimani bildiradi?

--FIELDTERMINATOR — fayldagi ustunlarni (maydonlarni) ajratuvchi belgi ni bildiradi.
--',' — vergul (comma) bilan ajratilganligini bildiradi.

--🟡 Medium (6–10)

--task6. BULK INSERT sintaksisini yozing.

--BULK INSERT JadvalNomi
--FROM 'Faylning_to'liq_yoli'
--WITH (
--    FIELDTERMINATOR = ',',        -- ustunlarni ajratuvchi belgi
--    ROWTERMINATOR = '\n',         -- qatorlarni ajratuvchi belgi
--    FIRSTROW = 2,                 -- qaysi qatordan boshlash
--    CODEPAGE = '65001',           -- UTF-8 uchun
--    DATAFILETYPE = 'char',        -- matnli fayl
--    FORMAT = 'CSV',               -- CSV format (SQL Server 2017+)
--    ROWS_PER_BATCH = 10000,       -- ixtiyoriy
--    ERRORFILE = 'C:\Errors\error.log'  -- xatolar uchun fayl
--);

--task7. ROWTERMINATOR nima vazifa bajaradi?

--ROWTERMINATOR — BULK INSERT komandasida har bir qatorning oxirini belgilaydigan parametr.

--task8. Nima uchun import paytida Data Type xatosi chiqadi?

--Data Type xatosi chiqishining asosiy sabablari:
--Jadval ustuni tipi (INT, DATE, DECIMAL) CSV dagi ma’lumotga mos kelmaydi.
--Sonlarda vergul o‘rniga nuqta ishlatilishi kerak.
--Sana formati noto‘g‘ri.
--Matn juda uzun yoki bo‘sh qiymatlar muammosi.

--task9. Nima uchun importdan oldin CSV faylni tekshirish tavsiya etiladi?

--Data Type xatolarini oldini olish — matn son ustuniga tushib qolishi, sana formati mos kelmasligi va h.k.
--Vergul muammosi — ichki vergullar (masalan, "Ahmadov, Ali") ustunlarni buzib yuboradi.
--Kodirovka (UTF-8) muammolari — o‘zbekcha harflar buzilishi mumkin.
--Bo‘sh qatorlar, ortiqcha bo‘shliqlar va sarlavha joylashuvi.
--Qator soni va sifatini oldindan bilish.

--task10. CHECK constraint importga qanday ta'sir qiladi?

--Agar CSV fayldagi ma'lumot CHECK shartini buzsa, o‘sha qator import qilinmaydi yoki butun import jarayoni xato bilan to‘xtaydi.
--CHECK qoidasi bajarilmasa (masalan, yosh > 0, narx >= 0, status IN ('active','inactive')), server Data Type emas, balki Constraint Violation xatosi chiqaradi.

--🔴 Hard (11–15)

--task11. 1 million qatorli CSV faylni import qilish kerak. Qaysi usulni tanlaysan va nima uchun?

--BULK INSERT ni tanlayman. SQL Server Engine bilan bevosita ishlaydi. Millionlab yozuvlar uchun juda tez.
--Qo'lda INSERT qilishdan bir necha barobar samarali.

--task12. Import vaqtida Age = 'Twenty' bo'lsa nima sodir bo'ladi?

--Bunda Data type xatoligi kelib chiqishi mumkin.

--Conversion failed when converting the varchar value 'Twenty' to data type int.

--task13. Nima uchun real loyihalarda ma'lumotlar avval Staging Table ga yuklanadi?

--Asosiy jadvalni xatolardan himoya qilish
--Ma’lumotlarni tozalash va tekshirish oson
--Importni tezroq bajarish (CHECK va indexlarsiz)
--Xatolar bo‘lsa, osongina qayta yuklash mumkin
--Transformatsiya (tozalash, o‘zgartirish) uchun qulay

--task14. Permission denied xatosining ehtimoliy sabablarini yozing.

--Permission denied xatosining asosiy sabablari:

--SQL Server xizmat hisobida faylni o‘qish ruxsati yo‘q
--Papka yoki faylga kirish cheklangan
--Network (UNC) yo‘l bo‘lsa muammo chiqadi
--Foydalanuvchida BULK ADMIN huquqi yetarli emas
--Fayl boshqa dasturda ochiq turgan

--Eng tez yechim: Faylni C:\Temp ga ko‘chirib urinib ko‘ring.

--task15. Agar CSV faylda 10 ta ustun bo'lsa, jadvalda esa 9 ta ustun bo'lsa, qanday muammo yuzaga keladi?

--CSV da 10 ustun, jadvalda 9 ustun bo‘lsa — ustunlar soni mos kelmasligi sababli import xato bilan tugaydi (Column count mismatch).
--Import umuman ishlamaydi.
--Ustunlar sonini moslashtirish kerak.



--🏆 Bugungi Bonus Challenge

--Internetdan kichik (20–50 qatorli) CSV fayl top yoki o'zing Excel'da yarating:

--Masalan:

--Employees
--Products
--Students
--Orders

--Uni SSMS Import Wizard yordamida SQL Server'ga import qiling.

create database ImportFileDB;
go 
use ImportFileDB;

select *from employees;
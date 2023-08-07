create table staff
(id int primary key auto_increment,
firstname varchar(30),
lastname varchar(40),
post varchar(30),
seniority int,
salary int,
age int);

INSERT INTO staff 
VALUES
	(1, 'Вася', 'Петров', 'Начальник', 40, 100000, 60),
	(2, 'Петр', 'Власов', 'Начальник', 8, 70000, 30),
	(3, 'Катя', 'Катина', 'Инженер', 2, 70000, 25),
	(4, 'Саша', 'Сасин', 'Инженер', 12, 50000, 35),
	(5, 'Иван', 'Иванов', 'Рабочий', 40, 30000, 59),
	(6, 'Петр', 'Петров', 'Рабочий', 20, 25000, 40),
	(7, 'Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
	(8, 'Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
	(9, 'Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
	(10, 'Максим', 'Максимов', 'Рабочий', 2, 11000, 22),
	(11, 'Юрий', 'Галкин', 'Рабочий', 3, 12000, 24),
	(12, 'Людмила', 'Маркина', 'Уборщик', 10, 10000, 49)
;

-- 1.Отсортируйте данные по полю заработная плата (salary) в порядке: 
-- убывания
select *
from staff
order by salary desc;
-- возрастания
select *
from staff
order by salary;

-- 2. Выведите 5 максимальных заработных плат (saraly)
select salary
from staff
order by salary desc
limit 5;

-- 3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
select post, sum(salary) as total_salary
from staff
group by post;

-- 4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
select post, count(post) as 'Количество'
from staff
where age >= 24 and age <= 49 and post = 'Рабочий'
group by post;

-- 5. Найдите количество специальностей
select count(distinct post)  as 'Количество специальностей'
from staff;

-- 6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
select post, avg(age) as 'total_avg'
from staff
group by post
having total_avg < 30;

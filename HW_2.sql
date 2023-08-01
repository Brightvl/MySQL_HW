-- 0. Создаем базу hw_2
create database hw_2;
use hw_2;

-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
create table sales
(
	id int primary key auto_increment,
	order_date date,
	count_product int
);

insert into sales (order_date, count_product)
values 
	('2022-01-01', 156),
	('2022-01-02', 280),
	('2022-01-03', 21),
	('2022-01-04', 124),
	('2022-01-05', 341);

-- 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
select id, order_date,count_product,
	case 
		when count_product < 100 then "Маленький заказ"
		when count_product >= 100 and count_product <= 300 then 'Средний заказ'
        when count_product > 300 then 'Большой заказ'
    end as "Тип заказа"
from sales;

-- 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE
create table orders 
(
	id int primary key auto_increment,
    employee_id varchar(10),
    amount float,
    order_status varchar(25)
);
insert into orders (employee_id, amount, order_status)
values 
	('e03', 15.00, 'open'),
	('e01', 25.50, 'open'),
	('e05', 100.70, 'closed'),
	('e02', 22.18, 'open'),
	('e04', 9.50, 'cancelled');

select id,employee_id,amount, 
concat
	(
	if (order_status = 'open','Order is in open state', ''),
	if (order_status = 'closed','Order is closed', ''),
	if (order_status = 'cancelled','Order is cancelled', '')
	)
    as 'full_order_status'
from orders;

-- 4. Чем NULL отличается от 0?
NULL: Это особое значение, которое указывает на отсутствие или неизвестное значение. 
Когда ячейка в таблице имеет значение NULL, это означает, что для этой ячейки нет данных, и значение не было установлено или неизвестно.
0: Это конкретное числовое значение, представляющее ноль. 
Оно отличается от NULL тем, что 0 - это действительное числовое значение, в то время как NULL означает отсутствие значения.

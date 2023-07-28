# Общий вывод:
select * from mobile_phones;
#__________________________________________________________________
# 1. Таблица создана;
# 2. Выведите название, производителя и цену для товаров, количество которых превышает 2:
select product_name, manufacturer, price from mobile_phones where product_count > 2;
# 3. Выведите весь ассортимент товаров марки “Samsung”:
select * from mobile_phones where manufacturer = "Samsung";
#__________________________________________________________________
# *4. C помощью регулярных выражений найти:
# *4.1. Товары, в которых есть упоминание "iphone"
select * from mobile_phones where product_name like "%iphone%";
# *4.2. Товары в которых есть упоминание "Samsung"
select * from mobile_phones where manufacturer like "%Samsung%";
# *4.3. Товары, в которых есть цифры
select * from mobile_phones where product_name regexp "[0-9]";
# *4.4. Товары, в которых есть цифра "8"
select * from mobile_phones where product_name like "%8%";
#__________________________________________________________________

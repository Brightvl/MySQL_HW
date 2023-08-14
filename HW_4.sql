/*
  1.Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
*/
SELECT COUNT(*) AS total_likes
FROM likes
-- Объединяем таблицы для получения информации о пользователях и их профилях
JOIN media ON likes.media_id = media.id
JOIN users ON media.user_id = users.id
JOIN profiles ON users.id = profiles.user_id
-- Ограничиваем возраст пользователей младше 12 лет
WHERE DATEDIFF(CURDATE(), profiles.birthday) < 4380; -- 4380 = 12 лет в днях

/*
  2. Определить кто больше поставил лайков (всего): мужчины или женщины.
*/
-- Выбираем пол и общее количество лайков, сгруппированные по полу
SELECT
    CASE
        WHEN profiles.gender = 'm' THEN 'Мужчины'
        WHEN profiles.gender = 'f' THEN 'Женщины'
        ELSE 'Не указан'
    END AS gender,
    COUNT(*) AS total_likes
FROM likes
-- Объединяем таблицы для получения информации о пользователях и их профилях
JOIN media ON likes.media_id = media.id
JOIN users ON media.user_id = users.id
JOIN profiles ON users.id = profiles.user_id
-- Группируем результаты по полу и сортируем по убыванию количества лайков
GROUP BY gender
ORDER BY total_likes DESC;

/*
  3. Вывести всех пользователей, которые не отправляли сообщения.
*/
-- Выбираем id, имя и фамилию пользователей, которые не отправляли сообщения
SELECT users.id, users.firstname, users.lastname
FROM users
-- Используем LEFT JOIN для объединения таблиц users и messages по отправителю
LEFT JOIN messages ON users.id = messages.from_user_id
-- Отбираем только те записи, где messages.id IS NULL (т.е. нет соответствующей записи в messages)
WHERE messages.id IS NULL;

/*
  4. Пусть задан некоторый пользователь. Из всех друзей 
  этого пользователя найдите человека, который больше всех написал ему сообщений
  Выбираем id, имя и фамилию друга, который написал наибольшее количество сообщений пользователю с id = 1
*/
SELECT
    users.id,
    users.firstname,
    users.lastname,
    COUNT(messages.id) AS total_messages
FROM users
-- Объединяем таблицы для получения информации о друзьях и сообщениях
JOIN friend_requests ON users.id = friend_requests.target_user_id AND friend_requests.`status` = 'approved'
JOIN users AS friend ON friend.id = friend_requests.initiator_user_id
LEFT JOIN messages ON friend.id = messages.from_user_id AND messages.to_user_id = 1
-- Отбираем только друзей, которые не являются пользователем с id = 1
WHERE users.id != 1
-- Группируем результаты по другу и сортируем по убыванию количества написанных сообщений
GROUP BY users.id, users.firstname, users.lastname
ORDER BY total_messages DESC
-- Ограничиваем результат одной записью, то есть самым активным другом
LIMIT 1;

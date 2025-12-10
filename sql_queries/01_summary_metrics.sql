-- 1) Total users by subscription plan
SELECT
	subscription_plan,
    COUNT(user_id) AS total_users_per_plan
FROM users
GROUP BY subscription_plan
ORDER BY COUNT(user_id) DESC;

-- 2) Total watch time per country
SELECT
	u.country,
    SUM(w.watch_minutes) AS total_watch_time_per_country
FROM users AS u
LEFT JOIN watch_history AS w ON u.user_id = w.user_id
GROUP BY u.country
ORDER BY SUM(w.watch_minutes) DESC;

-- 3) Most watched genre overall
SELECT
	s.genre,
    COUNT(w.watch_id) AS most_watched_genre
FROM shows AS s
LEFT JOIN watch_history AS w ON s.show_id = w.show_id
GROUP BY s.genre
ORDER BY COUNT(w.watch_id) DESC
LIMIT 1;

-- 4) Top 3 most watched shows based on total minutes
SELECT
	s.title,
    SUM(w.watch_minutes) AS most_watched_shows
FROM shows AS s
LEFT JOIN watch_history AS w ON s.show_id = w.show_id
GROUP BY s.title
ORDER BY SUM(w.watch_minutes) DESC
LIMIT 3;

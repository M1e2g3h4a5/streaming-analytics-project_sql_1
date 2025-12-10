-- 1) Rank top 3 users based on total watch time 
SELECT
	u.user_id,
    u.user_name,
    SUM(w.watch_minutes) AS top_3_users
FROM users AS u
LEFT JOIN watch_history AS w ON u.user_id = w.user_id
GROUP BY u.user_id, u.user_name
ORDER BY SUM(w.watch_minutes) DESC
LIMIT 3;

-- 2) Show cumulative watch time for each user over time
SELECT
	user_id,
    watch_minutes,
    SUM(watch_minutes) OVER(PARTITION BY user_id ORDER BY watch_date) AS cumulative_watch_time
FROM watch_history;

-- 3) Compare each watch session to user’s average using CASE → (Above/Below/Same)
SELECT *,
	CASE
		WHEN watch_session > avg_watch_session THEN 'Above'
        WHEN watch_session < avg_watch_session THEN 'Below'
        WHEN watch_session = avg_watch_session THEN 'Same'
	END label
FROM(SELECT
	u.user_name,
    w.watch_minutes AS watch_session,
    ROUND(AVG(w.watch_minutes) OVER(PARTITION BY u.user_name),2) AS avg_watch_session
FROM users AS u
LEFT JOIN watch_history AS w ON u.user_id = w.user_id)t
WHERE watch_session IS NOT NULL;

-- 4) Use NTILE(4) to segment users into behavioral quartiles based on total watch time
SELECT *,
	NTILE(4) OVER(ORDER BY total_watch_time DESC) AS quartile
FROM(SELECT
	user_id,
    SUM(watch_minutes) AS total_watch_time
FROM watch_history
GROUP BY user_id)t;

-- 5) Identify users who increased or decreased watching pattern using LAG()
SELECT *,
	CASE 
		WHEN previous_watching_session IS NULL THEN 'First watch'
		WHEN current_watching_session > previous_watching_session THEN 'Increased' 
        WHEN current_watching_session < previous_watching_session THEN 'Decreased'
        ELSE 'Same'
	END watching_pattern
FROM (SELECT
	u.user_name,
    w.watch_minutes AS current_watching_session,
    LAG(w.watch_minutes) OVER(PARTITION BY u.user_name ORDER BY w.watch_date) AS previous_watching_session
FROM users AS u
LEFT JOIN watch_history AS w ON u.user_id = w.user_id)t;

-- 6) Identify binge-watching behavior: sessions > 150 minutes
SELECT
	u.user_name,
    w.watch_minutes,
    CASE
		WHEN w.watch_minutes > 150 THEN 'Binge_watching'
        ELSE 'Normal'
	END behavior
FROM users AS u
LEFT JOIN watch_history AS w ON u.user_id = w.user_id;

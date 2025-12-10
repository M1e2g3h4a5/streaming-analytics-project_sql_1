-- 1) Using DATEDIFF + LAG, find users who had a gap of > 10 days between sessions → label them "Churn Risk"
SELECT *,
	CASE 
		WHEN days > 10 THEN 'Churn Risk'
        ELSE 'No Churn Risk'
	END label
FROM(SELECT *,
	COALESCE(DATEDIFF(current_watch_session, previous_watch_session),0) AS days
FROM(SELECT
	u.user_name,
    w.watch_date AS current_watch_session,
    LAG(w.watch_date) OVER(PARTITION BY u.user_name ORDER BY w.watch_date) AS previous_watch_session
FROM users AS u
LEFT JOIN watch_history AS w ON u.user_id = w.user_id)t)y;

-- 2) Find the first and latest watch entry for every user
SELECT
	u.user_name,
    w.watch_date,
    FIRST_VALUE(w.watch_date) OVER(PARTITION BY u.user_name ORDER BY w.watch_date ASC) AS first_entry,
    LAST_VALUE(w.watch_date) OVER(PARTITION BY u.user_name ORDER BY w.watch_date ASC
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS latest_entry
FROM users AS u
LEFT JOIN watch_history AS w ON u.user_id = w.user_id;

-- 3) Use PERCENT_RANK() to find users in top 15% of platform usage
SELECT *
FROM(SELECT
	user_id,
    SUM(watch_minutes) AS total_watch_time,
    PERCENT_RANK() OVER(ORDER BY SUM(watch_minutes)) AS percentile
FROM watch_history
GROUP BY user_id)t
WHERE percentile >= 0.85;

-- 4) For each genre, return top 2 users by watch time
SELECT *
FROM(SELECT
	s.genre,
    u.user_name,
    SUM(w.watch_minutes) AS total_minutes,
    ROW_NUMBER() OVER(PARTITION BY s.genre ORDER BY SUM(w.watch_minutes) DESC) AS top_user
FROM users AS u
LEFT JOIN watch_history AS w ON u.user_id = w.user_id
LEFT JOIN shows AS s ON w.show_id = s.show_id
GROUP BY s.genre, u.user_name)t
WHERE top_user <= 2;

-- 5) Create a classification column:
-- | Condition                  | Label       |
-- | -------------------------- | ----------- |
-- | total watch time > 500 min | Power User  |
-- | 200–500 min                | Active User |
-- | < 200 min                  | Light User  |
SELECT *,
	CASE
		WHEN total_watch_time > 500 THEN 'Power User'
        WHEN total_watch_time BETWEEN 200 AND 500 THEN 'Active User'
        WHEN total_watch_time < 200 THEN 'Light User'
	END label
FROM(SELECT
	u.user_name,
    SUM(w.watch_minutes) AS total_watch_time
FROM users AS u
LEFT JOIN watch_history AS w ON u.user_id = w.user_id
GROUP BY u.user_name)t;

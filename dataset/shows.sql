CREATE TABLE shows(
	show_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    release_year INT
);

INSERT INTO shows
VALUES
(101,'Money Heist','Thriller',2017),
(102,'Stranger Things','SciFi',2016),
(103,'Demon Slayer','Anime',2020),
(104,'The Crown','Drama',2016),
(105,'One Piece','Anime',2023),
(106,'Sacred Games','Thriller',2018);

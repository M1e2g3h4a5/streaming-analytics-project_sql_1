CREATE TABLE watch_history(
	watch_id INT PRIMARY KEY,
    user_id INT,
    show_id INT,
    watch_date DATE,
    watch_minutes INT,
    device VARCHAR(30),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

INSERT INTO watch_history
VALUES
(5001,1,101,'2024-03-01',120,'Mobile'),
(5002,1,103,'2024-03-05',90,'Laptop'),
(5003,2,102,'2024-03-02',150,'TV'),
(5004,3,105,'2024-03-06',40,'Mobile'),
(5005,3,103,'2024-03-10',55,'Tablet'),
(5006,4,101,'2024-03-01',200,'TV'),
(5007,4,102,'2024-03-04',180,'TV'),
(5008,5,106,'2024-03-08',100,'Mobile'),
(5009,6,101,'2024-03-05',220,'Laptop'),
(5010,6,105,'2024-03-09',180,'TV');

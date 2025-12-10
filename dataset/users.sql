CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE,
    subscription_plan VARCHAR(20)
);

INSERT INTO users VALUES
(1,'Aarav','India','2024-01-12','Premium'),
(2,'Mia','UK','2024-02-18','Standard'),
(3,'Rohan','India','2024-01-30','Basic'),
(4,'Sophia','USA','2024-03-01','Premium'),
(5,'Kabir','India','2024-02-05','Standard'),
(6,'Olivia','Canada','2024-03-10','Premium');

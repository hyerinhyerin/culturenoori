CREATE SCHEMA `curlturenooridb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;

CREATE TABLE user (
    nick varchar(20) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    pw VARCHAR(255) NOT NULL
);


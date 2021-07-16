CREATE DATABASE Gohome;
USE Gohome;

CREATE TABLE Account(
    id varchar(100) primary key,
    pw varchar(100) Not null
);

CREATE TABLE User_info(
    id varchar(50) not null,
    username varchar(10) Not null,
    useremail varchar(50) Not null,
    userphone varchar(10) Not null,
    foreign key (id) references Account(id)
);

DESC Account;
DESC User_info;

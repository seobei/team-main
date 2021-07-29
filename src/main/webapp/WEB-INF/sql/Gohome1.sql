-- Gohome 데이터베이스 만들기 
CREATE DATABASE Gohome;

use Gohome;

-- 사용자정보 테이블 만들기
CREATE table GH_User(
    userid VARCHAR(50) PRIMARY KEY,
    userpw VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    userphone VARCHAR(15) NOT NULL,
    userem VARCHAR(15) NOT NULL,
    useradd VARCHAR(50) ,
    regdate TIMESTAMP DEFAULT NOW(),
    updateDate TIMESTAMP DEFAULT NOW(),
    enabled TINYINT(1) DEFAULT 1

);
-- 컬럼 타입(값) 수정 
-- alter table [테이블명] add [컬럼명] [타입] [옵션]; 
ALTER TABLE GH_User ADD CompanyRegistrationNumber VARCHAR(15);
-- ALTER TABLE GH_User ADD CompanyRegistrationNumber VARCHAR(15) NUll; 

-- 컬럼명 변경 및 타입 변경
-- alter table [테이블명] change [컬럼명] [변경할컬럼명] varchar(값);
ALTER TABLE GH_User CHANGE userphone userPhone VARCHAR(15);
ALTER TABLE GH_User CHANGE userem userEmail VARCHAR(254);


-- 컬럼 타입(값) 수정 
ALTER TABLE GH_User 
MODIFY COLUMN userem VARCHAR(254) NOT NULL;
DESC GH_User;

SELECT * FROM GH_User;

INSERT INTO GH_User(userid, userpw, username,userphone, userem)
VALUES ('soo123','qweasd','soo','01022223333','qwe@naver.com');


-- 권한 테이블 만들기 
CREATE TABLE GH_auth(
    id INT PRIMARY KEY AUTO_INCREMENT,
    userid VARCHAR(50) NOT NULL,
    auth VARCHAR(50) NOT NULL,
    FOREIGN KEY (userid) REFERENCES GH_User(userid)
);

SELECT * FROM GH_auth;

DELETE FROM GH_auth WHERE userid='cozy';
DELETE FROM GH_User WHERE userid='cozy';
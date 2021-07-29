SELECT * FROM GH_User;
SELECT * FROM GH_auth;

-- 사용자정보 테이블 만들기
CREATE TABLE market(
    mno INT PRIMARY KEY AUTO_INCREMENT, -- 상품번호 
    mwriter VARCHAR(50) NOT NULL, -- 작성자
    mtitle VARCHAR(255) NOT NULL, -- 상품제목
    mprice INT NOT NULL, -- 상품가격
    mdetail VARCHAR(2000) NOT NULL, -- 상세설명
    mregdate TIMESTAMP DEFAULT NOW(), -- 상품 등록일
    maddress VARCHAR(50), -- 주소        
    FOREIGN KEY (mwriter) REFERENCES GH_User(userid)
);

CREATE TABLE wishlist(
	wno INT PRIMARY KEY AUTO_INCREMENT,
	mwriter VARCHAR(50) NOT NULL,
    mno INT NOT NULL,
    FOREIGN KEY (mwriter) REFERENCES GH_User(userid),
    FOREIGN KEY (mno) REFERENCES market(mno)
);


SELECT * FROM market;

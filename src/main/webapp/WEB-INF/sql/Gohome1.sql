-- 사용자정보 테이블 만들기
CREATE table GH_User(
    userid VARCHAR(50) PRIMARY KEY,
    userpw VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    userPhone VARCHAR(15) NOT NULL,
    userEmail VARCHAR(254) NOT NULL,
    useradd VARCHAR(50) ,
    CompanyRegistrationNumber VARCHAR(15) NULL, 
    regdate TIMESTAMP DEFAULT NOW(),
    updateDate TIMESTAMP DEFAULT NOW(),
    enabled TINYINT(1) DEFAULT 1
);

-- 권한 테이블 만들기
CREATE TABLE GH_auth(
	id INT PRIMARY KEY AUTO_INCREMENT,
    userid VARCHAR(50) NOT NULL,
    auth VARCHAR(50) NOT NULL,
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);

SELECT * FROM GH_auth;
delete from GH_auth where auth ="ROLE_ADMIN";

SELECT * FROM notice_file;


update GH_auth
set auth = 'ROLE_ADMIN'
where userid = '1234';

-- 관리자 권한 부여
INSERT INTO GH_auth(userid, auth)
VALUES ('1234', 'ROLE_ADMIN');

SELECT * FROM cs_notice;
DROP TABLE cs_notice;

-- cs의 공지사항 테이블 생성
-- notice의 n사용
CREATE TABLE notice(
	nno INT PRIMARY KEY AUTO_INCREMENT,
    ntitle VARCHAR(50) NOT NULL,
    userid  VARCHAR(50) NOT NULL,
    ndetail VARCHAR(900) NOT NULL,
    nregdate  TIMESTAMP DEFAULT NOW() NOT NULL,
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);
SELECT * FROM notice;

-- cs의 공지사항 파일테이블 생성
CREATE TABLE notice_file(
	nfno INT PRIMARY KEY AUTO_INCREMENT,
    nno INT NOT NULL,
    fileName VARCHAR(50) NOT NULL,
    
    FOREIGN KEY (nno) REFERENCES notice (nno) ON DELETE CASCADE
);
ALTER TABLE notice_file
DROP COLUMN nregdate;
SELECT * FROM notice_file;

SELECT
			n.nno nno,
			n.ntitle ntitle,
			n.userid userid,
			n.ndetail ndetail,
			n.nregdate nregdate,
			nf.fileName fileName
		FROM
			notice n 
		LEFT JOIN
			notice_file nf
		ON
			n.nno = nf.nno
		WHERE n.nno = 2
        ;
      
DROP TABLE notice_file;

ALTER TABLE notice_file
CHANGE COLUMN notice_fileName fileName VARCHAR(50) NOT NULL;

RENAME TABLE GH_help_notice TO cs_notice,
             GH_help_oneToOne_question TO cs_oneToOne_question,
             GH_help_oneToOne_answer TO cs_oneToOne_answer;

-- cs의 1:1 이용자 질문 테이블 생성
-- one to one의 o사용
CREATE TABLE oto(
	qono INT PRIMARY KEY AUTO_INCREMENT,
    otitle VARCHAR(50) NOT NULL,
    userid  VARCHAR(50),
    odetail VARCHAR(900) NOT NULL,
    oregdate  TIMESTAMP DEFAULT NOW() NOT NULL,
    
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);

SELECT * FROM oto;
delete from oto
where qono = '4';
insert into oto
(otitle, userid, odetail)
VALUES
('ds2222a', 'dsadsa', 'dsadsa');

drop TABLE GH_help_notice;

-- cs의 1:1 관리자 답변 테이블 생성
CREATE TABLE otoanswer(
	aono INT PRIMARY KEY AUTO_INCREMENT,
	qono INT NOT NULL,
    userid  VARCHAR(50),
    regdate  TIMESTAMP DEFAULT NOW() NOT NULL,
    
    FOREIGN KEY (qono) REFERENCES oto(qono) ON DELETE CASCADE,
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);

DROP TABLE otoanswer;

-- cs의 1:1 관리자 답변 테이블 생성
 CREATE TABLE otoanswer(
   aono INT PRIMARY KEY AUTO_INCREMENT,
   qono INT NOT NULL,
   content VARCHAR(900) Not null,
	userid  VARCHAR(50),
	regdate  TIMESTAMP DEFAULT NOW() NOT NULL,
    
    FOREIGN KEY (qono) REFERENCES oto(qono) ON DELETE CASCADE,
    FOREIGN KEY (userid) REFERENCES GH_User(userid) ON DELETE CASCADE
);

-- 1:1 게시판 파일테이블
CREATE TABLE otofile (
	id INT PRIMARY KEY AUTO_INCREMENT,
	qono INT,
	fileName VARCHAR(200),
    
	FOREIGN KEY (qono) REFERENCES oto(qono) ON DELETE CASCADE
);

SELECT * FROM GH_User;

SELECT * FROM market_file;

SELECT * FROM market;

SELECT * FROM oto;
SELECT * FROM otoanswer;
DELETE from oto where qono='2';
insert into otoanswer
(qono, content, userid)
VALUES
('9', '답변한다 절대안됨.', 'dsadsa');

-- 쪽지함 테이블
CREATE TABLE GH_Message (
	mno INT PRIMARY KEY AUTO_INCREMENT,
    writer varchar(50) ,
    reader varchar(50) ,
    content varchar(256) ,
	regdate TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (writer) REFERENCES GH_User(userid)
);

-- 사용자정보 테이블 만들기
CREATE TABLE market(
    mno INT PRIMARY KEY AUTO_INCREMENT, -- 상품번호 
    mwriter VARCHAR(50) NOT NULL, -- 작성자
    mtitle VARCHAR(255) NOT NULL, -- 상품제목
    mprice INT NOT NULL, -- 상품가격
    mdetail VARCHAR(2000) NOT NULL, -- 상세설명
    mstate VARCHAR(50) NOT NULL, -- 상품 상태 
    msold VARCHAR(10) NOT NULL, -- 판매 분류
    mregdate TIMESTAMP DEFAULT NOW(), -- 상품 등록일
    maddress VARCHAR(50), -- 주소        
    FOREIGN KEY (mwriter) REFERENCES GH_User(userid) ON DELETE CASCADE
);

-- 이미지파일 업로드
CREATE TABLE market_file( 
	id INT PRIMARY KEY AUTO_INCREMENT, -- 파일 아이디 식별자
	mno INT NOT NULL, -- 상품번호 (글번호)
	fileName VARCHAR(256), -- 파일이름
	FOREIGN KEY (mno) REFERENCES market(mno) ON DELETE CASCADE-- 상품번호
);

-- 커뮤니티 게시판
CREATE table C_board(
	bno INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(255) NOT NULL,
	content VARCHAR(2000) NOT NULL,
	writer VARCHAR(50) NOT NULL,
	regdate TIMESTAMP DEFAULT NOW(),
	updatedate TIMESTAMP DEFAULT NOW(),
	cbcategory varchar(15),
    foreign KEY (writer) REFERENCES GH_User(userid) ON DELETE CASCADE
);

-- 커뮤니티 게시판 파일테이블
CREATE TABLE C_board_file (
	id INT PRIMARY KEY AUTO_INCREMENT,
	bno INT REFERENCES C_board(bno),
	fileName VARCHAR(200) not null,
	FOREIGN KEY (bno) REFERENCES C_board(bno) ON DELETE CASCADE
);

-- 자유게시판 댓글 테이블 
CREATE TABLE cb_reply (
	rno INT PRIMARY KEY AUTO_INCREMENT,
    bno INT NOT NULL,
    reply VARCHAR(512) NOT NULL,
    replyer VARCHAR(50) NOT NULL,
    replyDate TIMESTAMP DEFAULT now(),
    updateDate TIMESTAMP DEFAULT now(),
    FOREIGN KEY (bno) REFERENCES C_board(bno)
);
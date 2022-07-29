--완성!

DROP TABLE t_member CASCADE CONSTRAINTS;

CREATE TABLE t_member(
    ID VARCHAR2(20 BYTE), 
	PWD VARCHAR2(10 BYTE), 
	NAME VARCHAR2(50 BYTE), 
	EMAIL VARCHAR2(50 BYTE), 
	JOINDATE DATE DEFAULT SYSDATE, 
	 PRIMARY KEY ("ID")
);

insert into t_member values('moon','1234','문희인','moon@naver.com', sysdate);
insert into t_member values('park','1234','박씨','park@naver.com', sysdate);
insert into t_member values('hong','1234','홍씨','hong@naver.com', sysdate);
insert into t_member values('lee','1234','이씨','lee@naver.com', sysdate);
insert into t_member values('kim','1234','김씨','kim@naver.com', sysdate);
insert into t_member values('han','1234','한씨','han@naver.com', sysdate);
commit;
SELECT
    *
FROM t_member;

DROP TABLE t_board CASCADE CONSTRAINTS;

--게시판 테이블을 생성합니다.
CREATE TABLE t_board(
    articleNO number(10) primary key,
    parentNO number(10) DEFAULT 0,
    title VARCHAR2(500) NOT NULL,
    content VARCHAR2(4000),
    imageFileName VARCHAR2(30),
    writedate DATE DEFAULT SYSDATE NOT NULL,
    id VARCHAR2(10),
    CONSTRAINT fk_id FOREIGN KEY(id) 
    REFERENCES t_member(id)
);

-- 테이블에 테스트 글을 추가
INSERT INTO t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
VALUES(1, 0, '테스트글입니다.', '테스트글입니다.', NULL, SYSDATE, 'moon');

INSERT INTO t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
VALUES(2, 0, '테스트글입니다.', '상품후기입니다.', NULL, SYSDATE, 'hong');

INSERT INTO t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
VALUES(3, 2, '안녕하세요.', '상품 후기에 대한 답변입니다.', NULL, SYSDATE, 'hong');

INSERT INTO t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
VALUES(5, 3, '답변입닌다.', '상품 좋습니다.', NULL, SYSDATE, 'lee');

INSERT INTO t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
VALUES(4, 0, '김유신입니다.', '김유신 테스트글입니다.', NULL, SYSDATE, 'kim');

INSERT INTO t_board(articleNO, parentNO, title, content, imageFileName, writedate, id)
VALUES(6, 2, '상품 후기입니다..', '이순씬씨의 상품 사용 후기를 올립니다.', NULL, SYSDATE, 'lee');

COMMIT;

SELECT * FROM t_board;


SELECT LEVEL,
       articleNO,
       parentNO,
       LPAD(' ', 4*(LEVEL-1)) || title title,
       content,
       writeDate,
       id
       FROM t_board
       START WITH parentNO=0
       CONNECT BY PRIOR articleNO=parentNO
       ORDER SIBLINGS BY articleNO DESC;
       




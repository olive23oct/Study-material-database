--INSERT, UPDATE, DELETE
/* **************************** 
-- INSERT 문
INSERT INTO 테이블명
       (컬럼명1, 컬럼명2, ..., 컬럼명n)
VALUES (값1, 값2, ... , 값n);  
*********************************/
SELECT * FROM BOOK;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (30, '자바란 무엇인가', 'ITBOOK', 30000);       
COMMIT;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (31, '자바란 무엇인가2', 'ITBOOK', 30000);
COMMIT;
-----------
--컬럼명을 나열하지 않는 경우
----테이블 생성시 작성된 컬럼의 값을 모두 작성(누락시 문법적 오류 발생)
----테이블 생성시 만든 컬럼의 순서에 따라 데이타 입력(지키지 않으면 논리적 오류)
------------
INSERT INTO BOOK
VALUES (32, '자바란 무엇인가3', 'ITBOOK', 30000);

INSERT INTO BOOK
VALUES (33, '자바란 무엇인가4', '', 30000);
SELECT * FROM BOOK;

INSERT INTO BOOK
VALUES (34, 'ITBOOK', '자바란 무엇인가4', 30000);
------------
SELECT * FROM BOOK ORDER BY BOOKID DESC;
--명시적으로 컬럼명을 사용하면, 컬럼명의 위치에 따라 값이 매칭되어 입력됨
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER)
VALUES (35, '자바란 무엇인가5', 'ITBOOK'); 
--
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PRICE, PUBLISHER)
VALUES (36, '자바란 무엇인가6', 35000, 'ITBOOK');
--------------------------
--일괄입력 : 테이블의 데이타를 이용해서 여러 데이타를 한번에 입력처리
----IMPORTED_BOOK -> BOOK : 일괄입력
INSERT INTO BOOK
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
  FROM IMPORTED_BOOK
;
SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT * FROM IMPORTED_BOOK;
--==================================
/* *********************************
--UPDATE문
UPDATE 테이블명
   SET 컬럼명1 = 값1, 컬럼명2 = 값2, ..., 컬럼명n = 값n
 [WHERE 대상조건 ]
*********************************/
SELECT * FROM CUSTOMER;
--박세리의 주소 : '대한민국 대전' -> '대한민국 부산'
UPDATE CUSTOMER
   SET ADDRESS = '대한민국 부산'
 WHERE NAME = '박세리'
;
--박세리의 주소, 전화번호 수정 : '대한민국 대전', '010-1111-2222'
UPDATE CUSTOMER
   SET ADDRESS = '대한민국 대전',
       PHONE = '010-1111-2222'
 WHERE NAME = '박세리'
;
COMMIT;
SELECT * FROM CUSTOMER WHERE NAME = '박세리';
------------------
--박세리의 주소 수정 : 김연아의 주소와 동일하게 변경
SELECT ADDRESS FROM CUSTOMER WHERE NAME = '김연아';
--
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER WHERE NAME = '김연아')
 WHERE NAME = '박세리'
;
SELECT * FROM CUSTOMER WHERE NAME = '박세리';
SELECT ADDRESS FROM CUSTOMER WHERE NAME = '김연아';
------------------
--박세리의 주소, 전화번호 수정 : 추신수 정보와 동일하게
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER WHERE NAME = '추신수'),
       PHONE = (SELECT PHONE FROM CUSTOMER WHERE NAME = '추신수')
 WHERE NAME = '박세리'
; 
--====================
/* ************************
-- DELETE 문
DELETE FROM 테이블명
 WHERE 대상조건;
***************************/
SELECT * FROM BOOK;
SELECT * FROM TEST_LIKE;
--DELETE FROM TEST_LIKE WHERE NAME = '홍길동';
SELECT * FROM TEST_LIKE WHERE NAME LIKE '홍길동%';
/*
DELETE FROM TEST_LIKE 
WHERE NAME LIKE '홍길동%';
*/
SELECT * FROM TEST_LIKE;
COMMIT;
-----------------
SELECT * FROM BOOK
--DELETE FROM BOOK
 WHERE BOOKNAME LIKE '자바%' OR BOOKNAME = 'ITBOOK';

SELECT * FROM BOOK
--DELETE FROM BOOK
WHERE BOOKID >= 30;





/* ************************
뷰(VIEW) : 한나 또는 둘 이상의 테이블로 부터
   데이타의 부분집합을 테이블인 것처럼 사용하는 객체(가상테이블)
--뷰(VIEW) 생성문
CREATE VIEW 뷰이름 [(컬럼별칭1, 컬럼별칭2, ..., 컬럼별칭n)]
AS
SELECT 문장
[옵션];

--읽기전용 옵션 : WITH READ ONLY

--뷰(VIEW) 삭제
DROP VIEW 뷰이름;
***************************/
SELECT O.*, B.BOOKNAME, C.NAME
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
   AND C.NAME = '박지성'
;
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
SELECT * FROM ORDERS;
--============================
CREATE VIEW VW_BOOK
AS
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
----
SELECT * FROM VW_BOOK;
----------------------
SELECT *
  FROM VW_BOOK
 WHERE PUBLISHER = '굿스포츠';
-- 
SELECT *
  FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%')
 WHERE PUBLISHER = '굿스포츠';
--------------------------------------
--뷰(VIEW) 생성 - 컬럼별칭(alias) 사용
CREATE VIEW VW_BOOK2
(BID, BNAME, PUB, PRICE)
AS
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%축구%';
--------
CREATE VIEW VW_BOOK3
(BNAME, PUB, PRICE)
AS
SELECT BOOKNAME, PUBLISHER, PRICE
  FROM BOOK 
 WHERE BOOKNAME LIKE '%축구%';
----
SELECT * FROM VW_BOOK3;
--==========================
CREATE VIEW VW_ORDERS
AS
SELECT O.ORDERID, B.BOOKNAME, B.PUBLISHER, 
       C.NAME, C.PHONE,
       B.PRICE, O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
 ORDER BY O.ORDERID
;
--DROP VIEW VW_ORDERS; --뷰삭제
-------------
--뷰 활용
SELECT * FROM VW_ORDERS WHERE NAME = '박지성';
SELECT * FROM VW_ORDERS WHERE NAME IN ('김연아', '장미란')
 ORDER BY PUBLISHER;
SELECT * FROM VW_ORDERS WHERE SALEPRICE >= 20000; 
--===================================================
--(실습) 뷰를 생성, 조회, 삭제
--1. 뷰생성 - 뷰명칭 : VW_ORD_ALL
---- 주문(판매)정보, 책정보, 고객정보를 모두 조회할 수 있는 형태의 뷰
--2. 이상미디어에서 출판해서 판매된 책제목, 판매금액, 판매일 조회
--3. 이상미디어 출판사의 책 중에서 추신수, 장미란이 구매한 책 정보 조회
---- 출력항목 : 구입한 사람이름, 책제목, 출판사, 원가, 판매가, 판매일자
---- 정렬 : 구입한 사람이름, 구입일자 최근 순
--4. 판매된 책에 대하여 구매자별 건수, 합계금액, 평균금액, 최고가, 최저가 조회
--(최종) 뷰삭제 : VW_ORD_ALL 삭제 처리
-------------------
CREATE OR REPLACE VIEW VW_ORD_ALL
AS
SELECT O.*
     , B.BOOKNAME, B.PUBLISHER, B.PRICE
     , C.NAME, C.PHONE, C.ADDRESS
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
 ORDER BY O.ORDERID
;
--2. 이상미디어에서 출판해서 판매된 책제목, 판매금액, 판매일 조회
SELECT BOOKNAME, SALEPRICE, ORDERDATE
  FROM VW_ORD_ALL
 WHERE PUBLISHER = '이상미디어'
;  
SELECT BOOKNAME, SALEPRICE, ORDERDATE
  FROM (SELECT O.*
             , B.BOOKNAME, B.PUBLISHER, B.PRICE
             , C.NAME, C.PHONE, C.ADDRESS
          FROM ORDERS O, BOOK B, CUSTOMER C
         WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
         ORDER BY O.ORDERID)
 WHERE PUBLISHER = '이상미디어'
; 

--3. 이상미디어 출판사의 책 중에서 추신수, 장미란이 구매한 책 정보 조회
---- 출력항목 : 구입한 사람이름, 책제목, 출판사, 원가, 판매가, 판매일자
---- 정렬 : 구입한 사람이름, 구입일자 최근 순
SELECT NAME, BOOKNAME, PUBLISHER, PRICE, SALEPRICE, ORDERDATE
  FROM VW_ORD_ALL
 WHERE PUBLISHER = '이상미디어'
   AND NAME IN ('추신수', '장미란')
 ORDER BY NAME, ORDERDATE DESC
;
--4. 판매된 책에 대하여 구매자별 건수, 합계금액, 평균금액, 최고가, 최저가 조회
SELECT NAME, SUM(SALEPRICE), ROUND(AVG(SALEPRICE), -2)
     , MAX(SALEPRICE), MIN(SALEPRICE)
  FROM VW_ORD_ALL
 GROUP BY NAME
;
--(최종) 뷰삭제 : VW_ORD_ALL 삭제 처리
DROP VIEW VW_ORD_ALL;
--=========================
--뷰에 별칭 적용
----컬럼명 : ID -> MID, NAME -> MNAME
CREATE OR REPLACE VIEW T_LIKE 
    (MID, MNAME)
AS 
SELECT ID, NAME 
FROM TEST_LIKE;

SELECT * FROM T_LIKE;
--DELETE FROM TEST_LIKE WHERE ID = 6;

SELECT * 
  FROM (SELECT ID AS MID, NAME AS MNAME
        FROM TEST_LIKE)
;
----------------------------
CREATE OR REPLACE FORCE VIEW AAA
AS
SELECT ID, NAME, PHONE FROM AAA;
-----------------------
DELETE FROM T_LIKE WHERE MID = 8;
COMMIT;

DELETE FROM T_LIKE WHERE ID = 9;









--서브쿼리(부속질의, subquery)
--SQL문(SELECT, INSERT, UPDATE, DELETE) 내에 있는 쿼리문
--------------------------
--박지성이 구입한 내역을 검색
SELECT * FROM ORDERS;
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --CUSTID : 1
SELECT * FROM ORDERS
 WHERE CUSTID = 1;
--서브쿼리 사용
SELECT * FROM ORDERS
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');
--조인문으로 처리
SELECT C.NAME, O.*
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME = '박지성'
;
----
--WHERE 절에서 서브쿼리 사용시 조회되는 데이타가 2건 이상인 경우 IN 사용
SELECT * FROM ORDERS
 WHERE CUSTID IN (SELECT CUSTID 
                   FROM CUSTOMER 
                  WHERE NAME IN ('박지성', '김연아'));
--------------------
--정가가 가장 비싼 도서의 이름을 구하시오.
SELECT MAX(PRICE) FROM BOOK; --가장 비싼 도서의 가격 : 35000
SELECT * FROM BOOK
 WHERE PRICE = 35000;
--
SELECT * FROM BOOK
 WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);
-------------------
--서브쿼리를 FROM절에 사용하는 경우
SELECT *
  FROM BOOK B,
       (SELECT MAX(PRICE) MAX_PRICE FROM BOOK) M
 WHERE B.PRICE = M.MAX_PRICE;
---
SELECT *
  FROM (SELECT * FROM CUSTOMER WHERE NAME IN ('박지성', '김연아')) C,
       ORDERS O
 WHERE C.CUSTID = O.CUSTID
;
---
SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME IN ('박지성', '김연아')
;
----------------------------
--SELECT 절에 서브쿼리 사용예
SELECT O.ORDERID, O.CUSTID, O.BOOKID,
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME, --고객명
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME, --책제목,
       O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O
;
--------------------
--박지성이 구매한 책 목록(책제목)
--맨 안쪽SQL --> 중간SQL -> 맨 바깥쪽 SQL문 실행
SELECT BOOKID, BOOKNAME
  FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID
                    FROM ORDERS
                   WHERE CUSTID IN (SELECT CUSTID 
                                     FROM CUSTOMER 
                                    WHERE NAME = '박지성')
                 )
;                   
------------------------------
--실습(서브쿼리 이용)
--1. 한 번이라도 구매한 내역이 있는 사람(서브쿼리, 조인문)
---- (또는 한 번도 구매하지 않은 사람)
--2. 20000원 이상되는 책을 구입한 고객 명단 조회(서브쿼리, 조인문)
--3. '대한미디어' 출판사의 도서를 구매한 고객이름 조회(서브쿼리, 조인문)
--4. 전체 책가격 평균보다 비싼 책의 목록 조회(서브쿼리, 조인문)
--------------
--1. 한 번이라도 구매한 내역이 있는 사람(서브쿼리, 조인문)
SELECT CUSTID FROM ORDERS;
SELECT * FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS); --한 번이라도 구매한 사람
---- (또는 한 번도 구매하지 않은 사람)
SELECT * FROM CUSTOMER
 WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
--- JOIN문
SELECT DISTINCT C.* --DISTINCT 중복데이타는 하나만 표시
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
;
----JOIN문 (또는 한 번도 구매하지 않은 사람)
SELECT DISTINCT C.* --DISTINCT 중복데이타는 하나만 표시
--SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID(+)
   AND O.ORDERID IS NULL
;
------------------------
--2. 20000원 이상되는 책을 구입한 고객 명단 조회(서브쿼리, 조인문)
SELECT CUSTID FROM ORDERS WHERE SALEPRICE >= 20000; --2만원 이상 구매한 사람
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS 
                   WHERE SALEPRICE >= 20000)
;
-----
--JOIN문
SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND O.SALEPRICE >= 20000
;
SELECT *
  FROM CUSTOMER C, 
       (SELECT CUSTID FROM ORDERS WHERE SALEPRICE >= 20000) O
 WHERE C.CUSTID = O.CUSTID
;
--------------
--3. '대한미디어' 출판사의 도서를 구매한 고객이름 조회(서브쿼리, 조인문)
SELECT * 
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID
                    FROM ORDERS
                   WHERE BOOKID IN (SELECT BOOKID
                                      FROM BOOK
                                     WHERE PUBLISHER = '대한미디어')
                 )
;
---JOIN문
SELECT C.*
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND O.BOOKID = B.BOOKID
   AND B.PUBLISHER = '대한미디어'
;
SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND O.BOOKID = B.BOOKID
   AND B.PUBLISHER LIKE '%미디어'
;

SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
--------------
--4. 전체 책가격 평균보다 비싼 책의 목록 조회(서브쿼리, 조인문)
SELECT AVG(PRICE) FROM BOOK; --평균금액
SELECT * FROM BOOK
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK);

--JOIN문
SELECT *
  FROM BOOK B
     , (SELECT AVG(PRICE) AVG_PRICE FROM BOOK) AVG
 WHERE B.PRICE > AVG.AVG_PRICE
;










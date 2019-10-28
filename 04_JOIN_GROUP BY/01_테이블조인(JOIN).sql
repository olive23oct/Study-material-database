SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
------------------------
--박지성이 구입한 책의 금액합계
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --CUSTID : 1
SELECT * FROM ORDERS WHERE CUSTID = 1;
SELECT SUM(SALEPRICE) FROM ORDERS WHERE CUSTID = 1;
--서브쿼리(sub query)방식
SELECT SUM(SALEPRICE) FROM ORDERS 
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');
------------------------
--테이블 조인(join) 방식
SELECT * FROM CUSTOMER WHERE CUSTID = 1;
SELECT * FROM ORDERS WHERE CUSTID = 1;
SELECT *
  FROM CUSTOMER, ORDERS --조인할 테이블
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --조인시 사용 조건
;
--박지성이 구입한 목록
SELECT SUM(SALEPRICE)
--SELECT *
  FROM CUSTOMER, ORDERS --조인할 테이블
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --조인시 사용 조건
   AND NAME = '박지성'
;
--------------------
--조인된 데이타에서 컬럼 조회시 : 테이블명.컬럼명 형태로 사용
SELECT CUSTOMER.CUSTID, CUSTOMER.NAME, CUSTOMER.ADDRESS,
       ORDERS.CUSTID AS ORD_CUSTID, ORDERS.SALEPRICE
  FROM CUSTOMER, ORDERS --조인 대상 테이블
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --조인 조건
   AND CUSTOMER.NAME = '박지성' --검색조건(WHERE)
;
-----
--컬럼명이 특정 테이블에 유일하게 존재하면 테이블명 생략 가능
SELECT CUSTOMER.CUSTID, NAME, ADDRESS,
       ORDERS.CUSTID AS ORD_CUSTID, SALEPRICE
  FROM CUSTOMER, ORDERS --조인 대상 테이블
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --조인 조건
   AND NAME = '박지성' --검색조건(WHERE)
;
--============================
--테이블에 별칭(alias) 부여 사용 가능(별칭 사용시 테이블명 사용 못함)
SELECT C.CUSTID, C.NAME, C.ADDRESS, 
       O.SALEPRICE
  FROM CUSTOMER C, ORDERS O --테이블에 별칭 부여
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '박지성'
;
----------------------------------
SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
-----
SELECT O.ORDERID, O.BOOKID, B.BOOKNAME, B.PRICE, B.PUBLISHER,
       O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
   --AND BOOKNAME LIKE '%축구%'
   AND B.PUBLISHER LIKE '%미디어'
 ORDER BY B.PUBLISHER, O.SALEPRICE DESC
;
-- ===============================================
--(문제해결) 테이블 조인을 통해서 문제해결(안되면 단일 SELECT문으로 단계적으로)
--실습 : '야구를 부탁해'라는 책이 몇 권이 팔렸는지 확인해주세요.
--실습 : '야구를 부탁해'라는 책이 팔린 날짜를 구하세요(책제목, 판매일자)
------
--실습 : '추신수'가 구입한 책값과 구입일자 확인(책값, 구입(판매)일자)
--실습 : '추신수'가 구입한 합계금액 구하세요
--=====================================================
--실습 : '야구를 부탁해'라는 책이 몇 권이 팔렸는지 확인해주세요.
SELECT BOOKID FROM BOOK WHERE BOOKNAME = '야구를 부탁해'; --BOOKID : 8
SELECT COUNT(*) FROM ORDERS WHERE BOOKID = 8;

SELECT '야구를 부탁해 판매건수', COUNT(*)
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
   AND B.BOOKNAME = '야구를 부탁해'
;
SELECT COUNT(*) AS "BASEBALL COUNTS"
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
   AND B.BOOKNAME = '야구를 부탁해'
;

--실습 : '야구를 부탁해'라는 책이 팔린 날짜를 구하세요(책제목, 판매일자)
SELECT B.BOOKNAME, O.ORDERDATE
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
   AND B.BOOKNAME = '야구를 부탁해'
;
------------------
--실습 : '추신수'가 구입한 책값과 구입일자 확인(책값, 구입(판매)일자)
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '추신수'
;
--실습 : '추신수'가 구입한 합계금액 구하세요
SELECT '추신구 구입금액', SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '추신수'
;
--==========================================
SELECT *
  FROM BOOK B, ORDERS O --조인 테이블 작성
 WHERE B.BOOKID = O.BOOKID --조인 조건 작성
   AND B.BOOKNAME LIKE '축구%' --WHERE절의 검색조건
;
------------------
--3개 테이블 조인
SELECT O.ORDERID, C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O, CUSTOMER C --조인 테이블
 WHERE B.BOOKID = O.BOOKID --조인조건 B = O
   AND O.CUSTID = C.CUSTID --조인조건 O = C
 ORDER BY O.ORDERID
;
----
SELECT O.ORDERID, C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O, CUSTOMER C --조인 테이블
 WHERE O.BOOKID = B.BOOKID --조인조건 O = B
   AND O.CUSTID = C.CUSTID --조인조건 O = C
 ORDER BY O.ORDERID
;
-------------------------------
--3개테이블조인 : 고객명, 책제목, 판매가격, 판매일자, 출판사명
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
;
---------
--(실습)장미란이 구입한 책제목, 구입가격, 구입일자, 출판사
----장미란 : CUSTOMER
----구입(판매)한 : ORDERS
----책제목 : BOOK
----결과항목 : 책제목, 구입가격, 구입일자, 출판사
----검색조건 : 장미란
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C --조인테이블
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID --조인조건
   AND C.NAME = '장미란'
;
----------------
--(실습)장미란이 구입한 책 중에 2014-01-01 ~ 2014-07-08 까지 구입한 내역
SELECT *
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
   AND C.NAME = '장미란'
   AND O.ORDERDATE BETWEEN TO_DATE('2014-01-01', 'YYYY-MM-DD')
                       AND TO_DATE('2014-07-08', 'YYYY-MM-DD')
;
SELECT *
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
   AND C.NAME = '장미란'
   AND O.ORDERDATE >= TO_DATE('2014-01-01', 'YYYY-MM-DD')
   AND O.ORDERDATE < TO_DATE('2014-07-09', 'YYYY-MM-DD')
;
--==================================
--(실습)'야구를 부탁해'라는 책(BOOK)을 구입한(ORDERS) 사람(CUSTOMER)과
----  구입일자를 구하세요.
--(실습)'추신수', '장미란'이 구입한 책제목, 구입금액, 구입일자를 확인
----  (정렬 : 고객명, 구입일자 순으로)
-------------------------------------
SELECT B.BOOKNAME, C.NAME, O.ORDERDATE
--SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE B.BOOKID = O.BOOKID AND O.CUSTID = C.CUSTID
   AND B.BOOKNAME = '야구를 부탁해'
;

--(실습)'추신수', '장미란'이 구입한 책제목, 구입금액, 구입일자를 확인
----  (정렬 : 고객명, 구입일자 순으로)
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
--SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
   AND C.NAME IN ('추신수', '장미란')
 ORDER BY C.NAME, O.ORDERDATE   
;
-----
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
--SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
   AND (C.NAME = '추신수' OR C.NAME = '장미란')
 ORDER BY C.NAME, O.ORDERDATE   
;
---==============================
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE), 
       ROUND(AVG(O.SALEPRICE), 2),
       MAX(O.SALEPRICE), MIN(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
;






















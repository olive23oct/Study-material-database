/*** 그룹함수 : 하나 이상의 행을 그룹으로 묶어서 연산
COUNT(*): 데이타 갯수 조회(* : 전체컬럼 대상으로)
COUNT(컬럼명) : 데이타 갯수 조회(지정된 컬럼에 한하여)
SUM(컬럼) : 합계 값 구하기
AVG(컬럼) : 평균 값 구하기
MAX(컬럼) : 최대 값 구하기
MIN(컬럼) : 최소 값 구하기
**************************/
SELECT * FROM BOOK;
SELECT COUNT(*) FROM BOOK;

SELECT COUNT(*) FROM CUSTOMER; --데이타 5건 조회
SELECT COUNT(NAME) FROM CUSTOMER; --5건
SELECT COUNT(PHONE) FROM CUSTOMER; --4건 조회 : NULL값 갯수 제외됨
-------
--SUM(컬럼) : 컬럼의 합계를 구할 때
SELECT * FROM BOOK;
SELECT SUM(PRICE) FROM BOOK; --144500
SELECT SUM(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('대한미디어', '이상미디어');

--AVG(컬럼) : 컬럼의 평균 값 구할 때
SELECT AVG(PRICE) FROM BOOK; --14450
SELECT AVG(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('대한미디어', '이상미디어');

--MAX(컬럼) : 컬럼 값 중에 가장 큰 값 조회
--MIN(컬럼) : 컬럼 값 중에 가장 작은 값 조회
SELECT * FROM BOOK ORDER BY PRICE DESC;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK
 WHERE PUBLISHER = '굿스포츠'
;
SELECT COUNT(*), SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE)
  FROM BOOK;
---------------------------------
SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성'; --CUSTID : 1
SELECT * FROM ORDERS;
--(실습)
--1. 박지성의 총구매액(박지성의 고객번호(CUSTID = 1))
SELECT '박지성' AS NAME, SUM(SALEPRICE) SUMPRICE 
  FROM ORDERS WHERE CUSTID = 1;
SELECT '박지성' AS NAME, SUM(SALEPRICE) SUMPRICE 
  FROM ORDERS WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '박지성');  

--2. 박지성이 구매한 도서의 수
SELECT '박지성 구매건수', COUNT(*) FROM ORDERS
 WHERE CUSTID = 1;

--3. 성이 '김'씨인 고객의 이름과 주소
SELECT NAME, ADDRESS
  FROM CUSTOMER
 WHERE NAME LIKE '김%'
;
--4. 성이 '박'씨이고 이름이 '성'으로 끝나는 고객의 이름과 주소
SELECT NAME, ADDRESS
  FROM CUSTOMER
 WHERE NAME LIKE '박%성'
;





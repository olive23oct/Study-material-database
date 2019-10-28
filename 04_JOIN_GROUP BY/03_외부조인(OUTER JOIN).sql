--(번외) 고객 중 한 권도 구입 안한 사람은 누구냐?
--CUSTOMER 테이블에 있고, ORDERS 테이블에 없는 사람 찾기
--------------
--MINUS : 차집합 처리
SELECT CUSTID FROM CUSTOMER
MINUS
SELECT CUSTID FROM ORDERS;
--------------------
--서브쿼리(subquery)
SELECT *
  FROM CUSTOMER
 WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
--------------------
--외부조인(OUTER JOIN)
SELECT DISTINCT C.*
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
;
---------
--LEFT OUTER JOIN
SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID(+)
   AND O.ORDERID IS NULL
;  
----------------------
--조인(JOIN, INNER JOIN, 동등조인) : 조인테이블 모두에 존재하는 데이타 검색
--외부조인(OUTER JOIN) :  어느 한 쪽 테이블에 데이타가 존재하지 않는 데이타 검색
----모든 데이타를 표시하고, 일치하지 않는 데이타에 대한 조회 처리할 때 사용 
-------------------
CREATE TABLE DEPT (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT VALUES ('10', '총무부');
INSERT INTO DEPT VALUES ('20', '급여부');
INSERT INTO DEPT VALUES ('30', 'IT부');
COMMIT;
--------
CREATE TABLE DEPT1 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT1 VALUES ('10', '총무부');
INSERT INTO DEPT1 VALUES ('20', '급여부');
COMMIT;
------
CREATE TABLE DEPT2 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT2 VALUES ('10', '총무부');
INSERT INTO DEPT2 VALUES ('30', 'IT부');
COMMIT;
--------------------
SELECT * FROM DEPT;
SELECT * FROM DEPT1;
SELECT * FROM DEPT2;
----------
--DEPT = DEPT1
SELECT *
  FROM DEPT D, DEPT1 D1
 WHERE D.ID = D1.ID
;
---
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID
;
-----------------------------
--DEPT1에는 있고, DEPT2에는 없는 부서 조회
--LEFT OUTER JOIN : 좌측 테이블 기준 전체 데이타 표시하고 우측에 없으면 NULL표시
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID(+)
;
SELECT D1.*
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID(+)
   AND D2.ID IS NULL
;
--============
--ANSI : 표준 SQL (INNER JOIN)
SELECT *
  FROM DEPT1 D1
       INNER JOIN DEPT2 D2
       ON D1.ID = D2.ID
;   
-----
--LEFT OUTER JOIN : 좌측 테이블 기준 우측에 없는 데이타도 조회
SELECT *
  FROM DEPT1 D1
       LEFT OUTER JOIN DEPT2 D2
       ON D1.ID = D2.ID
 WHERE D2.ID IS NULL
;
--=======================
--DEPT2 테이블에는 있고 DEPT1 테이블에 없는 데이타 조회
--RIGHT OUTER JOIN : 우측 테이블 기준 전체 데이타 표시하고 좌측에 없으면 NULL 표시
SELECT *
  FROM DEPT1 D1
       RIGHT OUTER JOIN DEPT2 D2 --조인테이블과 조인 형식
       ON D1.ID = D2.ID --조인조건
;
---
--ORACLE(오라클) : OUTER JOIN 사용 방식 
--기준테이블이 아닌 테이블에 (+)부호를 사용(데이타가 없는 테이블)
SELECT *
  FROM DEPT1 D1, DEPT2 D2 --
 WHERE D1.ID(+) = D2.ID
   AND D1.ID IS NULL
;
--------------------
--FULL OUTER JOIN : 양쪽 테이블에 있는 데이타를 모두 표시(없으면 NULL)
--ANSI 표준 FULL OUTER JOIN 문 사용
SELECT *
  FROM DEPT1 D1
       FULL OUTER JOIN DEPT2 D2
       ON D1.ID = D2.ID
;    












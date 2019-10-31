--UNION, UNION ALL : 합집합 처리
---- 단, 조회하는 컬럼의 이름, 순서, 숫자, 타입이 일치하도록 작성
--UNION : 중복데이타를 제외하고 합해줌
--UNION ALL : 중복데이타를 포함해서 합해줌
-------------------------------
--UNION 사용 예제
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3)
ORDER BY NAME
;
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5)
ORDER BY NAME
;
---- UNION 으로 합하기
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
UNION
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --장미란, 추신수, 박세리
ORDER BY NAME
;
--UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
UNION ALL
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --장미란, 추신수, 박세리
--ORDER BY NAME
;
----------------------------------
--MINUS : 차집합(빼기연산)
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
MINUS
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --장미란, 추신수, 박세리
;
---------------------------------
--INTERSECT : 교집합(중복데이타 조회) - 조인문의 동등비교 결과와 동일
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
INTERSECT
SELECT CUSTID, NAME FROM CUSTOMER
 WHERE CUSTID IN (3, 4, 5) --장미란, 추신수, 박세리
;
-- JOIN 문
SELECT A.*
  FROM (SELECT CUSTID, NAME FROM CUSTOMER
         WHERE CUSTID IN (1, 2, 3) --박지성, 김연아, 장미란
       ) A,
       (SELECT CUSTID, NAME FROM CUSTOMER
         WHERE CUSTID IN (3, 4, 5) --장미란, 추신수, 박세리
       ) B
 WHERE A.CUSTID = B.CUSTID
;
       








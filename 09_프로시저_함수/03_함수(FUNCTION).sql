/* ***** 함수(FUNCTION) ******
실행 후 리턴 값이 있는 프로그램
--리턴할 데이타에 대한 선언 필요
RETURN 데이타유형
-- 프로그램 마지막에 값 리턴문장 필요
RETURN 리턴값;
*****************************/
--파라미터 값으로 BOOKID 값을 받고, 책제목(BOOKNAME)을 돌려받는 함수
CREATE OR REPLACE FUNCTION GET_BOOKNAME (
    IN_ID IN NUMBER -- IN 키워드 생략가능
) RETURN VARCHAR2 --리턴할 데이타 타입
AS
    V_BOOKNAME book.bookname%TYPE;
BEGIN
    SELECT BOOKNAME INTO V_BOOKNAME
    FROM BOOK
    WHERE BOOKID = IN_ID;
    
    RETURN V_BOOKNAME; --리턴값 전달
END;
-------------
--함수의 사용
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID)
  FROM BOOK;
------
SELECT O.*, GET_BOOKNAME(BOOKID)
  FROM ORDERS O;
-------------
SELECT * FROM BOOK
 WHERE GET_BOOKNAME(BOOKID) = '축구의 이해';
----
SELECT * FROM ORDERS
 WHERE GET_BOOKNAME(BOOKID) = '축구의 이해'
;
-----------------------
--(실습) 고객ID 값을 전달받아, 고객명을 돌려주는 함수 작성(CUSTOMER 테이블 참조)
--함수명 : GET_CUSTNAME
--함수를 작성한 후에 ORDERS 테이블의 데이타를 조회
----GET_BOOKNAME, GET_CUSTNAME 함수사용 주문(판매)정보와 책제목, 고객명 조회
-------------------------
SELECT O.*
     , (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) AS CUSTNAME
  FROM ORDERS O
;
SELECT C.*
     , (SELECT count(SALEPRICE) FROM ORDERS WHERE CUSTID = C.CUSTID) AS "구입건수"     
     , (SELECT NVL(SUM(SALEPRICE),0) FROM ORDERS WHERE CUSTID = C.CUSTID) AS "구입한총금액"
  FROM CUSTOMER C
;













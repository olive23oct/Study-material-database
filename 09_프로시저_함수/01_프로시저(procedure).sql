--PL/SQL 프로시저(procedure)
SET SERVEROUTPUT ON;

DECLARE --변수선언
    V_EMPID NUMBER;
    V_NAME VARCHAR2(30);
BEGIN --실행문의 시작(자바의 { 동일)
    V_EMPID := 100; --치환문(대입문) 부호 :=
    V_NAME := '홍길동';
    
    DBMS_OUTPUT.PUT_LINE(V_EMPID ||' : '|| V_NAME);
END; --실행문의 끝(자바의 } 동일)

-----------------------------------
DECLARE 
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    --SELECT ~ INTO ~ FROM  형태로 사용(1개의 데이타만 처리 가능)
    --선택된 값을 INTO 절의 변수에 저장
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
    INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = 5;
    
    DBMS_OUTPUT.PUT_LINE(V_BOOKID ||':'|| V_BOOKNAME
             ||':'|| V_PUBLISHER ||':'|| V_PRICE);
END;

-------------------------------------
--저장프로시저(Stored procedure)
--매개변수 유형
----IN : 입력 받기만 하는 변수(기본값)
----OUT : 출력만 하는 변수
----   (값을 받을 수 없고 프로시저 실행후 호출한 곳으로 변수를 통해 값을 전달)
----IN OUT : 입력도 받고, 값을 변수를 통해 출력도 함
create or replace PROCEDURE BOOK_DISP --프로시저 선언부
--매개변수 선언부 : ( )안에 작성
(
    IN_BOOKID IN NUMBER
)
AS
--변수 선언부(AS 또는 IS ~ BEGIN 문 사이)
    V_BOOKID NUMBER(2);
    V_BOOKNAME VARCHAR2(40);
    V_PUBLISHER VARCHAR2(40);
    V_PRICE NUMBER(8);
BEGIN
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
    INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = IN_BOOKID;

    DBMS_OUTPUT.PUT_LINE(V_BOOKID ||':'|| V_BOOKNAME
             ||':'|| V_PUBLISHER ||':'|| V_PRICE);
END;

----------------------------
--프로시저 실행 : EXECUTE 키워드(명령문) 사용 
EXECUTE BOOK_DISP(1);
EXEC BOOK_DISP(2);

--프로시저 삭제
DROP PROCEDURE BOOK_DISP;

--------------------------
--GET_BOOKINFO(IN, OUT, OUT, OUT)
CREATE OR REPLACE PROCEDURE GET_BOOKINFO (
    IN_BOOKID IN NUMBER,
    OUT_BOOKNAME OUT VARCHAR2,
    OUT_PUBLISHER OUT VARCHAR2,
    OUT_PRICE OUT NUMBER
) AS
    --%TYPE 사용 : 테이블명.컬럼명%TYPE
    --테이블의 컬럼과 동일한 타입으로 선언(변경시에도 적용)
    V_BOOKID BOOK.BOOKID%TYPE;
    V_BOOKNAME BOOK.BOOKNAME%TYPE;
    V_PUBLISHER book.publisher%TYPE;
    V_PRICE book.price%TYPE;
BEGIN
    SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
    INTO V_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE
    FROM BOOK
    WHERE BOOKID = IN_BOOKID;
    
    --데이타를 호출한 곳으로 전달하기 위해 변수에 저장
    OUT_BOOKNAME := V_BOOKNAME;
    OUT_PUBLISHER := V_PUBLISHER;
    OUT_PRICE := V_PRICE;
    
    DBMS_OUTPUT.PUT_LINE(V_BOOKID ||':'|| OUT_BOOKNAME
             ||':'|| OUT_PUBLISHER ||':'|| OUT_PRICE);
END;
-------
--OUT 매개변수에 조회한 데이타 바로 저장
create or replace PROCEDURE GET_BOOKINFO2 (
    IN_BOOKID IN NUMBER,
    OUT_BOOKNAME OUT VARCHAR2,
    OUT_PUBLISHER OUT VARCHAR2,
    OUT_PRICE OUT NUMBER
) AS
BEGIN
    SELECT BOOKNAME, PUBLISHER, PRICE
    INTO OUT_BOOKNAME, OUT_PUBLISHER, OUT_PRICE
    FROM BOOK
    WHERE BOOKID = IN_BOOKID;

    DBMS_OUTPUT.PUT_LINE(IN_BOOKID ||':'|| OUT_BOOKNAME
             ||':'|| OUT_PUBLISHER ||':'|| OUT_PRICE);
END;
--======================================
--프로시저 OUT 매개변수 값 확인
create or replace PROCEDURE GET_BOOKINFO_TEST (
    IN_BOOKID IN NUMBER
) AS
    V_BOOKNAME book.bookname%TYPE;
    V_PUBLISHER book.publisher%TYPE;
    V_PRICE book.price%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('입력받은 값(ID) : '|| IN_BOOKID);
    
    --GET_BOOKINFO 프로시저 실행(호출)
    GET_BOOKINFO(IN_BOOKID, V_BOOKNAME, V_PUBLISHER, V_PRICE);
    
    --프로시저로 부터 받은 값(OUT) 화면 출력
    DBMS_OUTPUT.PUT_LINE('>>BOOKINFO_TEST결과 - ' || IN_BOOKID ||'/'||
            V_BOOKNAME ||'/'|| V_PUBLISHER ||'/'|| V_PRICE);  
END;
--=======================================
--(실습) : 고객테이블(CUSTOMER)에 있는 데이타 조회 프로시저 작성
--프로시저명 : GET_CUSTINFO
--입력받는 값 : 고객ID 값
--처리 : 입력받은 고객ID에 해당하는 데이타를 화면에 출력
--      고객ID, 고객명, 주소, 전화번호 출력
------------------------



























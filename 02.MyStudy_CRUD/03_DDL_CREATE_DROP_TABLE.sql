-- ===========================
/* (실습) 테이블명 : TEST2
    NO : 숫자타입 5자리, PRIMARY KEY 선언
    ID : 문자타입 10자리(영문10자리), 값이 반드시 존재
    NAME : 한글 10자리 저장가능토록 설정, 값이 반드시 존재
    EMAIL : 영문, 숫자, 특수문자 포함 30자리 
    ADDRESS : 한글 100자리
    IDNUM : 숫자타입 정수부 7자리, 소수부 3자리(1234567.789)
    REGDATE : 날짜타입
*****************************/
CREATE TABLE TEST2 (
    NO NUMBER(5) PRIMARY KEY,
    ID VARCHAR2(10) NOT NULL,
    NAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(30),
    ADDRESS VARCHAR2(300),
    IDNUM NUMBER(10,3),
    REGDATE DATE
);
SELECT * FROM TEST2;
INSERT INTO TEST2
VALUES (11111, 'TEST1', '홍길동1', 'test1@test.com', 
        '서울시 종로구', 1234567.8765, sysdate);
INSERT INTO TEST2
VALUES (22222, 'TEST2', '홍길동2', 'test2@test.com', 
        '서울시 종로구', 1234567.8764, sysdate);        
INSERT INTO TEST2 (NO, ID, NAME)
VALUES (11, 'TEST3', '홍길동11');
INSERT INTO TEST2 (NO, ID, NAME)
VALUES (12, 'TEST4', '홍길동12');
COMMIT;

--=================================
-- 특정 테이블의 데이타와 함께 테이블 구조를 함께 복사
-- TEST2 ===> 복사해서 ===> TEST3 테이블 만들기
CREATE TABLE TEST3 
AS
SELECT * FROM TEST2;
-------
SELECT * FROM TEST2;
SELECT * FROM TEST3;
------------------------------
-- 특정 테이블의 구조만 복사
-- TEST2 -> TEST4 : 데이타는 복사하지 않음
CREATE TABLE TEST4
AS SELECT * FROM TEST2 WHERE 1 = 2;

CREATE TABLE TEST5
AS SELECT NO, ID, NAME, EMAIL FROM TEST2 WHERE NO > 10000;

--===============================
SELECT * FROM TEST2;
DELETE FROM TEST2 WHERE ID = 'TEST3';

--테이블 전체 데이타 삭제
DELETE FROM TEST2; --테이블 데이타 전체 삭제
ROLLBACK; --DELETE 문은 ROLLBACK 명령문으로 데이타 복구 가능
------
TRUNCATE TABLE TEST2; --TRUNCATE TABLE 문 사용시 ROLLBACK 처리안됨
ROLLBACK;
------------------
--DROP TABLE 문은 테이블의 구조와 데이타를 함께 삭제 처리
DROP TABLE TEST2;

--===================================
/** 테이블의 컬럼 추가, 수정, 삭제
DDL : ALTER TABLE
- ADD : 추가
- MODIFY : 수정
  -- 컬럼사이즈 작은 -> 큰 : 언제든 가능
  -- 컬럼사이즈 큰 -> 작은 : 데이타 상태에 따라 다름
- DROP COLUMN : 삭제
*****************************/
SELECT * FROM TEST3;
-- 컬럼추가 TEST3 테이블에 ADDCOL 컬럼 추가
ALTER TABLE TEST3 ADD ADDCOL VARCHAR2(10);

-- 컬럼 수정 TEST3 테이블의 ADDCOL 크기 -> VARCHAR2(20)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(20);
UPDATE TEST3 SET ADDCOL = '123456789012345';
SELECT * FROM TEST3;

--ORA-01441: cannot decrease column length because some value is too big
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(10);
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(15); --데이타 최대크기만큼 수정 가능

--컬럼삭제
ALTER TABLE TEST3 DROP COLUMN ADDCOL;






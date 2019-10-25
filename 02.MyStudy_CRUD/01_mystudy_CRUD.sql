--SQL(Structured Query Language)에서의 한줄 주석
/* 여러 줄 주석(자바와 동일)
   모두 주석 처리됨
*/
--테이블 생성(STUDENT)
CREATE TABLE STUDENT (
    ID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(30),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MATH NUMBER(3),
    TOT NUMBER(3),
    AVG NUMBER(5,2) --전체 자리수 5자리, 소수점이하 2자리
);
-------------------------------------------
--SQL 문에서는 대소문자 구분이 없음
SELECT * FROM STUDENT;
select * from student;

--데이타 추가 : 데이타 입력(INSERT)
INSERT INTO STUDENT 
       (ID, NAME, KOR, ENG, MATH)
VALUES ('2019001', '홍길동', 100, 90, 80);
COMMIT; --COMMIT : 데이타 확정 저장(물리적으로 DB에 쓰기)
ROLLBACK; --최종 커밋 이후 상태로 되돌리기

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019002', '김유신', 95, 90, 80);
INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019003', '강감찬', 95, 90, 80);
COMMIT;
----------------
SELECT * FROM STUDENT;
--============================
--수정 : 데이타 수정(UPDATE)
--강감찬 수학점수 : 80 -> 88 수정
SELECT * FROM STUDENT WHERE NAME = '강감찬';

UPDATE STUDENT
   SET KOR = 90, ENG = 93, MATH = 88
 WHERE NAME = '강감찬'
;
COMMIT;
---------------------------
--수정 : 김유신 -> 을지문덕 으로 변경
SELECT * FROM STUDENT;
SELECT * FROM STUDENT WHERE NAME = '김유신';

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019004', '김유신', 90, 90, 90);

SELECT * FROM STUDENT WHERE ID = '2019002';
UPDATE STUDENT
   SET NAME = '을지문덕'
 WHERE ID = '2019002'; -- =, >, <, >=, <=, !=, <>
--=====================================
--삭제 : 데이타 삭제(DELETE)
SELECT * FROM STUDENT WHERE NAME = '강감찬';
DELETE FROM STUDENT WHERE NAME = '강감찬';
COMMIT;
--(실습) 이름이 김유신 데이타 삭제
DELETE FROM STUDENT WHERE NAME = '김유신';
--=====================================
SELECT ID, NAME FROM STUDENT;
SELECT NAME, KOR, ENG, MATH FROM STUDENT;

INSERT INTO STUDENT VALUES ('홍길동2', '2019005', 100, 90, 80, 0,0);
SELECT * FROM STUDENT;

-- INSERT 문에서 컬럼을 생략하는 경우에는 
-- 테이블 컬럼 갯수와 순서를 일치해서 값을 대입해야만 한다
-- (SQL 오류: ORA-00947: not enough values)
INSERT INTO STUDENT VALUES ('2019006', '홍길동3', 100, 90, 80, 0, 0);
--===============================
/* 데이타 조회(검색), 입력, 수정, 삭제 작업용 SQL 문
SELECT * FROM 테이블명; --테이블 전체 컬럼 조회(검색)
SELECT 컬럼명1, 컬럼명2, ..., 컬럼명n 
  FROM 테이블명
 WHERE 검색조건;

INSERT INTO 테이블명 (컬럼명1, 컬럼명2, ..., 컬럼명n)
VALUES (값1, 값2, ..., 값n);
INSERT INTO 테이블명 VALUES (값1, 값2, ..., 값n);

UPDATE 테이블명
   SET 컬럼명1 = 값1, 컬럼명2 = 값2, ... , 컬럼명n = 값n
 WHERE 검색조건;

DELETE FROM 테이블명 WHERE 검색조건;

*/













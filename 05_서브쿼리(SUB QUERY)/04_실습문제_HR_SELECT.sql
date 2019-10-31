/* ** 실습문제 : HR유저(DB)에서 요구사항 해결 **********
-- 사번(employee_id)이 100인 직원 정보 전체 보기
-- 월급(salary)이 15000 이상인 직원의 모든 정보 보기
-- 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
-- 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
-- 이름(first_name)이 john인 사원의 모든 정보 조회
-- 이름(first_name)이 john인 사원은 몇 명인가?
-- 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
-- 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
-- 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
-- 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
-- 직종별 최대 월급여 검색
-- 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
-- 직종별 평균급여 이상인 직원 조회
**********************************************************/
-- 사번(employee_id)이 100인 직원 정보 전체 보기
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

-- 월급(salary)이 15000 이상인 직원의 모든 정보 보기
SELECT * FROM EMPLOYEES WHERE SALARY >= 15000;

-- 월급이 15000 이상인 사원의 사번, 이름(LAST_NAME), 입사일(hire_date), 월급여 정보 보기
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
--SELECT *
  FROM EMPLOYEES WHERE SALARY >= 15000;

-- 월급이 10000 이하인 사원의 사번, 이름(LAST_NAME), 입사일, 월급여 정보 보기
---- (급여가 많은 사람부터)
Select Employee_Id, Last_Name, Hire_Date, Salary
  From Employees
 Where Salary <= 10000
 Order By Salary Desc
;
-- 이름(first_name)이 john인 사원의 모든 정보 조회
---- JOHN, John, john, JOhn, joHN....
SELECT * FROM EMPLOYEES
 WHERE FIRST_NAME = INITCAP('john')
;
SELECT LOWER(FIRST_NAME), E.* FROM EMPLOYEES E
 WHERE LOWER(FIRST_NAME) = 'john'
;
SELECT * FROM EMPLOYEES E
 WHERE FIRST_NAME = 'John'
;
SELECT LOWER(FIRST_NAME), E.* FROM EMPLOYEES E
 WHERE LOWER(FIRST_NAME) = LOWER('joHN')
;
-- 이름(first_name)이 john인 사원은 몇 명인가?
SELECT COUNT(*) 
  FROM EMPLOYEES E
 WHERE LOWER(FIRST_NAME) = 'john'
;

-- 2008년에 입사한 사원의 사번, 성명('first_name last_name'), 월급여 정보 조회
---- 성명 출력예) 'Steven King'
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS FULLNAME, SALARY
     , HIRE_DATE
  FROM EMPLOYEES
 WHERE HIRE_DATE BETWEEN TO_DATE('2008/01/01', 'YYYY/MM/DD') 
                     AND TO_DATE('2008-12-31', 'YYYY-MM-DD')
 ORDER BY HIRE_DATE
;
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS FULLNAME, SALARY
     , HIRE_DATE, TO_CHAR(HIRE_DATE, 'YYYY')
  FROM EMPLOYEES
 WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2008'
 ORDER BY HIRE_DATE
;
-- 월급여가 20000~30000 구간인 직원 사번, 성명(last_name first_name), 월급여 정보 조회
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS FULLNAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 20000 AND SALARY <= 30000
;
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS FULLNAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 20000 AND 30000
;
-- 관리자ID(MANAGER_ID)가 없는 사람 정보 조회
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NULL;

-- 직종(job_id)코드 'IT_PROG'에서 가장 많은 월급여는 얼마
SELECT MAX(SALARY)
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG'
;
----직종(job_id)코드 'IT_PROG'에서 가장 많이 받는 사람은 누구?
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG'
   AND SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES
                  WHERE JOB_ID = 'IT_PROG')
;
-- 직종별 최대 월급여 검색
SELECT JOB_ID, COUNT(*), SUM(SALARY), AVG(SALARY), MAX(SALARY), MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
;
-- 직종별 최대 월급여 검색하고, 최대 월급여가 10000이상인 직종 조회
SELECT JOB_ID, MAX(SALARY), AVG(SALARY), MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
 HAVING MAX(SALARY) >= 10000
 ORDER BY MAX(SALARY)
;
SELECT JOB_ID, MAX(SALARY), AVG(SALARY), MIN(SALARY)
  FROM EMPLOYEES
 WHERE SALARY >= 10000
 GROUP BY JOB_ID
 ORDER BY MAX(SALARY) 
;
-- 직종별 평균급여 이상인 직원 조회
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES) --전직원 평균급여 이상인 사람
 ORDER BY SALARY
;
SELECT *
  FROM EMPLOYEES E
 WHERE SALARY >= (SELECT AVG(SALARY) 
                    FROM EMPLOYEES
                   WHERE JOB_ID = E.JOB_ID
                 ) 
 ORDER BY SALARY
;
----JOIN문으로
SELECT JOB_ID, AVG(SALARY) JOB_AVG_SALARY
  FROM EMPLOYEES
 GROUP BY JOB_ID
;
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, E.SALARY 
     --, AVG.JOB_AVG_SALARY
     --, AVG.JOB_ID AVG_JOB_ID
  FROM EMPLOYEES E,
       (SELECT JOB_ID, AVG(SALARY) JOB_AVG_SALARY
        FROM EMPLOYEES
        GROUP BY JOB_ID
       ) AVG
 WHERE E.JOB_ID = AVG.JOB_ID --조인조건
   AND E.SALARY >= AVG.JOB_AVG_SALARY
 ORDER BY E.JOB_ID, E.SALARY DESC
;

--======================================
--상관서브쿼리, 조인문으로 작성(2가지 방식)
--(추가) 직종별 최대 월급여를 받는 직원의 사번, 성명, 월급여, 직종(직무)코드 정보 조회
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME FULLNAME
     , SALARY, JOB_ID
  FROM EMPLOYEES E
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES
                  WHERE JOB_ID = E.JOB_ID
                )
 ORDER BY JOB_ID, SALARY
;
-------
SELECT * FROM EMPLOYEES;
SELECT JOB_ID, MAX(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
;
--
SELECT E.EMPLOYEE_ID, E.FIRST_NAME||' '||E.LAST_NAME FULLNAME
     , E.SALARY, E.JOB_ID
     , MAX.JOB_ID, MAX.MAX_SALARY
  FROM EMPLOYEES E,
       (SELECT JOB_ID, MAX(SALARY) MAX_SALARY
          FROM EMPLOYEES
         GROUP BY JOB_ID
       ) MAX
 WHERE E.JOB_ID = MAX.JOB_ID
   AND E.SALARY = MAX.MAX_SALARY
;
--(추가) 부서별 최대 월급여를 받는 직원의 사번, 성명, 월급여, 부서코드 정보 조회
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME FULLNAME
     , SALARY, DEPARTMENT_ID
  FROM EMPLOYEES E
 WHERE SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES
                  WHERE DEPARTMENT_ID = E.DEPARTMENT_ID
                )
 ORDER BY DEPARTMENT_ID, SALARY
;
------
SELECT E.EMPLOYEE_ID, E.FIRST_NAME||' '||E.LAST_NAME FULLNAME
     , E.SALARY, E.DEPARTMENT_ID
     , MAX.DEPARTMENT_ID, MAX.MAX_SALARY
  FROM EMPLOYEES E,
       (SELECT DEPARTMENT_ID, MAX(SALARY) MAX_SALARY
          FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID
       ) MAX
 WHERE E.DEPARTMENT_ID = MAX.DEPARTMENT_ID
   AND E.SALARY = MAX.MAX_SALARY
;
--부서별 인원수, 급여합계, 평균급여, 가장 많은 급여, 가장 적은 급여 
SELECT DEPARTMENT_ID 
     , COUNT(*), SUM(SALARY), TRUNC(AVG(SALARY))
     , MAX(SALARY), MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;
--======================================
--직원들의 매니저 이름을 함께 조회
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, MANAGER_ID
     , (SELECT FIRST_NAME||' '||LAST_NAME 
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = E.MANAGER_ID
       ) MANAGER_NAME
  FROM EMPLOYEES E
;
---
SELECT FIRST_NAME||' '||LAST_NAME 
          FROM EMPLOYEES
         WHERE EMPLOYEE_ID = 102
;
--------------
--JOIN문(SELF JOIN문)
SELECT E1.EMPLOYEE_ID, E1.FIRST_NAME, E1.MANAGER_ID
     , E2.EMPLOYEE_ID AS E2_EMP_ID, E2.FIRST_NAME AS E2_FNAME
  FROM EMPLOYEES E1,
       EMPLOYEES E2
 WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID
 ORDER BY E1.EMPLOYEE_ID
;















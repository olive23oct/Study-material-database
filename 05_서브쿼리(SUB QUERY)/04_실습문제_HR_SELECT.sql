/* ** �ǽ����� : HR����(DB)���� �䱸���� �ذ� **********
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
-- ������ �ִ� ���޿� �˻�
-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
-- ������ ��ձ޿� �̻��� ���� ��ȸ
**********************************************************/
-- ���(employee_id)�� 100�� ���� ���� ��ü ����
SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

-- ����(salary)�� 15000 �̻��� ������ ��� ���� ����
SELECT * FROM EMPLOYEES WHERE SALARY >= 15000;

-- ������ 15000 �̻��� ����� ���, �̸�(LAST_NAME), �Ի���(hire_date), ���޿� ���� ����
SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
--SELECT *
  FROM EMPLOYEES WHERE SALARY >= 15000;

-- ������ 10000 ������ ����� ���, �̸�(LAST_NAME), �Ի���, ���޿� ���� ����
---- (�޿��� ���� �������)
Select Employee_Id, Last_Name, Hire_Date, Salary
  From Employees
 Where Salary <= 10000
 Order By Salary Desc
;
-- �̸�(first_name)�� john�� ����� ��� ���� ��ȸ
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
-- �̸�(first_name)�� john�� ����� �� ���ΰ�?
SELECT COUNT(*) 
  FROM EMPLOYEES E
 WHERE LOWER(FIRST_NAME) = 'john'
;

-- 2008�⿡ �Ի��� ����� ���, ����('first_name last_name'), ���޿� ���� ��ȸ
---- ���� ��¿�) 'Steven King'
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
-- ���޿��� 20000~30000 ������ ���� ���, ����(last_name first_name), ���޿� ���� ��ȸ
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS FULLNAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY >= 20000 AND SALARY <= 30000
;
SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS FULLNAME, SALARY
  FROM EMPLOYEES
 WHERE SALARY BETWEEN 20000 AND 30000
;
-- ������ID(MANAGER_ID)�� ���� ��� ���� ��ȸ
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NULL;

-- ����(job_id)�ڵ� 'IT_PROG'���� ���� ���� ���޿��� ��
SELECT MAX(SALARY)
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG'
;
----����(job_id)�ڵ� 'IT_PROG'���� ���� ���� �޴� ����� ����?
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG'
   AND SALARY = (SELECT MAX(SALARY)
                   FROM EMPLOYEES
                  WHERE JOB_ID = 'IT_PROG')
;
-- ������ �ִ� ���޿� �˻�
SELECT JOB_ID, COUNT(*), SUM(SALARY), AVG(SALARY), MAX(SALARY), MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY JOB_ID
;
-- ������ �ִ� ���޿� �˻��ϰ�, �ִ� ���޿��� 10000�̻��� ���� ��ȸ
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
-- ������ ��ձ޿� �̻��� ���� ��ȸ
SELECT *
  FROM EMPLOYEES
 WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES) --������ ��ձ޿� �̻��� ���
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
----JOIN������
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
 WHERE E.JOB_ID = AVG.JOB_ID --��������
   AND E.SALARY >= AVG.JOB_AVG_SALARY
 ORDER BY E.JOB_ID, E.SALARY DESC
;

--======================================
--�����������, ���ι����� �ۼ�(2���� ���)
--(�߰�) ������ �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, ����(����)�ڵ� ���� ��ȸ
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
--(�߰�) �μ��� �ִ� ���޿��� �޴� ������ ���, ����, ���޿�, �μ��ڵ� ���� ��ȸ
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
--�μ��� �ο���, �޿��հ�, ��ձ޿�, ���� ���� �޿�, ���� ���� �޿� 
SELECT DEPARTMENT_ID 
     , COUNT(*), SUM(SALARY), TRUNC(AVG(SALARY))
     , MAX(SALARY), MIN(SALARY)
  FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID
;
--======================================
--�������� �Ŵ��� �̸��� �Բ� ��ȸ
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
--JOIN��(SELF JOIN��)
SELECT E1.EMPLOYEE_ID, E1.FIRST_NAME, E1.MANAGER_ID
     , E2.EMPLOYEE_ID AS E2_EMP_ID, E2.FIRST_NAME AS E2_FNAME
  FROM EMPLOYEES E1,
       EMPLOYEES E2
 WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID
 ORDER BY E1.EMPLOYEE_ID
;















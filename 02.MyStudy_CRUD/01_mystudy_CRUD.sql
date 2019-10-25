--SQL(Structured Query Language)������ ���� �ּ�
/* ���� �� �ּ�(�ڹٿ� ����)
   ��� �ּ� ó����
*/
--���̺� ����(STUDENT)
CREATE TABLE STUDENT (
    ID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(30),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MATH NUMBER(3),
    TOT NUMBER(3),
    AVG NUMBER(5,2) --��ü �ڸ��� 5�ڸ�, �Ҽ������� 2�ڸ�
);
-------------------------------------------
--SQL �������� ��ҹ��� ������ ����
SELECT * FROM STUDENT;
select * from student;

--����Ÿ �߰� : ����Ÿ �Է�(INSERT)
INSERT INTO STUDENT 
       (ID, NAME, KOR, ENG, MATH)
VALUES ('2019001', 'ȫ�浿', 100, 90, 80);
COMMIT; --COMMIT : ����Ÿ Ȯ�� ����(���������� DB�� ����)
ROLLBACK; --���� Ŀ�� ���� ���·� �ǵ�����

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019002', '������', 95, 90, 80);
INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019003', '������', 95, 90, 80);
COMMIT;
----------------
SELECT * FROM STUDENT;
--============================
--���� : ����Ÿ ����(UPDATE)
--������ �������� : 80 -> 88 ����
SELECT * FROM STUDENT WHERE NAME = '������';

UPDATE STUDENT
   SET KOR = 90, ENG = 93, MATH = 88
 WHERE NAME = '������'
;
COMMIT;
---------------------------
--���� : ������ -> �������� ���� ����
SELECT * FROM STUDENT;
SELECT * FROM STUDENT WHERE NAME = '������';

INSERT INTO STUDENT (ID, NAME, KOR, ENG, MATH)
VALUES ('2019004', '������', 90, 90, 90);

SELECT * FROM STUDENT WHERE ID = '2019002';
UPDATE STUDENT
   SET NAME = '��������'
 WHERE ID = '2019002'; -- =, >, <, >=, <=, !=, <>
--=====================================
--���� : ����Ÿ ����(DELETE)
SELECT * FROM STUDENT WHERE NAME = '������';
DELETE FROM STUDENT WHERE NAME = '������';
COMMIT;
--(�ǽ�) �̸��� ������ ����Ÿ ����
DELETE FROM STUDENT WHERE NAME = '������';
--=====================================
SELECT ID, NAME FROM STUDENT;
SELECT NAME, KOR, ENG, MATH FROM STUDENT;

INSERT INTO STUDENT VALUES ('ȫ�浿2', '2019005', 100, 90, 80, 0,0);
SELECT * FROM STUDENT;

-- INSERT ������ �÷��� �����ϴ� ��쿡�� 
-- ���̺� �÷� ������ ������ ��ġ�ؼ� ���� �����ؾ߸� �Ѵ�
-- (SQL ����: ORA-00947: not enough values)
INSERT INTO STUDENT VALUES ('2019006', 'ȫ�浿3', 100, 90, 80, 0, 0);
--===============================
/* ����Ÿ ��ȸ(�˻�), �Է�, ����, ���� �۾��� SQL ��
SELECT * FROM ���̺��; --���̺� ��ü �÷� ��ȸ(�˻�)
SELECT �÷���1, �÷���2, ..., �÷���n 
  FROM ���̺��
 WHERE �˻�����;

INSERT INTO ���̺�� (�÷���1, �÷���2, ..., �÷���n)
VALUES (��1, ��2, ..., ��n);
INSERT INTO ���̺�� VALUES (��1, ��2, ..., ��n);

UPDATE ���̺��
   SET �÷���1 = ��1, �÷���2 = ��2, ... , �÷���n = ��n
 WHERE �˻�����;

DELETE FROM ���̺�� WHERE �˻�����;

*/













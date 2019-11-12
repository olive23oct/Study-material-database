CREATE TABLE DEPT (
    ID VARCHAR2(10) PRIMARY KEY, --NOT NULL + UNIQUE
    NAME VARCHAR2(30)
);
INSERT INTO DEPT VALUES ('10', '�ѹ���');
INSERT INTO DEPT VALUES ('20', '�޿���');
INSERT INTO DEPT VALUES ('30', '�����');
COMMIT;
/* **************************
--���̺� ������ �������� ����
--�÷��� �����ϸ鼭 �÷��������� �������� ����
--�ܷ�Ű(FOREIGN KEY) �������� ���� ����
--���� : �÷��� REFERENCES ������̺�(����÷�)
***************************/
--�÷��������� �ܷ�Ű ����
CREATE TABLE EMP01 (
    EMPNO NUMBER PRIMARY KEY,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10) REFERENCES DEPT(ID) --�ܷ�Ű ����
);
-----------
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10'); --�����Է�

--ORA-02291: integrity constraint (MADANG.SYS_C007023) violated 
--     - parent key not found
INSERT INTO EMP01 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, 'ȫ�浿2', '����2', '40');

--============================================
--���̺� ���� ������� �������� ����
CREATE TABLE EMP02 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    PRIMARY KEY (EMPNO), --�⺻Ű(PRIMARY KEY) ����
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID)
);
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10'); --�����Է�

--ORA-02291: integrity constraint (MADANG.SYS_C007026) violated 
--        - parent key not found
INSERT INTO EMP02 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, 'ȫ�浿2', '����2', '40');

-----------------------------------------
--�������Ǹ��� ��������� �����ؼ� ���
--���� : CONSTRAINT ���������̸�  ������������ 
CREATE TABLE EMP03 (
    EMPNO NUMBER,
    ENAME VARCHAR2(30) CONSTRAINT EMP03_ENAME_NN NOT NULL,
    JOB VARCHAR2(10),
    DEPTNO VARCHAR2(10),
    
    CONSTRAINT EMP03_EMPNO_PK PRIMARY KEY (EMPNO),
    CONSTRAINT EMP03_DEPTNO_FK FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID)
);
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (1111, 'ȫ�浿', '����1', '10'); --�����Է�

--ORA-02291: integrity constraint (MADANG.SYS_C007026) violated 
--        - parent key not found
INSERT INTO EMP03 (EMPNO, ENAME, JOB, DEPTNO)
VALUES (2222, 'ȫ�浿2', '����2', '40');
------------------------------------
--�������� ��ȸ SQL
SELECT A.TABLE_NAME, A.COLUMN_NAME, A.CONSTRAINT_NAME
     , B.CONSTRAINT_TYPE
     , DECODE(B.CONSTRAINT_TYPE, 
              'P', 'PRIMARY KEY',
              'U', 'UNIQUE',
              'C', 'CHECK OR NOT NULL',
              'R', 'FOREIGN KEY') CONSTRAINT_TYPE_DESC
  FROM USER_CONS_COLUMNS A, USER_CONSTRAINTS B
 WHERE A.TABLE_NAME = B.TABLE_NAME
   AND A.CONSTRAINT_NAME = B.CONSTRAINT_NAME
   AND A.TABLE_NAME LIKE 'EMP%'
;
--========================================
--����Ű�� �⺻Ű(PRIMARY KEY)�� ����
CREATE TABLE HSCHOOL (
    HAK NUMBER(1), --1�г� : �г⿡ 300���̴� 
    BAN NUMBER(2), --1�� : �ݺ��� 30�� - 30 * 3���г� = 90
    BUN NUMBER(2), --1�� : 30��
    NAME VARCHAR2(30), --? �ߺ��� ����
    CONSTRAINT HSCHOOL_HAK_BAN_BUN_PK PRIMARY KEY (HAK, BAN, BUN)
);
INSERT INTO HSCHOOL VALUES (1,1,1, 'ȫ�浿');
INSERT INTO HSCHOOL VALUES (1,1,2, 'ȫ�浿2');
INSERT INTO HSCHOOL VALUES (1,1,3, 'ȫ�浿3');
INSERT INTO HSCHOOL VALUES (1,2,1, 'ȫ�浿4');
INSERT INTO HSCHOOL VALUES (2,1,1, '������');

--ORA-00001: unique constraint (MADANG.HSCHOOL_HAK_BAN_BUN_PK) violated
INSERT INTO HSCHOOL VALUES (1,1,1, '������'); --111 ȫ�浿 �ߺ� ����Ÿ

--=====================================
/* ***** �������� �߰�, ���� ************
--�������� �߰�
ALTER TABLE ���̺�� ADD CONSTRAINT ����� �������� (�÷���);

--�������� ����
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�;
**************************************/
--EMP01 ���̺��� PRIMARY KEY ���� : SYS_C007022
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007022;

--EMP01 ���̺� PRIMARY KEY �߰� 
--ALTER TABLE ���̺�� ADD CONSTRAINT ����� �������� (�÷���);
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);
--------------
INSERT INTO EMP01 VALUES (1111, 'ȫ�浿2', '����1', '10');--unique constraint
ALTER TABLE EMP01 DROP CONSTRAINT EMP01_EMPNO_PK; --PK����

INSERT INTO EMP01 VALUES (1111, 'ȫ�浿2', '����1', '10'); --�ߺ�����Ÿ �Է�
-- EMPNO�� �ߺ�����Ÿ �Ǵ� NULL���� �����ϸ� PK ���������� ���� �� ����
--(�ذ���) ����Ÿ�� ����ó�� - �ߺ�����Ÿ ���� �Ǵ� �����ؼ� �ߺ� ����
----       NULL ���� �ִ� ��� NULL�� �ƴ� ������ ����ó�� �Ǵ� ����
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_EMPNO_PK PRIMARY KEY (EMPNO);

----------------------------------------
/* **** �������� Ȱ��ȭ �Ǵ� ��Ȱ��ȭ ****************
-- ���������� �����Ǿ� �ִ� ���� �������� �Ǵ� ����
ALTER TABLE ���̺�� DISABLE CONSTRAINT �����̸�; --��Ȱ��ȭ(��������)
ALTER TABLE ���̺�� ENABLE CONSTRAINT �����̸�; --Ȱ��ȭ(����)
**************************/
--EMP01�� �ִ� �ܷ�Ű(FOREIGN KEY) ������ �߰� : SYS_C007023
ALTER TABLE EMP01 DROP CONSTRAINT SYS_C007023;

--EMP01�� �ܷ�Ű(FOREIGN KEY) �߰� : EMP01_DEPTNO_FK
ALTER TABLE EMP01 ADD CONSTRAINT EMP01_DEPTNO_FK
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(ID);
--------------------------------
--FK ���� �� : parent key not found
INSERT INTO EMP01 VALUES (3333, 'ȫ�浿3', '����3', '40');

--�ܷ�Ű(EMP01_DEPTNO_FK) ��Ȱ��ȭ
--ALTER TABLE ���̺�� DISABLE CONSTRAINT �����̸�;
ALTER TABLE EMP01 DISABLE CONSTRAINT EMP01_DEPTNO_FK;

INSERT INTO EMP01 VALUES (3333, 'ȫ�浿3', '����3', '40');

--�ܷ�Ű(EMP01_DEPTNO_FK) Ȱ��ȭ
--ALTER TABLE ���̺�� ENABLE CONSTRAINT �����̸�;
ALTER TABLE EMP01 ENABLE CONSTRAINT EMP01_DEPTNO_FK;
-- <== - parent keys not found : ENPNO 3333 ����Ÿ�� DEPTNO 40 �־
UPDATE EMP01 SET DEPTNO = '30' WHERE EMPNO = 3333;
--�μ��ڵ� ������ ENABLE ó�� : ���� ó����
ALTER TABLE EMP01 ENABLE CONSTRAINT EMP01_DEPTNO_FK;

--========================================










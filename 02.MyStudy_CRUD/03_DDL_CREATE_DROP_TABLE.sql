-- ===========================
/* (�ǽ�) ���̺�� : TEST2
    NO : ����Ÿ�� 5�ڸ�, PRIMARY KEY ����
    ID : ����Ÿ�� 10�ڸ�(����10�ڸ�), ���� �ݵ�� ����
    NAME : �ѱ� 10�ڸ� ���尡����� ����, ���� �ݵ�� ����
    EMAIL : ����, ����, Ư������ ���� 30�ڸ� 
    ADDRESS : �ѱ� 100�ڸ�
    IDNUM : ����Ÿ�� ������ 7�ڸ�, �Ҽ��� 3�ڸ�(1234567.789)
    REGDATE : ��¥Ÿ��
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
VALUES (11111, 'TEST1', 'ȫ�浿1', 'test1@test.com', 
        '����� ���α�', 1234567.8765, sysdate);
INSERT INTO TEST2
VALUES (22222, 'TEST2', 'ȫ�浿2', 'test2@test.com', 
        '����� ���α�', 1234567.8764, sysdate);        
INSERT INTO TEST2 (NO, ID, NAME)
VALUES (11, 'TEST3', 'ȫ�浿11');
INSERT INTO TEST2 (NO, ID, NAME)
VALUES (12, 'TEST4', 'ȫ�浿12');
COMMIT;

--=================================
-- Ư�� ���̺��� ����Ÿ�� �Բ� ���̺� ������ �Բ� ����
-- TEST2 ===> �����ؼ� ===> TEST3 ���̺� �����
CREATE TABLE TEST3 
AS
SELECT * FROM TEST2;
-------
SELECT * FROM TEST2;
SELECT * FROM TEST3;
------------------------------
-- Ư�� ���̺��� ������ ����
-- TEST2 -> TEST4 : ����Ÿ�� �������� ����
CREATE TABLE TEST4
AS SELECT * FROM TEST2 WHERE 1 = 2;

CREATE TABLE TEST5
AS SELECT NO, ID, NAME, EMAIL FROM TEST2 WHERE NO > 10000;

--===============================
SELECT * FROM TEST2;
DELETE FROM TEST2 WHERE ID = 'TEST3';

--���̺� ��ü ����Ÿ ����
DELETE FROM TEST2; --���̺� ����Ÿ ��ü ����
ROLLBACK; --DELETE ���� ROLLBACK ��ɹ����� ����Ÿ ���� ����
------
TRUNCATE TABLE TEST2; --TRUNCATE TABLE �� ���� ROLLBACK ó���ȵ�
ROLLBACK;
------------------
--DROP TABLE ���� ���̺��� ������ ����Ÿ�� �Բ� ���� ó��
DROP TABLE TEST2;

--===================================
/** ���̺��� �÷� �߰�, ����, ����
DDL : ALTER TABLE
- ADD : �߰�
- MODIFY : ����
  -- �÷������� ���� -> ū : ������ ����
  -- �÷������� ū -> ���� : ����Ÿ ���¿� ���� �ٸ�
- DROP COLUMN : ����
*****************************/
SELECT * FROM TEST3;
-- �÷��߰� TEST3 ���̺� ADDCOL �÷� �߰�
ALTER TABLE TEST3 ADD ADDCOL VARCHAR2(10);

-- �÷� ���� TEST3 ���̺��� ADDCOL ũ�� -> VARCHAR2(20)
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(20);
UPDATE TEST3 SET ADDCOL = '123456789012345';
SELECT * FROM TEST3;

--ORA-01441: cannot decrease column length because some value is too big
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(10);
ALTER TABLE TEST3 MODIFY ADDCOL VARCHAR2(15); --����Ÿ �ִ�ũ�⸸ŭ ���� ����

--�÷�����
ALTER TABLE TEST3 DROP COLUMN ADDCOL;






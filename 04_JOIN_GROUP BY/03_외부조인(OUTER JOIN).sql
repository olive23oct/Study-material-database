--(����) �� �� �� �ǵ� ���� ���� ����� ������?
--CUSTOMER ���̺� �ְ�, ORDERS ���̺� ���� ��� ã��
--------------
--MINUS : ������ ó��
SELECT CUSTID FROM CUSTOMER
MINUS
SELECT CUSTID FROM ORDERS;
--------------------
--��������(subquery)
SELECT *
  FROM CUSTOMER
 WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
--------------------
--�ܺ�����(OUTER JOIN)
SELECT DISTINCT C.*
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
;
---------
--LEFT OUTER JOIN
SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID(+)
   AND O.ORDERID IS NULL
;  
----------------------
--����(JOIN, INNER JOIN, ��������) : �������̺� ��ο� �����ϴ� ����Ÿ �˻�
--�ܺ�����(OUTER JOIN) :  ��� �� �� ���̺� ����Ÿ�� �������� �ʴ� ����Ÿ �˻�
----��� ����Ÿ�� ǥ���ϰ�, ��ġ���� �ʴ� ����Ÿ�� ���� ��ȸ ó���� �� ��� 
-------------------
CREATE TABLE DEPT (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT VALUES ('10', '�ѹ���');
INSERT INTO DEPT VALUES ('20', '�޿���');
INSERT INTO DEPT VALUES ('30', 'IT��');
COMMIT;
--------
CREATE TABLE DEPT1 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT1 VALUES ('10', '�ѹ���');
INSERT INTO DEPT1 VALUES ('20', '�޿���');
COMMIT;
------
CREATE TABLE DEPT2 (
    ID VARCHAR2(10) PRIMARY KEY,
    NAME VARCHAR2(30)
);
INSERT INTO DEPT2 VALUES ('10', '�ѹ���');
INSERT INTO DEPT2 VALUES ('30', 'IT��');
COMMIT;
--------------------
SELECT * FROM DEPT;
SELECT * FROM DEPT1;
SELECT * FROM DEPT2;
----------
--DEPT = DEPT1
SELECT *
  FROM DEPT D, DEPT1 D1
 WHERE D.ID = D1.ID
;
---
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID
;
-----------------------------
--DEPT1���� �ְ�, DEPT2���� ���� �μ� ��ȸ
--LEFT OUTER JOIN : ���� ���̺� ���� ��ü ����Ÿ ǥ���ϰ� ������ ������ NULLǥ��
SELECT *
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID(+)
;
SELECT D1.*
  FROM DEPT1 D1, DEPT2 D2
 WHERE D1.ID = D2.ID(+)
   AND D2.ID IS NULL
;
--============
--ANSI : ǥ�� SQL (INNER JOIN)
SELECT *
  FROM DEPT1 D1
       INNER JOIN DEPT2 D2
       ON D1.ID = D2.ID
;   
-----
--LEFT OUTER JOIN : ���� ���̺� ���� ������ ���� ����Ÿ�� ��ȸ
SELECT *
  FROM DEPT1 D1
       LEFT OUTER JOIN DEPT2 D2
       ON D1.ID = D2.ID
 WHERE D2.ID IS NULL
;
--=======================
--DEPT2 ���̺��� �ְ� DEPT1 ���̺� ���� ����Ÿ ��ȸ
--RIGHT OUTER JOIN : ���� ���̺� ���� ��ü ����Ÿ ǥ���ϰ� ������ ������ NULL ǥ��
SELECT *
  FROM DEPT1 D1
       RIGHT OUTER JOIN DEPT2 D2 --�������̺�� ���� ����
       ON D1.ID = D2.ID --��������
;
---
--ORACLE(����Ŭ) : OUTER JOIN ��� ��� 
--�������̺��� �ƴ� ���̺� (+)��ȣ�� ���(����Ÿ�� ���� ���̺�)
SELECT *
  FROM DEPT1 D1, DEPT2 D2 --
 WHERE D1.ID(+) = D2.ID
   AND D1.ID IS NULL
;
--------------------
--FULL OUTER JOIN : ���� ���̺� �ִ� ����Ÿ�� ��� ǥ��(������ NULL)
--ANSI ǥ�� FULL OUTER JOIN �� ���
SELECT *
  FROM DEPT1 D1
       FULL OUTER JOIN DEPT2 D2
       ON D1.ID = D2.ID
;    












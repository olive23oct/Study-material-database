/*** �׷��Լ� : �ϳ� �̻��� ���� �׷����� ��� ����
COUNT(*): ����Ÿ ���� ��ȸ(* : ��ü�÷� �������)
COUNT(�÷���) : ����Ÿ ���� ��ȸ(������ �÷��� ���Ͽ�)
SUM(�÷�) : �հ� �� ���ϱ�
AVG(�÷�) : ��� �� ���ϱ�
MAX(�÷�) : �ִ� �� ���ϱ�
MIN(�÷�) : �ּ� �� ���ϱ�
**************************/
SELECT * FROM BOOK;
SELECT COUNT(*) FROM BOOK;

SELECT COUNT(*) FROM CUSTOMER; --����Ÿ 5�� ��ȸ
SELECT COUNT(NAME) FROM CUSTOMER; --5��
SELECT COUNT(PHONE) FROM CUSTOMER; --4�� ��ȸ : NULL�� ���� ���ܵ�
-------
--SUM(�÷�) : �÷��� �հ踦 ���� ��
SELECT * FROM BOOK;
SELECT SUM(PRICE) FROM BOOK; --144500
SELECT SUM(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('���ѹ̵��', '�̻�̵��');

--AVG(�÷�) : �÷��� ��� �� ���� ��
SELECT AVG(PRICE) FROM BOOK; --14450
SELECT AVG(PRICE) FROM BOOK
 WHERE PUBLISHER IN ('���ѹ̵��', '�̻�̵��');

--MAX(�÷�) : �÷� �� �߿� ���� ū �� ��ȸ
--MIN(�÷�) : �÷� �� �߿� ���� ���� �� ��ȸ
SELECT * FROM BOOK ORDER BY PRICE DESC;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK;
SELECT MAX(PRICE), MIN(PRICE) FROM BOOK
 WHERE PUBLISHER = '�½�����'
;
SELECT COUNT(*), SUM(PRICE), AVG(PRICE), MAX(PRICE), MIN(PRICE)
  FROM BOOK;
---------------------------------
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID : 1
SELECT * FROM ORDERS;
--(�ǽ�)
--1. �������� �ѱ��ž�(�������� ����ȣ(CUSTID = 1))
SELECT '������' AS NAME, SUM(SALEPRICE) SUMPRICE 
  FROM ORDERS WHERE CUSTID = 1;
SELECT '������' AS NAME, SUM(SALEPRICE) SUMPRICE 
  FROM ORDERS WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '������');  

--2. �������� ������ ������ ��
SELECT '������ ���ŰǼ�', COUNT(*) FROM ORDERS
 WHERE CUSTID = 1;

--3. ���� '��'���� ���� �̸��� �ּ�
SELECT NAME, ADDRESS
  FROM CUSTOMER
 WHERE NAME LIKE '��%'
;
--4. ���� '��'���̰� �̸��� '��'���� ������ ���� �̸��� �ּ�
SELECT NAME, ADDRESS
  FROM CUSTOMER
 WHERE NAME LIKE '��%��'
;





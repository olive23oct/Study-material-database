--��������(�μ�����, subquery)
--SQL��(SELECT, INSERT, UPDATE, DELETE) ���� �ִ� ������
--------------------------
--�������� ������ ������ �˻�
SELECT * FROM ORDERS;
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID : 1
SELECT * FROM ORDERS
 WHERE CUSTID = 1;
--�������� ���
SELECT * FROM ORDERS
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '������');
--���ι����� ó��
SELECT C.NAME, O.*
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND C.NAME = '������'
;
----
--WHERE ������ �������� ���� ��ȸ�Ǵ� ����Ÿ�� 2�� �̻��� ��� IN ���
SELECT * FROM ORDERS
 WHERE CUSTID IN (SELECT CUSTID 
                   FROM CUSTOMER 
                  WHERE NAME IN ('������', '�迬��'));
--------------------
--������ ���� ��� ������ �̸��� ���Ͻÿ�.
SELECT MAX(PRICE) FROM BOOK; --���� ��� ������ ���� : 35000
SELECT * FROM BOOK
 WHERE PRICE = 35000;
--
SELECT * FROM BOOK
 WHERE PRICE = (SELECT MAX(PRICE) FROM BOOK);
-------------------
--���������� FROM���� ����ϴ� ���
SELECT *
  FROM BOOK B,
       (SELECT MAX(PRICE) MAX_PRICE FROM BOOK) M
 WHERE B.PRICE = M.MAX_PRICE;
---
SELECT *
  FROM (SELECT * FROM CUSTOMER WHERE NAME IN ('������', '�迬��')) C,
       ORDERS O
 WHERE C.CUSTID = O.CUSTID
;
---
SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME IN ('������', '�迬��')
;
----------------------------
--SELECT ���� �������� ��뿹
SELECT O.ORDERID, O.CUSTID, O.BOOKID,
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) CUSTNAME, --����
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) BOOKNAME, --å����,
       O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O
;
--------------------
--�������� ������ å ���(å����)
--�� ����SQL --> �߰�SQL -> �� �ٱ��� SQL�� ����
SELECT BOOKID, BOOKNAME
  FROM BOOK
 WHERE BOOKID IN (SELECT BOOKID
                    FROM ORDERS
                   WHERE CUSTID IN (SELECT CUSTID 
                                     FROM CUSTOMER 
                                    WHERE NAME = '������')
                 )
;                   
------------------------------
--�ǽ�(�������� �̿�)
--1. �� ���̶� ������ ������ �ִ� ���(��������, ���ι�)
---- (�Ǵ� �� ���� �������� ���� ���)
--2. 20000�� �̻�Ǵ� å�� ������ �� ��� ��ȸ(��������, ���ι�)
--3. '���ѹ̵��' ���ǻ��� ������ ������ ���̸� ��ȸ(��������, ���ι�)
--4. ��ü å���� ��պ��� ��� å�� ��� ��ȸ(��������, ���ι�)
--------------
--1. �� ���̶� ������ ������ �ִ� ���(��������, ���ι�)
SELECT CUSTID FROM ORDERS;
SELECT * FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS); --�� ���̶� ������ ���
---- (�Ǵ� �� ���� �������� ���� ���)
SELECT * FROM CUSTOMER
 WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS)
;
--- JOIN��
SELECT DISTINCT C.* --DISTINCT �ߺ�����Ÿ�� �ϳ��� ǥ��
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
;
----JOIN�� (�Ǵ� �� ���� �������� ���� ���)
SELECT DISTINCT C.* --DISTINCT �ߺ�����Ÿ�� �ϳ��� ǥ��
--SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID(+)
   AND O.ORDERID IS NULL
;
------------------------
--2. 20000�� �̻�Ǵ� å�� ������ �� ��� ��ȸ(��������, ���ι�)
SELECT CUSTID FROM ORDERS WHERE SALEPRICE >= 20000; --2���� �̻� ������ ���
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID FROM ORDERS 
                   WHERE SALEPRICE >= 20000)
;
-----
--JOIN��
SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND O.SALEPRICE >= 20000
;
SELECT *
  FROM CUSTOMER C, 
       (SELECT CUSTID FROM ORDERS WHERE SALEPRICE >= 20000) O
 WHERE C.CUSTID = O.CUSTID
;
--------------
--3. '���ѹ̵��' ���ǻ��� ������ ������ ���̸� ��ȸ(��������, ���ι�)
SELECT * 
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT CUSTID
                    FROM ORDERS
                   WHERE BOOKID IN (SELECT BOOKID
                                      FROM BOOK
                                     WHERE PUBLISHER = '���ѹ̵��')
                 )
;
---JOIN��
SELECT C.*
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND O.BOOKID = B.BOOKID
   AND B.PUBLISHER = '���ѹ̵��'
;
SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
   AND O.BOOKID = B.BOOKID
   AND B.PUBLISHER LIKE '%�̵��'
;

SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
--------------
--4. ��ü å���� ��պ��� ��� å�� ��� ��ȸ(��������, ���ι�)
SELECT AVG(PRICE) FROM BOOK; --��ձݾ�
SELECT * FROM BOOK
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK);

--JOIN��
SELECT *
  FROM BOOK B
     , (SELECT AVG(PRICE) AVG_PRICE FROM BOOK) AVG
 WHERE B.PRICE > AVG.AVG_PRICE
;










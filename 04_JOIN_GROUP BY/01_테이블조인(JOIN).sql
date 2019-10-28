SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
------------------------
--�������� ������ å�� �ݾ��հ�
SELECT CUSTID FROM CUSTOMER WHERE NAME = '������'; --CUSTID : 1
SELECT * FROM ORDERS WHERE CUSTID = 1;
SELECT SUM(SALEPRICE) FROM ORDERS WHERE CUSTID = 1;
--��������(sub query)���
SELECT SUM(SALEPRICE) FROM ORDERS 
 WHERE CUSTID = (SELECT CUSTID FROM CUSTOMER WHERE NAME = '������');
------------------------
--���̺� ����(join) ���
SELECT * FROM CUSTOMER WHERE CUSTID = 1;
SELECT * FROM ORDERS WHERE CUSTID = 1;
SELECT *
  FROM CUSTOMER, ORDERS --������ ���̺�
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --���ν� ��� ����
;
--�������� ������ ���
SELECT SUM(SALEPRICE)
--SELECT *
  FROM CUSTOMER, ORDERS --������ ���̺�
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --���ν� ��� ����
   AND NAME = '������'
;
--------------------
--���ε� ����Ÿ���� �÷� ��ȸ�� : ���̺��.�÷��� ���·� ���
SELECT CUSTOMER.CUSTID, CUSTOMER.NAME, CUSTOMER.ADDRESS,
       ORDERS.CUSTID AS ORD_CUSTID, ORDERS.SALEPRICE
  FROM CUSTOMER, ORDERS --���� ��� ���̺�
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --���� ����
   AND CUSTOMER.NAME = '������' --�˻�����(WHERE)
;
-----
--�÷����� Ư�� ���̺� �����ϰ� �����ϸ� ���̺�� ���� ����
SELECT CUSTOMER.CUSTID, NAME, ADDRESS,
       ORDERS.CUSTID AS ORD_CUSTID, SALEPRICE
  FROM CUSTOMER, ORDERS --���� ��� ���̺�
 WHERE CUSTOMER.CUSTID = ORDERS.CUSTID --���� ����
   AND NAME = '������' --�˻�����(WHERE)
;
--============================
--���̺� ��Ī(alias) �ο� ��� ����(��Ī ���� ���̺�� ��� ����)
SELECT C.CUSTID, C.NAME, C.ADDRESS, 
       O.SALEPRICE
  FROM CUSTOMER C, ORDERS O --���̺� ��Ī �ο�
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '������'
;
----------------------------------
SELECT * FROM BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;
-----
SELECT O.ORDERID, O.BOOKID, B.BOOKNAME, B.PRICE, B.PUBLISHER,
       O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
   --AND BOOKNAME LIKE '%�౸%'
   AND B.PUBLISHER LIKE '%�̵��'
 ORDER BY B.PUBLISHER, O.SALEPRICE DESC
;
-- ===============================================
--(�����ذ�) ���̺� ������ ���ؼ� �����ذ�(�ȵǸ� ���� SELECT������ �ܰ�������)
--�ǽ� : '�߱��� ��Ź��'��� å�� �� ���� �ȷȴ��� Ȯ�����ּ���.
--�ǽ� : '�߱��� ��Ź��'��� å�� �ȸ� ��¥�� ���ϼ���(å����, �Ǹ�����)
------
--�ǽ� : '�߽ż�'�� ������ å���� �������� Ȯ��(å��, ����(�Ǹ�)����)
--�ǽ� : '�߽ż�'�� ������ �հ�ݾ� ���ϼ���
--=====================================================
--�ǽ� : '�߱��� ��Ź��'��� å�� �� ���� �ȷȴ��� Ȯ�����ּ���.
SELECT BOOKID FROM BOOK WHERE BOOKNAME = '�߱��� ��Ź��'; --BOOKID : 8
SELECT COUNT(*) FROM ORDERS WHERE BOOKID = 8;

SELECT '�߱��� ��Ź�� �ǸŰǼ�', COUNT(*)
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;
SELECT COUNT(*) AS "BASEBALL COUNTS"
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;

--�ǽ� : '�߱��� ��Ź��'��� å�� �ȸ� ��¥�� ���ϼ���(å����, �Ǹ�����)
SELECT B.BOOKNAME, O.ORDERDATE
  FROM BOOK B, ORDERS O
 WHERE B.BOOKID = O.BOOKID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;
------------------
--�ǽ� : '�߽ż�'�� ������ å���� �������� Ȯ��(å��, ����(�Ǹ�)����)
SELECT C.NAME, O.SALEPRICE, O.ORDERDATE
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '�߽ż�'
;
--�ǽ� : '�߽ż�'�� ������ �հ�ݾ� ���ϼ���
SELECT '�߽ű� ���Աݾ�', SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME = '�߽ż�'
;
--==========================================
SELECT *
  FROM BOOK B, ORDERS O --���� ���̺� �ۼ�
 WHERE B.BOOKID = O.BOOKID --���� ���� �ۼ�
   AND B.BOOKNAME LIKE '�౸%' --WHERE���� �˻�����
;
------------------
--3�� ���̺� ����
SELECT O.ORDERID, C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O, CUSTOMER C --���� ���̺�
 WHERE B.BOOKID = O.BOOKID --�������� B = O
   AND O.CUSTID = C.CUSTID --�������� O = C
 ORDER BY O.ORDERID
;
----
SELECT O.ORDERID, C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
  FROM BOOK B, ORDERS O, CUSTOMER C --���� ���̺�
 WHERE O.BOOKID = B.BOOKID --�������� O = B
   AND O.CUSTID = C.CUSTID --�������� O = C
 ORDER BY O.ORDERID
;
-------------------------------
--3�����̺����� : ����, å����, �ǸŰ���, �Ǹ�����, ���ǻ��
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
;
---------
--(�ǽ�)��̶��� ������ å����, ���԰���, ��������, ���ǻ�
----��̶� : CUSTOMER
----����(�Ǹ�)�� : ORDERS
----å���� : BOOK
----����׸� : å����, ���԰���, ��������, ���ǻ�
----�˻����� : ��̶�
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE, B.PUBLISHER
  FROM ORDERS O, BOOK B, CUSTOMER C --�������̺�
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID --��������
   AND C.NAME = '��̶�'
;
----------------
--(�ǽ�)��̶��� ������ å �߿� 2014-01-01 ~ 2014-07-08 ���� ������ ����
SELECT *
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
   AND C.NAME = '��̶�'
   AND O.ORDERDATE BETWEEN TO_DATE('2014-01-01', 'YYYY-MM-DD')
                       AND TO_DATE('2014-07-08', 'YYYY-MM-DD')
;
SELECT *
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
   AND C.NAME = '��̶�'
   AND O.ORDERDATE >= TO_DATE('2014-01-01', 'YYYY-MM-DD')
   AND O.ORDERDATE < TO_DATE('2014-07-09', 'YYYY-MM-DD')
;
--==================================
--(�ǽ�)'�߱��� ��Ź��'��� å(BOOK)�� ������(ORDERS) ���(CUSTOMER)��
----  �������ڸ� ���ϼ���.
--(�ǽ�)'�߽ż�', '��̶�'�� ������ å����, ���Աݾ�, �������ڸ� Ȯ��
----  (���� : ����, �������� ������)
-------------------------------------
SELECT B.BOOKNAME, C.NAME, O.ORDERDATE
--SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE B.BOOKID = O.BOOKID AND O.CUSTID = C.CUSTID
   AND B.BOOKNAME = '�߱��� ��Ź��'
;

--(�ǽ�)'�߽ż�', '��̶�'�� ������ å����, ���Աݾ�, �������ڸ� Ȯ��
----  (���� : ����, �������� ������)
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
--SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
   AND C.NAME IN ('�߽ż�', '��̶�')
 ORDER BY C.NAME, O.ORDERDATE   
;
-----
SELECT C.NAME, B.BOOKNAME, O.SALEPRICE, O.ORDERDATE
--SELECT *
  FROM BOOK B, ORDERS O, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID
   AND O.CUSTID = C.CUSTID
   AND (C.NAME = '�߽ż�' OR C.NAME = '��̶�')
 ORDER BY C.NAME, O.ORDERDATE   
;
---==============================
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE), 
       ROUND(AVG(O.SALEPRICE), 2),
       MAX(O.SALEPRICE), MIN(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
;






















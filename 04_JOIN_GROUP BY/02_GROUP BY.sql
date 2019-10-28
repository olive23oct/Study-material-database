/* ************************
SELECT [* | DISTINCT ]{�÷���,�÷���,...}
  FROM ���̺��
[WHERE ������]
[GROUP BY {�÷���,...}]
[HAVING ����]  --GROUP BY ���� ���� ����
[ORDER BY {�÷��� [ASC | DESC],... }] --ASC : ��������(�⺻/��������)
                                     --DESC : ��������
***************************/
--GROUP BY : ����Ÿ�� �׷����ؼ� ó���� ��� ���
--GROUP BY ���� ����ϸ� SELECT �׸��� GROUP BY ���� ���� �÷�
---- �Ǵ� �׷��Լ�(COUNT, SUM, AVG, MAX, MIN)�� ����� �� �ִ�
-----------------------------

--���Ű����� ���űݾ� �հ踦 ���Ͻÿ�
SELECT CUSTID, SUM(SALEPRICE)
--SELECT *
  FROM ORDERS
 GROUP BY CUSTID
;
------------
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
;
---
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY SUM(O.SALEPRICE) DESC
;
-----------
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 ORDER BY 2 DESC
;
-------------------------
--�ֹ�(�Ǹ�)���̺��� ���� ����Ÿ ��ȸ(�Ǽ�, �հ�, ���, �ּ�, �ִ�ݾ�)
SELECT CUSTID, COUNT(*), SUM(SALEPRICE), 
       TRUNC(AVG(SALEPRICE)), 
       MIN(SALEPRICE), MAX(SALEPRICE)
  FROM ORDERS
 GROUP BY CUSTID
;
SELECT CUSTID, COUNT(*), SUM(SALEPRICE), TRUNC(AVG(SALEPRICE)), MIN(SALEPRICE), MAX(SALEPRICE) FROM ORDERS GROUP BY CUSTID
;
SELECT CUSTID, COUNT(*), SUM(SALEPRICE), 
       TRUNC(AVG(SALEPRICE)), MIN(SALEPRICE), 
       MAX(SALEPRICE) FROM ORDERS GROUP BY CUSTID
;
SELECT CUSTID, COUNT(*), SUM(SALEPRICE), 
       TRUNC(AVG(SALEPRICE)), MIN(SALEPRICE), 
       MAX(SALEPRICE) 
FROM ORDERS 
GROUP BY CUSTID
;

--(�ǽ�)���� �������� ���� ����Ÿ ��ȸ(�Ǽ�, �հ�, ���, �ּ�, �ִ�ݾ�)
----�߽ż�, ��̶� 2�� ��ȸ
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE)
     , TRUNC(AVG(O.SALEPRICE))
     , MIN(O.SALEPRICE)
     , MAX(O.SALEPRICE)
--SELECT *     
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND C.NAME IN ('�߽ż�', '��̶�')
 GROUP BY C.NAME
;
-------------------------------
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE)
     , TRUNC(AVG(O.SALEPRICE))
     , MIN(O.SALEPRICE)
     , MAX(O.SALEPRICE)
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING C.NAME IN ('�߽ż�', '��̶�')
;
-----------------------------------------
--HAVING �� : GROUP BY �� ���� ������� ����Ÿ���� �˻������� �ο�
--HAVING ���� �ܵ����� ���� �� ���� �ݵ�� GROUP BY ���� �Բ� ���
-------------------
--3�� �̻� ������ ���� ��ȸ(�Ǽ�, �հ�, ���, �ּ�, �ִ�ݾ�)
SELECT C.NAME
     , COUNT(*), SUM(O.SALEPRICE)
     , TRUNC(AVG(O.SALEPRICE))
     , MIN(O.SALEPRICE)
     , MAX(O.SALEPRICE)
--SELECT *     
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING COUNT(*) >= 3
;
-----------------
--������ å�߿� 20000�� �̻��� å�� ������ ����� ��赥��Ÿ
----(�Ǽ�, �հ�, ���, �ּ�, �ִ�ݾ�)
SELECT C.NAME
     , COUNT(*), SUM(O.SALEPRICE)
     , TRUNC(AVG(O.SALEPRICE))
     , MIN(O.SALEPRICE)
     , MAX(O.SALEPRICE)
--SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING MAX(O.SALEPRICE) >= 20000 --�׷��ε� ����Ÿ���� ���ǰ˻�
;
--------
--���� : WHERE���� ���Ǵ� ���ǰ˻�(���̺� ����Ÿ ����)
---- HAVIGN������ �˻��ϴ� ������(�׷��ε� ����Ÿ ������ �˻�)
---- �����Ÿ�� �ٸ���.
SELECT C.NAME
     , COUNT(*), SUM(O.SALEPRICE)
     , TRUNC(AVG(O.SALEPRICE))
     , MIN(O.SALEPRICE)
     , MAX(O.SALEPRICE)
--SELECT *
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
   AND O.SALEPRICE >= 20000 --���ε� ���̺��� ���ǰ˻�
 GROUP BY C.NAME
;
--------------------------------------
--1. ���� �ֹ��� ������ ���ǸŰǼ�, �Ǹž�, ��հ�, ������, �ְ� ���ϱ�
--2. ������ �ֹ��� ������ �Ѽ���, ���Ǹž� ���Ͻÿ�
--3. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
--4. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, �������� ����
--5. ������ �ֹ��� �Ǽ�, �հ�ݾ�, ��ձݾ� ���ϰ�(3�Ǻ��� ���� ������ ��� �˻�)
-------------------------------------
--1. ���� �ֹ��� ������ ���ǸŰǼ�, �Ǹž�, ��հ�, ������, �ְ� ���ϱ�
SELECT COUNT(*) AS "TOTAL COUNT",
       SUM(SALEPRICE) AS "�Ǹž� �հ�",
       AVG(SALEPRICE) "��հ�",
       MIN(SALEPRICE) "������",
       MAX(SALEPRICE) "�ְ�"     
  FROM ORDERS
;
--2. ������ �ֹ��� ������ �Ѽ���, ���Ǹž� ���Ͻÿ� 
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 --ORDER BY SUM(O.SALEPRICE) DESC
 ORDER BY 3 DESC
;

--3. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
SELECT C.NAME, B.BOOKNAME, B.PRICE, O.SALEPRICE, O.ORDERDATE
--SELECT *
  FROM CUSTOMER C, ORDERS O, BOOK B
 WHERE C.CUSTID = O.CUSTID AND O.BOOKID = B.BOOKID
 ORDER BY C.NAME
;
--4. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, �������� ����
SELECT C.NAME, SUM(O.SALEPRICE)
  FROM ORDERS O, CUSTOMER C
 WHERE O.CUSTID = C.CUSTID
 GROUP BY C.NAME
 ORDER BY C.NAME
;
--5. ������ �ֹ��� �Ǽ�, �հ�ݾ�, ��ձݾ� ���ϰ�(3�Ǻ��� ���� ������ ��� �˻�)
SELECT C.NAME, COUNT(*), SUM(O.SALEPRICE), TRUNC(AVG(O.SALEPRICE))
  FROM CUSTOMER C, ORDERS O
 WHERE C.CUSTID = O.CUSTID
 GROUP BY C.NAME
 HAVING COUNT(*) < 3
;
--(����) �� �� �� �ǵ� ���� ���� ����� ������?






















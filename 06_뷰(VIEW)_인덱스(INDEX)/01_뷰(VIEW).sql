/* ************************
��(VIEW) : �ѳ� �Ǵ� �� �̻��� ���̺�� ����
   ����Ÿ�� �κ������� ���̺��� ��ó�� ����ϴ� ��ü(�������̺�)
--��(VIEW) ������
CREATE VIEW ���̸� [(�÷���Ī1, �÷���Ī2, ..., �÷���Īn)]
AS
SELECT ����
[�ɼ�];

--�б����� �ɼ� : WITH READ ONLY

--��(VIEW) ����
DROP VIEW ���̸�;
***************************/
SELECT O.*, B.BOOKNAME, C.NAME
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
   AND C.NAME = '������'
;
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';
SELECT * FROM ORDERS;
--============================
CREATE VIEW VW_BOOK
AS
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';
----
SELECT * FROM VW_BOOK;
----------------------
SELECT *
  FROM VW_BOOK
 WHERE PUBLISHER = '�½�����';
-- 
SELECT *
  FROM (SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%')
 WHERE PUBLISHER = '�½�����';
--------------------------------------
--��(VIEW) ���� - �÷���Ī(alias) ���
CREATE VIEW VW_BOOK2
(BID, BNAME, PUB, PRICE)
AS
SELECT * FROM BOOK WHERE BOOKNAME LIKE '%�౸%';
--------
CREATE VIEW VW_BOOK3
(BNAME, PUB, PRICE)
AS
SELECT BOOKNAME, PUBLISHER, PRICE
  FROM BOOK 
 WHERE BOOKNAME LIKE '%�౸%';
----
SELECT * FROM VW_BOOK3;
--==========================
CREATE VIEW VW_ORDERS
AS
SELECT O.ORDERID, B.BOOKNAME, B.PUBLISHER, 
       C.NAME, C.PHONE,
       B.PRICE, O.SALEPRICE, O.ORDERDATE
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
 ORDER BY O.ORDERID
;
--DROP VIEW VW_ORDERS; --�����
-------------
--�� Ȱ��
SELECT * FROM VW_ORDERS WHERE NAME = '������';
SELECT * FROM VW_ORDERS WHERE NAME IN ('�迬��', '��̶�')
 ORDER BY PUBLISHER;
SELECT * FROM VW_ORDERS WHERE SALEPRICE >= 20000; 
--===================================================
--(�ǽ�) �並 ����, ��ȸ, ����
--1. ����� - ���Ī : VW_ORD_ALL
---- �ֹ�(�Ǹ�)����, å����, �������� ��� ��ȸ�� �� �ִ� ������ ��
--2. �̻�̵��� �����ؼ� �Ǹŵ� å����, �Ǹűݾ�, �Ǹ��� ��ȸ
--3. �̻�̵�� ���ǻ��� å �߿��� �߽ż�, ��̶��� ������ å ���� ��ȸ
---- ����׸� : ������ ����̸�, å����, ���ǻ�, ����, �ǸŰ�, �Ǹ�����
---- ���� : ������ ����̸�, �������� �ֱ� ��
--4. �Ǹŵ� å�� ���Ͽ� �����ں� �Ǽ�, �հ�ݾ�, ��ձݾ�, �ְ�, ������ ��ȸ
--(����) ����� : VW_ORD_ALL ���� ó��
-------------------
CREATE OR REPLACE VIEW VW_ORD_ALL
AS
SELECT O.*
     , B.BOOKNAME, B.PUBLISHER, B.PRICE
     , C.NAME, C.PHONE, C.ADDRESS
  FROM ORDERS O, BOOK B, CUSTOMER C
 WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
 ORDER BY O.ORDERID
;
--2. �̻�̵��� �����ؼ� �Ǹŵ� å����, �Ǹűݾ�, �Ǹ��� ��ȸ
SELECT BOOKNAME, SALEPRICE, ORDERDATE
  FROM VW_ORD_ALL
 WHERE PUBLISHER = '�̻�̵��'
;  
SELECT BOOKNAME, SALEPRICE, ORDERDATE
  FROM (SELECT O.*
             , B.BOOKNAME, B.PUBLISHER, B.PRICE
             , C.NAME, C.PHONE, C.ADDRESS
          FROM ORDERS O, BOOK B, CUSTOMER C
         WHERE O.BOOKID = B.BOOKID AND O.CUSTID = C.CUSTID
         ORDER BY O.ORDERID)
 WHERE PUBLISHER = '�̻�̵��'
; 

--3. �̻�̵�� ���ǻ��� å �߿��� �߽ż�, ��̶��� ������ å ���� ��ȸ
---- ����׸� : ������ ����̸�, å����, ���ǻ�, ����, �ǸŰ�, �Ǹ�����
---- ���� : ������ ����̸�, �������� �ֱ� ��
SELECT NAME, BOOKNAME, PUBLISHER, PRICE, SALEPRICE, ORDERDATE
  FROM VW_ORD_ALL
 WHERE PUBLISHER = '�̻�̵��'
   AND NAME IN ('�߽ż�', '��̶�')
 ORDER BY NAME, ORDERDATE DESC
;
--4. �Ǹŵ� å�� ���Ͽ� �����ں� �Ǽ�, �հ�ݾ�, ��ձݾ�, �ְ�, ������ ��ȸ
SELECT NAME, SUM(SALEPRICE), ROUND(AVG(SALEPRICE), -2)
     , MAX(SALEPRICE), MIN(SALEPRICE)
  FROM VW_ORD_ALL
 GROUP BY NAME
;
--(����) ����� : VW_ORD_ALL ���� ó��
DROP VIEW VW_ORD_ALL;
--=========================
--�信 ��Ī ����
----�÷��� : ID -> MID, NAME -> MNAME
CREATE OR REPLACE VIEW T_LIKE 
    (MID, MNAME)
AS 
SELECT ID, NAME 
FROM TEST_LIKE;

SELECT * FROM T_LIKE;
--DELETE FROM TEST_LIKE WHERE ID = 6;

SELECT * 
  FROM (SELECT ID AS MID, NAME AS MNAME
        FROM TEST_LIKE)
;
----------------------------
CREATE OR REPLACE FORCE VIEW AAA
AS
SELECT ID, NAME, PHONE FROM AAA;
-----------------------
DELETE FROM T_LIKE WHERE MID = 8;
COMMIT;

DELETE FROM T_LIKE WHERE ID = 9;









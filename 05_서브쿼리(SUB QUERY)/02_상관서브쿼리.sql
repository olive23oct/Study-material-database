--�����������(���������� ���������� ���εǾ� ����)
--------------------
--���ǻ纰�� ���ǻ纰 ��� �������ݺ��� ��� ���� ����� ���Ͻÿ�
SELECT * FROM BOOK;
----�½����� ���ǻ� å�߿��� �½����� ���ǻ� å�� ��� �ݾ׺��� ��� ����
SELECT * FROM BOOK WHERE PUBLISHER = '�½�����';
SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = '�½�����'; --7000

SELECT *
  FROM BOOK B
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = '�½�����')
   AND B.PUBLISHER = '�½�����'
;
--����������� : ���� SELECT���� ����Ÿ�� �ϳ� ó���� ������ �������̺��� ����
--    ���ؼ� �������� ������ ����Ǵ� ���·� ó��
SELECT *
  FROM BOOK B
 WHERE PRICE > (SELECT AVG(PRICE) FROM BOOK WHERE PUBLISHER = B.PUBLISHER)
;
-----------------
--JOIN��
--���ǻ纰 ��� ���� ����
SELECT PUBLISHER, AVG(PRICE)
  FROM BOOK
 GROUP BY PUBLISHER
;
-------
SELECT *
  FROM BOOK B,
       (SELECT PUBLISHER, AVG(PRICE) AVG_PRICE
          FROM BOOK
         GROUP BY PUBLISHER
       ) AVG
 WHERE B.PUBLISHER = AVG.PUBLISHER
   AND B.PRICE >= avg.avg_price
;
----------------------------------
--SELECT ���� ���� �����������
SELECT O.*,
       (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) ����,
       (SELECT BOOKNAME FROM BOOK WHERE BOOKID = O.BOOKID) ������
  FROM ORDERS O
;
--------------------------
--EXISTS : ���翩�� Ȯ�ν� ���(������ true)
--NOT EXISTS : �������� ���� �� ture
SELECT *
  FROM BOOK
 WHERE BOOKNAME IN (SELECT BOOKNAME 
                      FROM BOOK
                     WHERE BOOKNAME LIKE '%�౸%')
; 
------
SELECT B.* --BOOKNAME, '����Ÿ ����'
  FROM BOOK B
 WHERE EXISTS (SELECT 1
                 FROM BOOK
                WHERE B.BOOKNAME LIKE '%�౸%')
;
--�ֹ������� �ִ� ���� �̸��� ��ȭ��ȣ�� ã���ÿ�.
SELECT *
  FROM CUSTOMER
 WHERE CUSTID IN (SELECT DISTINCT CUSTID FROM ORDERS)
;
-- ===> EXISTS ����
SELECT *
  FROM CUSTOMER C
 WHERE EXISTS (SELECT 1
                 FROM ORDERS
                WHERE CUSTID = C.CUSTID)
;  
--NOT EXISTS
SELECT *
  FROM CUSTOMER C
 WHERE NOT EXISTS (SELECT 1
                 FROM ORDERS
                WHERE CUSTID = C.CUSTID)
;  
--=============================




/* ***** �Լ�(FUNCTION) ******
���� �� ���� ���� �ִ� ���α׷�
--������ ����Ÿ�� ���� ���� �ʿ�
RETURN ����Ÿ����
-- ���α׷� �������� �� ���Ϲ��� �ʿ�
RETURN ���ϰ�;
*****************************/
--�Ķ���� ������ BOOKID ���� �ް�, å����(BOOKNAME)�� �����޴� �Լ�
CREATE OR REPLACE FUNCTION GET_BOOKNAME (
    IN_ID IN NUMBER -- IN Ű���� ��������
) RETURN VARCHAR2 --������ ����Ÿ Ÿ��
AS
    V_BOOKNAME book.bookname%TYPE;
BEGIN
    SELECT BOOKNAME INTO V_BOOKNAME
    FROM BOOK
    WHERE BOOKID = IN_ID;
    
    RETURN V_BOOKNAME; --���ϰ� ����
END;
-------------
--�Լ��� ���
SELECT BOOKID, BOOKNAME, GET_BOOKNAME(BOOKID)
  FROM BOOK;
------
SELECT O.*, GET_BOOKNAME(BOOKID)
  FROM ORDERS O;
-------------
SELECT * FROM BOOK
 WHERE GET_BOOKNAME(BOOKID) = '�౸�� ����';
----
SELECT * FROM ORDERS
 WHERE GET_BOOKNAME(BOOKID) = '�౸�� ����'
;
-----------------------
--(�ǽ�) ��ID ���� ���޹޾�, ������ �����ִ� �Լ� �ۼ�(CUSTOMER ���̺� ����)
--�Լ��� : GET_CUSTNAME
--�Լ��� �ۼ��� �Ŀ� ORDERS ���̺��� ����Ÿ�� ��ȸ
----GET_BOOKNAME, GET_CUSTNAME �Լ���� �ֹ�(�Ǹ�)������ å����, ���� ��ȸ
-------------------------
SELECT O.*
     , (SELECT NAME FROM CUSTOMER WHERE CUSTID = O.CUSTID) AS CUSTNAME
  FROM ORDERS O
;
SELECT C.*
     , (SELECT count(SALEPRICE) FROM ORDERS WHERE CUSTID = C.CUSTID) AS "���԰Ǽ�"     
     , (SELECT NVL(SUM(SALEPRICE),0) FROM ORDERS WHERE CUSTID = C.CUSTID) AS "�������ѱݾ�"
  FROM CUSTOMER C
;













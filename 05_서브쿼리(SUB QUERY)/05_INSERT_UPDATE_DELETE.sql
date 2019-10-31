--INSERT, UPDATE, DELETE
/* **************************** 
-- INSERT ��
INSERT INTO ���̺��
       (�÷���1, �÷���2, ..., �÷���n)
VALUES (��1, ��2, ... , ��n);  
*********************************/
SELECT * FROM BOOK;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (30, '�ڹٶ� �����ΰ�', 'ITBOOK', 30000);       
COMMIT;
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER, PRICE)
VALUES (31, '�ڹٶ� �����ΰ�2', 'ITBOOK', 30000);
COMMIT;
-----------
--�÷����� �������� �ʴ� ���
----���̺� ������ �ۼ��� �÷��� ���� ��� �ۼ�(������ ������ ���� �߻�)
----���̺� ������ ���� �÷��� ������ ���� ����Ÿ �Է�(��Ű�� ������ ���� ����)
------------
INSERT INTO BOOK
VALUES (32, '�ڹٶ� �����ΰ�3', 'ITBOOK', 30000);

INSERT INTO BOOK
VALUES (33, '�ڹٶ� �����ΰ�4', '', 30000);
SELECT * FROM BOOK;

INSERT INTO BOOK
VALUES (34, 'ITBOOK', '�ڹٶ� �����ΰ�4', 30000);
------------
SELECT * FROM BOOK ORDER BY BOOKID DESC;
--��������� �÷����� ����ϸ�, �÷����� ��ġ�� ���� ���� ��Ī�Ǿ� �Էµ�
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PUBLISHER)
VALUES (35, '�ڹٶ� �����ΰ�5', 'ITBOOK'); 
--
INSERT INTO BOOK
       (BOOKID, BOOKNAME, PRICE, PUBLISHER)
VALUES (36, '�ڹٶ� �����ΰ�6', 35000, 'ITBOOK');
--------------------------
--�ϰ��Է� : ���̺��� ����Ÿ�� �̿��ؼ� ���� ����Ÿ�� �ѹ��� �Է�ó��
----IMPORTED_BOOK -> BOOK : �ϰ��Է�
INSERT INTO BOOK
SELECT BOOKID, BOOKNAME, PUBLISHER, PRICE
  FROM IMPORTED_BOOK
;
SELECT * FROM BOOK ORDER BY BOOKID DESC;
SELECT * FROM IMPORTED_BOOK;
--==================================
/* *********************************
--UPDATE��
UPDATE ���̺��
   SET �÷���1 = ��1, �÷���2 = ��2, ..., �÷���n = ��n
 [WHERE ������� ]
*********************************/
SELECT * FROM CUSTOMER;
--�ڼ����� �ּ� : '���ѹα� ����' -> '���ѹα� �λ�'
UPDATE CUSTOMER
   SET ADDRESS = '���ѹα� �λ�'
 WHERE NAME = '�ڼ���'
;
--�ڼ����� �ּ�, ��ȭ��ȣ ���� : '���ѹα� ����', '010-1111-2222'
UPDATE CUSTOMER
   SET ADDRESS = '���ѹα� ����',
       PHONE = '010-1111-2222'
 WHERE NAME = '�ڼ���'
;
COMMIT;
SELECT * FROM CUSTOMER WHERE NAME = '�ڼ���';
------------------
--�ڼ����� �ּ� ���� : �迬���� �ּҿ� �����ϰ� ����
SELECT ADDRESS FROM CUSTOMER WHERE NAME = '�迬��';
--
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER WHERE NAME = '�迬��')
 WHERE NAME = '�ڼ���'
;
SELECT * FROM CUSTOMER WHERE NAME = '�ڼ���';
SELECT ADDRESS FROM CUSTOMER WHERE NAME = '�迬��';
------------------
--�ڼ����� �ּ�, ��ȭ��ȣ ���� : �߽ż� ������ �����ϰ�
UPDATE CUSTOMER
   SET ADDRESS = (SELECT ADDRESS FROM CUSTOMER WHERE NAME = '�߽ż�'),
       PHONE = (SELECT PHONE FROM CUSTOMER WHERE NAME = '�߽ż�')
 WHERE NAME = '�ڼ���'
; 
--====================
/* ************************
-- DELETE ��
DELETE FROM ���̺��
 WHERE �������;
***************************/
SELECT * FROM BOOK;
SELECT * FROM TEST_LIKE;
--DELETE FROM TEST_LIKE WHERE NAME = 'ȫ�浿';
SELECT * FROM TEST_LIKE WHERE NAME LIKE 'ȫ�浿%';
/*
DELETE FROM TEST_LIKE 
WHERE NAME LIKE 'ȫ�浿%';
*/
SELECT * FROM TEST_LIKE;
COMMIT;
-----------------
SELECT * FROM BOOK
--DELETE FROM BOOK
 WHERE BOOKNAME LIKE '�ڹ�%' OR BOOKNAME = 'ITBOOK';

SELECT * FROM BOOK
--DELETE FROM BOOK
WHERE BOOKID >= 30;





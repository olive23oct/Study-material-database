/* *********************************
<�ε��� - INDEX>
���̺� �ִ� ����Ÿ(�ο�, ���ڵ�)�� ������ ã�� ���� ������� ����Ÿ ����
- �ڵ��ε��� : PRIMARY KEY ����� �Ǵ� UNIQUE �������� ������ �����Ǵ� �ε���
- �����ε��� : CREATE INDEX ��ɹ��� ����ؼ� ����� �ε���

<�ε��� ������ �������>
-�ε����� WHERE���� ���� ���Ǵ� �÷��� ����
-�������ǿ� ���� ���Ǵ� �÷��� ����
-���� ���̺� �ε����� �ʹ� ���Ƶ� �ӵ� ���� ���� �߻�(���̺�� 4~5����)
-�÷��� ����Ÿ�� ����(�Է�,����,����)�Ǵ� ��찡 ������ �������
-�÷��� ����Ÿ �������� ���� �� ȿ�� ����

<�ε��� ���� ����>
CREATE INDEX �ε����� ON ���̺�� (�÷���1[, �÷���2, ..., �÷���n]);
CREATE [UNIQUE] INDEX ON ���̺�� (�÷���1 [ASC|DESC], �÷���2, .., �÷���n);

<�ε��� ���� ����>
DROP INDEX �ε�����;

<�ε��� �籸�� ����>
ALTER INDEX �ε����� REBUILD;
ALTER [UNIQUE] INDEX �ε����� [ON ���̺�� (�÷���, ...)] REBUILD;
************************************/
--�ε��� ���� : BOOK ���̺��� ���ǻ�(PUBLISHER) �÷��� IX_BOOK �ε��� �����
CREATE INDEX IX_BOOK ON BOOK (PUBLISHER);
SELECT * FROM BOOK ORDER BY PUBLISHER;
SELECT * FROM BOOK WHERE PUBLISHER = '�½�����';
SELECT * FROM BOOK WHERE BOOKNAME = '�౸�� ����';

--�ε��� ���� : 2�� �÷� ����
--BOOK ���̺��� PUBLISHER, PRICE �÷��� ������� IX_BOOK2 �ε��� ����
CREATE INDEX IX_BOOK2 ON BOOK (PUBLISHER, PRICE);
SELECT PUBLISHER, PRICE FROM BOOK ORDER BY PUBLISHER, PRICE;

--WHERE ���� �ε����� ������� �÷����� ��ȸ�� �� �ε����� ����
SELECT * FROM BOOK WHERE PUBLISHER = '�½�����' AND PRICE = 8000;
--WHERE ���� �񱳼����� �ٲ� �ε����� ����� �� ������ ����ؼ� ó��
SELECT * FROM BOOK WHERE PRICE = 8000 AND PUBLISHER = '�½�����';

DROP INDEX IX_BOOK; 
--IX_BOOK ���� ó�� ��
SELECT * FROM BOOK WHERE PUBLISHER = '�½�����'; --IX_BOOK2 �ε��� ����
SELECT * FROM BOOK WHERE PRICE = 8000; --�ε������� ���� FULL SCAN

--�����˻� : �ε��� ����
SELECT * FROM BOOK WHERE PUBLISHER BETWEEN '�½�����' AND '���ѹ̵��';

--LIKE ���� ���� �ε��� ���뿩��
SELECT * FROM BOOK WHERE PUBLISHER LIKE '����%'; --�ε��� ����
SELECT * FROM BOOK WHERE PUBLISHER LIKE '%�̵��';--�ε��� ������
SELECT * FROM BOOK WHERE PUBLISHER LIKE '%����%';--�ε��� ������
--------------------
--���� ����Ÿ�� ����ó�� �ϴ� ���� �ε��� ������ �� ����
SELECT * FROM BOOK WHERE SUBSTR(PUBLISHER,1,2) = '����';

--=======================================================
/* *** �ε��� �ǽ� ****************************
���缭�� �����ͺ��̽����� ���� SQL ���� �����ϰ� 
�����ͺ��̽��� �ε����� ����ϴ� ������ Ȯ���Ͻÿ�.
(1) ���� SQL ���� �����غ���.
	SELECT name FROM Customer WHERE name LIKE '�ڼ���';
(2) ���� ��ȹ�� ���캻��. ���� ��ȹ�� [F10]Ű�� ���� �� 
    [��ȹ ����]���� �����ϸ� ǥ�õȴ�.
(3) Customer ���̺� name���� �ε���(ix_customber_name)�� �����Ͻÿ�. 
    ���� �� (1)���� ���Ǹ� �ٽ� �����ϰ� ���� ��ȹ�� ���캸�ÿ�.
(4) ���� ���ǿ� ���� �� ���� ���� ��ȹ�� ���غ��ÿ�.
(5) (3)������ ������ �ε����� �����Ͻÿ�.
******************************************/
SELECT name FROM Customer WHERE name LIKE '�ڼ���';
CREATE INDEX ix_customber_name ON Customer (name);
SELECT name, CUSTID FROM Customer ORDER BY NAME;
DROP INDEX ix_cust_name;








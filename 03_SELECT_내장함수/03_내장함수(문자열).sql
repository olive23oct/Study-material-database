/******************************* 
����Ŭ�� �����Լ� - ���ڿ�, ����, ��¥ ���� �Լ�
<���ڿ� ���� �����Լ�>
UPPER : �빮�ڷ� ����
LOWER : �ҹ��ڷ� ����
INITCAP : ù ���ڸ� �빮�ڷ� �������� �ҹ���
LENGTH : ���ڿ��� ����(���ڴ���)
LENGTHB : ���ڿ��� ����(BYTE ����)
SUBSTR(���, ������ġ, ����) : ���ڿ��� �Ϻ� ����
   (������ġ�� 1���� ����, �����ʿ��� �����ϴ� ��� ���̳ʽ�(-)�� ���)
INSTR(���, ã�¹���) : ����ڿ��� ã�¹��� ��ġ�� ����
INSTR(���, ã�¹���, ������ġ)
INSTR(���, ã�¹���, ������ġ, nth) : nth ã������ ������(3 : 3��° ã�� ��)
TRIM('���ڿ�') : ���� ���� ����
LTRIM('���ڿ�') : ���ʿ� �ִ� ���� ����
RTRIM('���ڿ�') : �����ʿ� �ִ� ���� ����
CONCAT(���ڿ�1, ���ڿ�2) : ���ڿ� ���� - ���ڿ�1 || ���ڿ�2
LPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : ���ʿ� ����
RPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : �����ʿ� ����
REPLACE(����ڿ�, ã������, ���湮��) : ���ڿ����� ã�����ڸ� ����
********************************/
SELECT * FROM DUAL; --����Ŭ���� �����ϴ� �������̺� �ӽ� �۾��� �� ���
SELECT 1234 * 1234 FROM DUAL;

--UPPER : �빮�ڷ� ����
--LOWER : �ҹ��ڷ� ����
--INITCAP : ù ���ڸ� �빮�ڷ� �������� �ҹ���
SELECT BOOKNAME, UPPER(BOOKNAME) FROM BOOK;
SELECT UPPER('Olympic Champions') FROM DUAL;
SELECT LOWER('Olympic Champions') FROM DUAL;
SELECT INITCAP('OLYMPIC CHAMPIONS') FROM DUAL;
SELECT INITCAP('olymPIC CHAMPpions') FROM DUAL;

SELECT * FROM BOOK WHERE UPPER(BOOKNAME) LIKE 'OLYMPIC%'; 
SELECT * FROM BOOK WHERE LOWER(BOOKNAME) LIKE 'olympic%';
SELECT * FROM BOOK WHERE INITCAP(BOOKNAME) LIKE 'Olympic%';
----------------
--TRIM('���ڿ�') : ���� ���� ����
--LTRIM('���ڿ�') : ���ʿ� �ִ� ���� ����
--RTRIM('���ڿ�') : �����ʿ� �ִ� ���� ����
SELECT '-'||'   TEST   '||'-', '-'||TRIM('   TEST   ')||'-' FROM DUAL;
SELECT '   TEST   ', LTRIM('   TEST   ') FROM DUAL;
SELECT '   TEST   ', RTRIM('   TEST   ') FROM DUAL;
---------------------
--CONCAT(���ڿ�1, ���ڿ�2) : ���ڿ� ���� - ���ڿ�1 || ���ڿ�2
SELECT CONCAT('HELLO ', 'WORLD!!!') FROM DUAL;
SELECT 'HELLO ' || 'WORLD!!!' FROM DUAL;
-----------------------
--LPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : ���ʿ� ����
--RPAD(����ڿ�, ��ü���ڼ�, ���Եɹ���) : �����ʿ� ����
SELECT LPAD('OLYMPIC', 5) FROM DUAL; --�ڸ������� ��ġ�� ũ�⸸ŭ�� ǥ��
SELECT LPAD('OLYMPIC', 10) FROM DUAL; --���ڿ��� �����ϸ� ������ ��ĭ ä��
SELECT LPAD('OLYMPIC', 10, '*') FROM DUAL;

SELECT RPAD('OLYMPIC', 5) FROM DUAL; --LPAD�� ����
SELECT RPAD('OLYMPIC', 10) FROM DUAL;
SELECT RPAD('OLYMPIC', 10, '*') FROM DUAL;
SELECT RPAD('OLYMPIC', 16, '*-') FROM DUAL;
------------------------
--LENGTH : ���ڿ��� ����(���ڴ���)
--LENGTHB : ���ڿ��� ����(BYTE ����)
SELECT LENGTH('ABCDE123') FROM DUAL; --���ڴ��� 8����
SELECT LENGTHB('ABCDE123') FROM DUAL; --BYTE ����

SELECT LENGTH('ȫ�浿123') FROM DUAL; --���ڴ��� 6����
SELECT LENGTHB('ȫ�浿123') FROM DUAL; --BYTE ���� ���� : UTF-8 �ѱ� 3 BYTE
-------------------------
--SUBSTR(���, ������ġ, ����) : ���ڿ��� �Ϻ� ����
--   (������ġ�� 1���� ����, �����ʿ��� �����ϴ� ��� ���̳ʽ�(-)�� ���)
SELECT SUBSTR('ȫ�浿123', 1, 3) FROM DUAL; --ù���ں��� 3��
SELECT SUBSTR('ȫ�浿123', -3, 3) FROM DUAL; --�ǵ�(��)���� 3��° �����ؼ� 3��
SELECT SUBSTR('ȫ�浿12345', 4) FROM DUAL; --������ġ���� ������
SELECT SUBSTR('ȫ�浿12345', -5) FROM DUAL;
----------------------------------
--INSTR(���, ã�¹���) : ����ڿ��� ã�¹��� ��ġ�� ����
--INSTR(���, ã�¹���, ������ġ)
--INSTR(���, ã�¹���, ������ġ, nth) : nth ã������ ������(3 : 3��° ã�� ��)
SELECT INSTR('900101-1234567', '-') FROM DUAL; --��ġ�� 7
SELECT INSTR('900101-1234567', '*') FROM DUAL; --������ 0
SELECT INSTR('900101-1234567', '34') FROM DUAL;
SELECT INSTR('900101-1234567', '1', 7) FROM DUAL;
SELECT INSTR('900101-1234567', '1', 1, 3) FROM DUAL;
-----------------------------
--REPLACE(����ڿ�, ã������, ���湮��) : ���ڿ����� ã�����ڸ� ����
SELECT 'HELLO JAVA', REPLACE('HELLO JAVA', 'A', 'O') FROM DUAL;
SELECT 'HELLO JAVA', REPLACE('HELLO JAVA', 'JAVA', 'WORLD!!!') FROM DUAL;







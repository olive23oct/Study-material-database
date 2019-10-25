/* *************************
����Ÿ ���Ǿ�
- DDL(Data Definition Language) : ����Ÿ�� �����ϴ� ���
- CREATE(����), DROP(����), ALTER(����)
- {}�ݺ�����, []��������, | �Ǵ�(����)
CREATE TABLE ���̺�� (
{�÷��� ����ŸŸ��
    [NOT NULL | UNIQUE | DEFAULT �⺻�� | CHECK üũ����]
}
    [PRIMARY KEY �÷���]
    {[FOREIGN KEY �÷��� REFERENCES ���̺��(�÷���)]
    [ON DELETE [CASCADE | SET NULL]
    }
);
--------
�÷��� �⺻ ����Ÿ Ÿ��
VARCHAR2(n) : ���ڿ� ��������
CHAR(n) : ���ڿ� ��������
NUMBER(p, s) : ����Ÿ�� p:��ü����, s:�Ҽ������� �ڸ���
  ��) (5,2) : ������ 3�ڸ�, �Ҽ��� 2�ڸ� - ��ü 5�ڸ�
DATE : ��¥�� ��,��,�� �ð� �� ����

���ڿ� ó�� : UTF-8 ���·� ����
- ����, ���ĺ� ����, Ư������ : 1 byte ó��(Ű���� ���� ���ڵ�)
- �ѱ� : 3 byte ó��
***************************/
CREATE TABLE  MEMBER (
    ID VARCHAR2(20) PRIMARY KEY, --UNIQUE + NOT NULL
    NAME VARCHAR2(30) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(20),
    ADDRESS VARCHAR2(200)
);
--�Է� : hong, ȫ�浿, 1234 ����Ÿ �Է�
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('hong', 'ȫ�浿', '1234');
COMMIT;

INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('hong2', 'ȫ�浿2', '1234');

INSERT INTO MEMBER (ID, NAME)
VALUES ('hong2', 'ȫ�浿'); --cannot insert NULL into ("MYSTUDY"."MEMBER"."PASSWORD")

--�Է� : hong3, 'ȫ�浿3', '1234' 
--����Ÿ �Է��ϰ� ��ü ����Ÿ ��ȸ
INSERT INTO MEMBER (ID, NAME, PASSWORD)
VALUES ('hong3', 'ȫ�浿3', '1234');
SELECT * FROM MEMBER;
--=====================================
--�Է½� �÷��� ��������� ���� �ʰ� INSERT �� ���
--���̺� �ִ� ��� �÷��� ���Ͽ� ������� ����Ÿ �Է��ؾ� ��
INSERT INTO MEMBER
VALUES ('hong4', 'ȫ�浿4', '1234', '010-1111-1111', '�����');

INSERT INTO MEMBER
VALUES ('hong5', 'ȫ�浿5', '1234', '�����', '010-1111-1111');

INSERT INTO MEMBER (ID, NAME, PASSWORD, ADDRESS, PHONE)
VALUES ('hong6', 'ȫ�浿6', '1234', '�����', '010-1111-1111');

--================================
-- �÷��� ����Ÿ Ÿ�Ժ� Ư�� Ȯ���ϱ�
CREATE TABLE TEST (
    NUM NUMBER(5,2), --��ü�ڸ��� 5�ڸ� : ������ 3�ڸ�, �Ҽ��� 2�ڸ�
    STR1 VARCHAR2(10), --��������
    STR2 CHAR(10), --��������
    DATE1 DATE --��¥ ���������� ����Ͻú��� ����Ÿ ��� ������ ����
);
SELECT 100 + 50 FROM DUAL; --DUAL : ����Ŭ���� �����ϴ� DUMMY���̺�
SELECT * FROM DUAL;

SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

-----
SELECT * FROM TEST;
INSERT INTO TEST VALUES (100.456, 'ABC', 'ABC', SYSDATE);
INSERT INTO TEST VALUES (100.454, 'ABC', 'ABC', SYSDATE);
INSERT INTO TEST VALUES (100.454, 'DEF  ', 'DEF', SYSDATE);
SELECT '-' || STR1 || '-', '-'||STR2||'-' FROM TEST;
--- ����Ÿ ��ȸ
SELECT * FROM TEST WHERE STR1 = STR2; --��ȸ�� ����Ÿ ����
SELECT * FROM TEST WHERE STR2 = 'ABC'; --����Ŭ������ ��ȸ��
--'ABC' ���ڿ� �� 'ABC       '
SELECT * FROM TEST WHERE STR2 = 'ABC       '; --��� DB ����
-------------------
SELECT * FROM TEST WHERE NUM = 100.45; -- NUMBERŸ�� = NUMBERŸ��
SELECT * FROM TEST WHERE NUM = '100.45'; --NUMBER = ���� : ����Ŭ���� ��ȸ��
SELECT * FROM TEST WHERE NUM = '100.45A'; --ORA-01722: invalid number
----
INSERT INTO TEST (STR1, STR2) VALUES ('1234567890', '1234567890');
SELECT * FROM TEST WHERE STR1 = STR2; 
SELECT '-' || STR1 || '-', '-'||STR2||'-' FROM TEST;
INSERT INTO TEST (STR1, STR2) VALUES ('12345678  ', '12345678');
SELECT * FROM TEST WHERE STR1 = STR2; 
SELECT '-' || STR1 || '-', '-'||STR2||'-' FROM TEST;
-----------------
--UTF-8 Ÿ������ ����Ÿ ���� : �ѱ� 1���ڴ� 3 ����Ʈ(BYTE) ũ��� ó����
SELECT * FROM TEST;
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', 'ABCDEFGHIJ');
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', '���ѹα�'); --�ѱ� 4���� * 3 = 12����Ʈ
INSERT INTO TEST (STR1, STR2) VALUES ('ABCDEFGHIJ', 'ȫ�浿'); --�ѱ� 3���� * 3 = 9 ����Ʈ

--======================================
-- NULL (��) : ���ڿ�('')�� �ƴϰ�, Ư�� ���� �ƴ� ����Ÿ�� ���� ����
-- NULL�� ��ó���� �ȵ� : =, !=, <>, >, <, >=, <= ��ó���� �ǹ� ����
-- NULL ���� ���� ��� �׻� NULL(������ �ǹ̵� ����)
-- NULL ���� ���� ��ȸ�� IS NULL, IS NOT NULL �������� ��ȸ
SELECT * FROM TEST WHERE NUM = NULL; --��ȸ ����Ÿ ����(��ȸ�ȵ�)
SELECT * FROM TEST WHERE NUM IS NULL;
SELECT * FROM TEST WHERE NUM <> NULL; --��ȸ �ȵ�
SELECT * FROM TEST WHERE NUM IS NOT NULL;

-- NULL���� ������ �׻� NULL
SELECT NUM, NUM + 10 FROM TEST;
SELECT NUM, NUM + NULL FROM TEST; --NUM���� �������� �׻� NULL

SELECT * FROM TEST;
SELECT 100.46 + NULL FROM DUAL;
-------------
-- ���Ľ� NULL
SELECT * FROM TEST ORDER BY STR1; --STR1 �÷� �������� ��������(ASC) ����
SELECT * FROM TEST ORDER BY STR1 ASC; --���� ���Ϲ���(ASC Ű���� ����)
SELECT * FROM TEST ORDER BY STR1 DESC; --�������� ����

SELECT * FROM TEST ORDER BY NUM; --�������� ����(���� �� ���� ū ���� ���߿�)
-- ����Ŭ������ NULL ���� ���� ū ������ ó��(�������� �� �� ������ ���)
SELECT * FROM TEST ORDER BY NUM DESC;

--�ʿ信 ���� NULL���� ���� ǥ���ϰų�, ���߿� ǥ���� ��
-- NULLS FIRST, NULLS LAST
SELECT * FROM TEST ORDER BY NUM;
SELECT * FROM TEST ORDER BY NUM DESC;
SELECT * FROM TEST ORDER BY NUM NULLS FIRST; 
SELECT * FROM TEST ORDER BY NUM DESC NULLS LAST;
--------------------
SELECT NUM, NUM + 10, NUM + 100 FROM TEST;
-- ����Ÿ���� �÷��� NULL�� ������ 0���� ó���ؼ� ��� ó��
-- �����Լ� NVL(�÷�, ������) : �÷����� NULL�̸� ���������� ��ü(��ȯ) 
SELECT NUM, NUM + 10, NVL(NUM, 0) + 100 FROM TEST;
------------------
SELECT * FROM TEST;
INSERT INTO TEST (NUM, STR1, STR2) VALUES (200, '', NULL);
SELECT * FROM TEST WHERE STR1 = ''; 
SELECT STR1, STR1||'-�׽�Ʈ', NVL(STR1, '�������') || '-�׽�Ʈ'
  FROM TEST;
-- ===========================
/* (�ǽ�) ���̺�� : TEST2
    NO : ����Ÿ�� 5�ڸ�, PRIMARY KEY ����
    ID : ����Ÿ�� 10�ڸ�(����10�ڸ�), ���� �ݵ�� ����
    NAME : �ѱ� 10�ڸ� ���尡����� ����, ���� �ݵ�� ����
    EMAIL : ����, ����, Ư������ ���� 30�ڸ� 
    ADDRESS : �ѱ� 100�ڸ�
    IDNUM : ����Ÿ�� ������ 7�ڸ�, �Ҽ��� 3�ڸ�(1234567.789)
    REGDATE : ��¥Ÿ��
*****************************/




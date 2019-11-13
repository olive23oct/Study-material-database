--�񱳱��� : IF��
--IF (���ǽ�) THEN ~ END IF;
--IF (���ǽ�) THEN ~ ELSE ~ END IF;
--IF (���ǽ�) THEN ~ ELSIF ~ ELSIF ~ ELSIF ~ END IF;
create or replace PROCEDURE PRC_IF (
    IN_NUM NUMBER
) AS
    V_STR VARCHAR2(1000) := ' >> ';
BEGIN
    --¦��, Ȧ�� �Ǻ�
    IF (MOD(IN_NUM, 2) = 0) THEN
        --DBMS_OUTPUT.PUT_LINE(IN_NUM || ' >> ' || '¦���Դϴ�');
        V_STR := V_STR || '¦��';
    ELSE
        --DBMS_OUTPUT.PUT_LINE(IN_NUM || ' >> ' || 'Ȧ���Դϴ�');
        V_STR := V_STR || 'Ȧ��';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(IN_NUM || V_STR || '�Դϴ�');
END;
---------------------------
create or replace PROCEDURE PRC_IF2 (
    IN_NUM NUMBER
) AS
    V_STR VARCHAR2(1000) := ' >> ';
BEGIN
    --¦��, Ȧ�� �Ǻ�
    IF (MOD(IN_NUM, 2) = 0) THEN
        V_STR := V_STR || '¦��';
    ELSE
        V_STR := V_STR || 'Ȧ��';
    END IF;
    DBMS_OUTPUT.PUT_LINE(IN_NUM || V_STR ||'�Դϴ�');

    --4�� ���� ������ �� Ȯ��
    IF (MOD(IN_NUM, 4) = 0) THEN
        V_STR := V_STR || ', 4�� ���� ������ 0'; 
    ELSIF (MOD(IN_NUM, 4) = 1) THEN
        V_STR := V_STR || ', 4�� ���� ������ 1'; 
    ELSIF (MOD(IN_NUM, 4) = 2) THEN
        V_STR := V_STR || ', 4�� ���� ������ 2'; 
    ELSE
        V_STR := V_STR || ', 4�� ���� ������ 3';
    END IF;

    DBMS_OUTPUT.PUT_LINE(IN_NUM || V_STR);
END;

--===========================================
--�ݺ��� : FOR, WHILE
--FOR��
--���ڸ� �ϳ� �Է� �޾Ƽ� �հ����(1~N ������ ��)
create or replace PROCEDURE PRC_FOR_SUM (
    IN_NUM NUMBER
) AS
    V_SUM NUMBER := 0; --���� �ʱⰪ ����
    --I NUMBER := 0;
BEGIN
    --�Է¹��� ���ڱ����� �հ豸�ϱ�(1~N ������ ��)
    DBMS_OUTPUT.PUT('1 ���� '|| IN_NUM ||'������ ��: ');

    --FOR������ �ݺ� ó��
    --FOR ���� IN �ʱⰪ..������ LOOP ~ END LOOP;
    FOR I IN 1..IN_NUM LOOP
        V_SUM := V_SUM + I;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(V_SUM);
END;

--==================
--WHILE ��
--WHILE (���ǽ�) LOOP ~ END LOOP;
-------------------
--���ڸ� �ϳ� �Է� �޾Ƽ� �հ����(1~N ������ ��)
create or replace PROCEDURE PRC_WHILE_SUM (
    IN_NUM NUMBER
) IS
    V_SUM NUMBER := 0;
    I NUMBER := 1;
BEGIN
    --�Է¹��� ���ڱ����� �հ豸�ϱ�(1~N ������ ��)
    DBMS_OUTPUT.PUT('1 ���� '|| IN_NUM ||'������ ��: ');

    --WHILE��
    WHILE (I <= IN_NUM) LOOP
        V_SUM := V_SUM + I;
        I := I + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(V_SUM);
END;

--======================
--(�ǽ�) ���ڸ� �ϳ� �Է� �޾Ƽ� 0���� ���ڰ����� �հ� ���ϱ�
--���ν����� : PRC_SUM_EVENODD
--�Է°��� Ȧ���� Ȧ������ ���ϰ�,
--�Է°��� ¦���� ¦������ ���ؼ�
--���� ����� ȭ�鿡 ���
--�������
---- �Է¼���: �Է¹��� ��, Ȧ��/¦��, �հ�: �հ�����
---- ��¿�) �Է¼���: 4, ¦��, �հ�: 6
------------------------------


























/*
    <JOIN>
    �� �� �̻��� ���̺����� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
    ��ȸ ����� �ϳ��� �����(RESULT SET)�� ����
    
    ������ �����ͺ��̽������� �ּ����� �����͸� ������ ���̺��� ��� ����
    (�ߺ������� �ּ�ȭ�ϱ� ���ؼ� �ִ��� �ɰ��� ������)
    
    => ������ �����ͺ��̽����� SQL���� �̿��� ���̺� �� "����"�� �δ� ���
    (������ �� ��ȸ�� ���� ���� �ƴ϶� �� ���̺� �� �������(�ܷ�Ű)�� ���� �����͸� ��Ī���� ��ȸ�ؾ��Ѵ�.)
    
    JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI ����"(ANSI == �̱�����ǥ����ȸ)
    
    [�������]
                ����Ŭ���뱸��         |           ANSI����
    ----------------------------------------------------------------------------
                �����              |          ��������
            (EQUAL JOIN)            |       (INNER JOIN) => JOIN USING/ON
    ----------------------------------------------------------------------------
                ��������              |       ���� �ܺ� ����(LEFT OUTER JOIN)
            (LEFT OUTER)            |       ������ �ܺ� ����(RIGHT OUTER JOIN)
            (RIGHT OUTER)           |       ��ü �ܺ� ����(FULL OUTER JOIN)
    ----------------------------------------------------------------------------
            ��ü����(SELF JOIN)       |             JOIN ON
        �� ����(NON EQUAL JOIN)
    ----------------------------------------------------------------------------
*/

-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- �μ��� ��ȸ
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- ��ü ������� ���, �����, �����ڵ�, ���޸��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    1. �����(EQUAL JOIN)/ ��������(INNER JOIN)
    �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ��ȸ(== ��ġ�ϴ� ���� ���� ���� ��ȸ ����)
    
*/

--> ����Ŭ ���뱸��
-- FROM���� ��ȸ�ϰ��� �ϴ� ���̺��� ����(,�� ����)
-- WHERE���� ��Ī��ų �÷��� ���� ������ ����

-- 1) ������ �� �÷����� �ٸ� ���(EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
-- NULL, D3, D4, D7�����ʹ� ���� ���̺������� �����ϱ� ������ ���ܵ� �� �� �� �ִ�.
-- ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵ� ���� Ȯ���� �� �ִ�.

-- 2) ������ �� �÷����� ���� ���(EMPLOYEE : JOB_CODE / JOB : JOB_CODE)
-- ��ü ������� ���, �����, �����ڵ�, ���޸��� ��ȸ
SELECT EMP_ID, EMP_NAME, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-----------> ANSI ����
-- FROM���� ������ �Ǵ� ���̺� �ϳ� ���
-- JOIN���� ���� �����ϰ����ϴ� ���̺� ��� + ��Ī��ų �÷��� ���� ���ǵ� ���
-- JOIN USING / JOIN ON

-- 1) ������ �� �÷����� �ٸ� ���(EMPLOYEE : DEPT_CODE / DEPARTMENT : DEPT_ID)
-- JOIN ON
-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) ������ �� �÷����� ���� ���(EMPLOYEE : JOB_CODE / JOB : JOB_CODE)
-- ��ü ������� ���, �����, �����ڵ�, ���޸��� ��ȸ
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE);

SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB USING (JOB_CODE);
-- JOIN USING���� ��� �����ϴ� �÷����� ���� ���� ��� ����

-- �߰����� ���ǵ� ����
-- ������ �븮�� ����� ���, �����, ���޸�, �޿� ��ȸ
-- ����Ŭ ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '�븮';

-- ANSI ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '�븮';

---------------------------------------����--------------------------------------
-- 1. �μ��� �λ�������� ������� ���, �̸�, ���ʽ� ��ȸ
--> ����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.DEPT_TITLE = '�λ������';
--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

-- 2. DEPARTMENT�� LOCATION ���̺��� �����Ͽ� ��ü �μ��� �μ��ڵ�, �μ���, �����ڵ�, ������ ��ȸ
--> ����Ŭ
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE;
--> ANSI
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT D
JOIN LOCATION L ON (LOCATION_ID = LOCAL_CODE);

-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
--> ����Ŭ
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND BONUS IS NOT NULL;
--> ANSI
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;

-- 4. �μ��� �ѹ��ΰ� �ƴ� ������� �����, �޿� ��ȸ
--> ����Ŭ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.DEPT_TITLE != '�ѹ���';
--> ANSI
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '�ѹ���';

--------------------------------------------------------------------------------
/*
    2. �������� / �ܺ�����(OUTER JOIN)
    �� ���̺� ���� JOIN�� ��ġ���� �ʴ� �൵ ���Խ��� ��ȸ ����
    ��, �ݵ�� LEFT/RIGHT�� �����ؾߵȴ�. (���� ���̺��� ���ؾ��Ѵ�.)
*/
-- �����, �μ���, �޿�, ����
-- ����JOIN�� �μ� ��ġ�� ���� ���� 2���� ��� ������ �����ȴ�.
SELECT *
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 1) LEFT [OUTER] JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
-- ����Ŭ
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 2) RIGHT [OUTER] JOIN : �� ���̺� �� �������� ����� ���̺��� �������� JOIN
-- ����Ŭ
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 3) FULL [OUTER] JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� �ִ�(����ŬX)
-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

--------------------------------------------------------------------------------
/*
    3. �� ����(NON EQUAL JOIN)
    ��Ī��ų �÷��� ���� ���� �ۼ� �� '='�� ������� �ʴ� JOIN��
    ANSI�������δ� JOIN ON
*/

-- �����, �޿�, �޿�����
-- ����Ŭ
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ANSI
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY >= MIN_SAL AND SALARY <= MAX_SAL);

--------------------------------------------------------------------------------
/*
    4. ��ü����(SELF JOIN)
    ���� ���̺��� �ٽ� �� �� �����ϴ� ���
*/

-- ��ü ������� ������, �����, ����μ��ڵ�, --> EMPLOYEE E
--            ������, �����, ����μ��ڵ� --> EMPLOYEE M
--> ����Ŭ
SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE,
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

--> ANSI
SELECT E.EMP_ID AS "������", E.EMP_NAME AS "�����", E.DEPT_CODE,
       M.EMP_ID AS "������", M.EMP_NAME AS "�����", M.DEPT_CODE
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

--------------------------------------------------------------------------------
/*
    <��������>
    2�� �̻��� ���̺��� ������ JOIN�� ��
*/
-- ���, �����, �μ���, ���޸�
--> ����Ŭ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE;
--> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

-- ���, �����, �μ���, ������ ��ȸ
--> ����Ŭ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE;
--> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

------------------------------����-----------------------------------------------
-- 1. ���, �����, �μ���, ������, ������ ��ȸ
--> ����Ŭ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.LOCATION_ID = L.LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE;
--> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);

-- 2. ���, �����, �μ���, ���޸�, ������, ������, �޿���� ��ȸ
--> ����Ŭ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND D.LOCATION_ID = L.LOCAL_CODE
AND L.NATIONAL_CODE = N.NATIONAL_CODE
AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;
--> ANSI
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

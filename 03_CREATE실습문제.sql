--�ǽ����� --
--�������� ���α׷��� ����� ���� ���̺�� �����--
--�̶�, �������ǿ� �̸��� �ο��� ��
--   �� �÷��� �ּ��ޱ�
/*
    1. ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER)
    �÷� : PUB_NO(���ǻ� ��ȣ) - �⺻Ű(PUBLISHER_PK)
          PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
          PHONE(���ǻ� ��ȭ��ȣ) -- �������Ǿ���
*/
--���� 3������ ����
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(20) CONSTRAINT PUBLISHER_NN NOT NULL,
    PHONE VARCHAR2(13)
);

COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ� ��ȣ';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '���ǻ� ��ȭ��ȣ';

INSERT INTO TB_PUBLISHER VALUES(1, '����å�Ż��', '010-1111-1111');
INSERT INTO TB_PUBLISHER VALUES(2, 'õ�米��', '010-2222-2222');
INSERT INTO TB_PUBLISHER VALUES(3, '�����', '010-3333-3333');

SELECT * FROM TB_PUBLISHER;

/*
    2. �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
    �÷� : BK_NO(������ȣ)--�⺻Ű(BOOK_PK)
          BK_TITLE(������)--NOT NULL(BOOK__NN_TITLE)
          BK_AUTHOR(���ڸ�)--NOT NULL(BOOK__NN_AUTHOR)
          BK_PRICE(����)-- �������Ǿ���
          BK_PUB_NO(���ǻ� ��ȣ)--�ܷ�Ű(BOOK_FK)(TB_PUBLISHER���̺��� ����)
                                �̶� �����ϰ� �ִ� �θ����� ������ �ڽĵ����͵� ���� �ǵ��� �ɼ�����
                                
*/
--5�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(20) CONSTRAINT BOOK__NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(20) CONSTRAINT BOOK__NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER CONSTRAINT BOOK_FK REFERENCES TB_PUBLISHER(PUB_NO)
);

COMMENT ON COLUMN TB_BOOK.BK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '������';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '����';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '���ǻ� ��ȣ';

INSERT INTO TB_BOOK VALUES(11, '����', 'AA', '10000', 1);
INSERT INTO TB_BOOK VALUES(22, '����', 'BB', '15000', 2);
INSERT INTO TB_BOOK VALUES(33, '�ٴ�', 'CC', '20000', 3);
INSERT INTO TB_BOOK VALUES(44, '���', 'DD', '25000', 1);
INSERT INTO TB_BOOK VALUES(55, '����', 'EE', '30000', 3);

SELECT * FROM TB_BOOK;

/*
    3. ȸ���� ���� �����͸� ������� ȸ�� ���̺�(TB_MEMBER)
    �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
            MEMBER_ID(���̵�) -- �ߺ�����(MEMBER_UQ_ID)
            MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
            MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
            GENDER(����) -- M�Ǵ� F�� �Էµǵ��� ����(MEMBER_CK_GEN)
            ADDRESS(�ּ�) -- �������Ǿ���
            PHONE(����ó)-- �������Ǿ���
            STATUS(Ż�𿩺�) -- �⺻���� N���� ����, �׸��� N�Ǵ� Y�� �Էµǵ��� �������� ����(MEMBER_CK_STA)
            ENROLL_DATE(������) -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)
*/
--5�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ_ID UNIQUE,
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(10) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER CHAR(1) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(30),
    PHONE VARCHAR2(13),
    STATUS CHAR(1) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK(STATUS IN ('N', 'Y')),
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '���̵�';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN TB_MEMBER.STATUS IS 'Ż�𿩺�';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '������';

INSERT INTO TB_MEMBER VALUES(1, 'ID1', 'PWD1', 'ȸ��1', 'M', '�ּ�1', '010-1111-1111', 'N', DEFAULT);
INSERT INTO TB_MEMBER VALUES(2, 'ID2', 'PWD2', 'ȸ��2', 'F', '�ּ�2', '010-2222-2222', DEFAULT, TO_DATE('18/03/02', 'YY/MM/DD'));
INSERT INTO TB_MEMBER VALUES(3, 'ID3', 'PWD3', 'ȸ��3', 'F', '�ּ�3', '010-3333-3333', 'Y', TO_DATE('24/01/19', 'YY/MM/DD'));
INSERT INTO TB_MEMBER VALUES(4, 'ID4', 'PWD4', 'ȸ��4', 'M', '�ּ�4', '010-4444-4444', 'Y', SYSDATE);
INSERT INTO TB_MEMBER VALUES(5, 'ID5', 'PWD5', 'ȸ��5', 'F', '�ּ�5', '010-5555-5555', DEFAULT, TO_DATE('24/02/16', 'YY/MM/DD'));

SELECT * FROM TB_MEMBER;
/*
    4.� ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺�(TB_RENT)
    �÷��� : RENT_NO(�뿩��ȣ)-- �⺻Ű(RENT_PK)
            RENT_MEM_NO(�뿩ȸ����ȣ)-- �ܷ�Ű(RENT_FK_MEM) TB_MEMBER�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_BOOK_NO(�뿩������ȣ)-- �ܷ�Ű(RENT_FK_BOOK) TB_BOOK�� �����ϵ���
                                        �̶� �θ� ������ ������ �ڽĵ����� ���� NULL�� �ǵ��� ����
            RENT_DATE(�뿩��) -- �⺻�� SYSDATE
*/

--3�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,
    RENT_MEM_NO NUMBER CONSTRAINT RENT_FK_MEM REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE SET NULL,
    RENT_BOOK_NO NUMBER CONSTRAINT RENT_FK_BOOK REFERENCES TB_BOOK(BK_NO) ON DELETE SET NULL,
    REUT_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN TB_RENT.RENT_NO IS '�뿩��ȣ';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '�뿩ȸ����ȣ';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '�뿩������ȣ';
COMMENT ON COLUMN TB_RENT.REUT_DATE IS '�뿩��';

INSERT INTO TB_RENT VALUES(1, 1, 11, DEFAULT);
INSERT INTO TB_RENT VALUES(2, 2, 22, TO_DATE('24/02/16', 'YY/MM/DD'));
INSERT INTO TB_RENT VALUES(3, 3, 33, SYSDATE);

SELECT * FROM TB_RENT;
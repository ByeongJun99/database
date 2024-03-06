-- 한 줄 주석
/*
    여러 줄
    주석
*/

SELECT * FROM DBA_USERS; -- 현재 모든 계정들에 대해서 조회하는 명령문
-- 명령문 한 구문 실행(위쪽의 재생 버튼 클릭 | CTRL + ENTER)

-- 일반 사용자 계정을 생성하는 구문(오직 관리자 계정에서만 할 수 있다.)
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호
CREATE USER KH IDENTIFIED BY KH;

-- 위에서 생성된 일반 사용자 계정에 최소한의 권한(접속, 데이터 관리) 부여
-- [표현법] GRANT 권한1, 권한2... TO 계정명;
GRANT RESOURCE, CONNECT TO KH;
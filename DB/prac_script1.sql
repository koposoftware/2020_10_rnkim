-- 직원테이블 
/* 은행직원 */
drop table bank_emp;
CREATE TABLE SCOTT.BANK_EMP (
	EMPNO VARCHAR2(6) NOT NULL, /* 직원번호 */
	BRANCH_NM VARCHAR2(100) NOT NULL, /* 직원지점명 */
	ENAME VARCHAR2(20) NOT NULL, /* 직원이름 */
	DEPTNO VARCHAR2(3) NOT NULL /* 부서번호 */
);

COMMENT ON TABLE SCOTT.BANK_EMP IS '은행직원';

COMMENT ON COLUMN SCOTT.BANK_EMP.EMPNO IS '직원번호';

COMMENT ON COLUMN SCOTT.BANK_EMP.BRANCH_NO IS '지점번호';

COMMENT ON COLUMN SCOTT.BANK_EMP.ENAME IS '직원이름';

COMMENT ON COLUMN SCOTT.BANK_EMP.DEPTNO IS '부서번호';


ALTER TABLE SCOTT.BANK_EMP
	ADD
		CONSTRAINT PK_BANK_EMP
		PRIMARY KEY (
			EMPNO
		);


-- 직원 생성 함수 
    -- 1. 이름 랜덤 생성 함수 
drop function get_kornm;
CREATE OR REPLACE FUNCTION GET_KORNM 
( V_FROM IN VARCHAR2, V_TO IN VARCHAR2 ) 
RETURN VARCHAR2 
IS 
    OUT_REAL_NM     VARCHAR2(100); 
TYPE V_ARR IS TABLE OF VARCHAR2(10); 
V_FIRST V_ARR; 
V_LAST V_ARR; 
V_MID V_ARR; 
BEGIN 
V_LAST := V_ARR('김' , '이' , '박' , '최' , '정' , '강' , '조' , '윤' , '장' , '임' , '오' , '한' , '신' , '서' , '권' , '황' , '안' , '송' , '유' , '홍' , '전' , '고' , '문' , '손' , '양' , '배' , '조' , '백' , '허' , '남');
V_MID := V_ARR('민' , '현' , '동' , '인' , '지' , '현' , '재' , '우' , '건' , '준' , '승' , '영' , '성' , '진' , '준' , '정' , '수' , '광' , '영' , '호' , '중' , '훈' , '후' , '우' , '상' , '연' , '철' , '아' , '윤' , '은'); 
V_FIRST := V_ARR('유' , '자' , '도' , '성' , '상' , '남' , '식' , '일' , '철' , '병' , '혜' , '영' , '미' , '환' , '식' , '숙' , '자' , '희' , '순' , '진' , '서' , '빈' , '정' , '지' , '하' , '연' , '성' , '공' , '안' , '원');

SELECT SUBSTR(V_LAST(ROUND(DBMS_RANDOM.VALUE(1 , 30), 0)) || V_MID(ROUND(DBMS_RANDOM.VALUE(1 , 30), 0)) 
|| V_FIRST(ROUND(DBMS_RANDOM.VALUE(1 , 30), 0)) || V_MID(ROUND(DBMS_RANDOM.VALUE(1 , 30), 0)) 
|| V_FIRST(ROUND(DBMS_RANDOM.VALUE(1 , 30), 0)) ,V_FROM,V_TO) 
INTO OUT_REAL_NM FROM DUAL; RETURN OUT_REAL_NM; 
END;
/

    -- 2. 지점 랜덤 생성 함수 
CREATE OR REPLACE FUNCTION POP_WEIGHTED
RETURN CHAR
IS 
        REGION  CHAR(6);
BEGIN
WITH T AS
(
SELECT '서울' AS REG,  18.8 RATE FROM DUAL UNION ALL
SELECT '부산' , 6.6 RATE FROM DUAL UNION ALL
SELECT '대구' , 4.8 RATE FROM DUAL UNION ALL
SELECT '인천' , 5.7 RATE FROM DUAL UNION ALL
SELECT '광주' , 2.9 RATE FROM DUAL UNION ALL
SELECT '대전' , 2.9 RATE FROM DUAL UNION ALL
SELECT '울산' , 2.4 RATE FROM DUAL UNION ALL
SELECT '세종' , 0.7 RATE FROM DUAL UNION ALL
SELECT '경기' , 25.2 RATE FROM DUAL UNION ALL
SELECT '강원' , 3.0 RATE FROM DUAL UNION ALL
SELECT '충북' , 3.1 RATE FROM DUAL UNION ALL
SELECT '충남' , 4.1 RATE FROM DUAL UNION ALL
SELECT '전북' , 3.5 RATE FROM DUAL UNION ALL
SELECT '전남' , 3.5 RATE FROM DUAL UNION ALL
SELECT '경북' , 5.1 RATE FROM DUAL UNION ALL
SELECT '경남' , 6.5 RATE FROM DUAL UNION ALL
SELECT '제주' , 1.3 RATE FROM DUAL
)
SELECT REG INTO REGION FROM ( 
SELECT * FROM T A,
( SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 100) B
  WHERE RATE >= LV
  ORDER BY DBMS_RANDOM.VALUE
)
WHERE ROWNUM <= 1;
RETURN REGION;
END;
/

    -- 3. 부서번호 랜덤 생성
select trunc(dbms_random.value(0, 15)) deptno from dual;

    -- 4. 직원번호 시퀀스 생성
drop sequence seq_bank_emp_no;
create sequence seq_bank_emp_no nocache;

    -- 5. 반복문 돌며 insert
set serveroutput on;
begin 
    for i in 1..500 loop
        insert into bank_emp values(seq_bank_emp_no.nextval, pop_weighted(), get_kornm('1', '3'), 
                                (select trunc(dbms_random.value(100, 120))
                                from dual));
    end loop;
end;

select * from bank_emp;


-- 신청이 들어오면 바로 직원에게 할당하는 트리거 
drop trigger trg_put_emp;
create or replace trigger trg_put_emp 
before insert on loan_app
for each row
declare
    t_empno     bank_emp.empno%TYPE;
begin
    SELECT * into t_empno
    FROM
    (SELECT empno FROM bank_emp
    WHERE branch_nm = :NEW.branch_nm
    ORDER BY DBMS_RANDOM.VALUE
    ) WHERE ROWNUM <= 1;
    
    :NEW.empno := t_empno;
end;
/

-- 신청에 대출계좌가 '계좌 없음'이면 자동으로 계좌번호를 생성하는 트리거
drop trigger trg_random_acnt_no;
create or replace trigger trg_random_acnt_no
before insert on loan_app
for each row
declare
    t_random_acnt   varchar2(13);
begin
    -- 대출 계좌가 신규이면 랜덤한 수로 계좌번호를 만들고 acnt 테이블에 추가 후 null을 대체한다. 
    if :NEW.loan_acnt is null then
        select trunc(dbms_random.value(1000000000000, 10000000000000)) 
        into t_random_acnt
        from dual;
        insert into acnt(no, bizr_no) values(t_random_acnt, :NEW.bizr_no);
        :NEW.loan_acnt := t_random_acnt;
    end if;
    if :NEW.interest_acnt is null then
        :NEW.interest_acnt := t_random_acnt;
    end if;
end;
/
        
commit;
-- 대출 상환 내역이 생기면 잔금 - 상환금액 해주는 트리거
drop trigger trg_update_left_amt;
create or replace trigger trg_update_left_amt
before insert on rpy_history
for each row
declare
    t_mid_rpy_fee_rate      NUMBER;
    t_prod_no               loan_prod.prod_no%Type;
    t_fin_date              date;
    t_term_days             NUMBER;   
    t_left_days             NUMBER;
begin
    -- prod_no & 만기일 & 대출기간 & 잔여일 가져오기 
    select prod_no, fin_date, trunc(fin_date - start_date), trunc(fin_date - sysdate)
    into t_prod_no, t_fin_date, t_term_days, t_left_days
    from loan_history
    where loan_history.loan_no = :NEW.loan_no;
    
    -- mid_rpy_fee_rate 가져오기 
    select mid_rpy_fee_rate into t_mid_rpy_fee_rate
    from loan_prod
    where prod_no = t_prod_no;
    
    -- 새로 들어온 중도상환 내역 로우에 중도상환수수료 입력
    :NEW.mid_rpy_fee := trunc(:NEW.mid_rpy_amt * t_mid_rpy_fee_rate * 
                        t_left_days / t_term_days);
    -- 대출 내역의 잔금을 상환액에서 이자를 뺀만큼 차감                     
    update loan_history set left_amt = (left_amt - (:NEW.mid_rpy_amt - :NEW.mid_rpy_fee))
    where loan_history.loan_no = :NEW.loan_no;
end;
/
---------------------------------------------------
-- Transaction 테이블 
create table transaction (
	no						varchar2(13) primary key, -- 거래번호 
	occur_time		date default sysdate, -- 발생날짜 및 시간 
	summary				varchar2(100), -- 적요 
	main_acnt_no	varchar2(13), -- 거래 주체 계좌번호 
	obj_acnt_no		varchar2(13), -- 거래 대상 계좌번호 
	obj_name			varchar2(13), -- 보낸분/받는분 
	w_amount			number(30), -- 출금액 
	d_amount			number(30), -- 입금액  
	corr   				varchar2(100), -- 거래점 
	constraint fk_transaction_to_acnt foreign key (obj_acnt_no) references acnt (no) on delete set null,
	constraint fk_transaction_to_acnt2 foreign key (main_acnt_no) references acnt (no) on delete set null	
);


select trunc(1000 * (lp.mid_rpy_fee_rate / 100) * a.left_days / a.term_days) as mid_rpy_fee, a.term_days, a.left_days, lp.mid_rpy_fee_rate
		from (select prod_no, fin_date, trunc(fin_date - start_date) as term_days, trunc(fin_date - sysdate) as left_days, lh.fin_date, lh.start_date
	      	  from loan_history lh
	      	  where lh.loan_no = 277793) a, loan_prod lp
		where a.prod_no = lp.prod_no;
select * from loan_history where loan_status = 'I';
commit;
desc loan_app
select * from icm_stmt where bizr_no = '2208114806';
update acnt set balance = 10000000 where no = '6979277134150';
update acnt set balance = 50000000 where no = '9507022079381';
update acnt set balance = 80000000 where no = '2640302865851';
update acnt set balance = 4000000 where no = '7232069177737';

select * from loan_app where bizr_no = '2208114806' order by app_date desc;
select * from bank_emp where empno = '9971';
select *
from (select * 
      from loan_history
      where bizr_no = '2208114806')
where rownum <= 10;
select * from loan_doc;
update loan_history set fin_date = '20200906' where loan_no = '1372';
update loan_history set left_amt = 0 where loan_no = '1372';
update loan_history set loan_status = 'I' where fin_date <= sysdate and left_amt = 0 and loan_no = '1372';

select sysdate from dual;
select trunc(to_date('20210829', 'yyyymmdd') - sysdate) from dual;
select * from loan_history;
update loan_history set left_amt = trunc(left_amt) where loan_no = '1';

desc loan_history
insert into rpy_history(loan_no, mid_rpy_amt) values('1', 1000);
select * from rpy_history;
select * from loan_history;
select * from loan_history where loan_no = '1';
select * from loan_prod where prod_no = '1';

commit;
select trunc(dbms_random.value(1000000000000, 10000000000000)) from dual;
alter table loan_app rename column app_mon to app_year;
select * from loan_app;
select * from corp;

insert into corp(bizr_no, pw, name) values('1111', '1111', '회사1');
insert into loan_app (app_no, loan_type, loan_acnt, interest_acnt, ass_type, branch_nm,
app_date, app_amount, app_mon, loan_app_status, prod_no, bizr_no) 
values('1', 'W', '1111', '2222', '신용보증기금', '서울', to_char(sysdate, 'yyyy-mm-dd'), 1000000, 1, 'W', '1', '1111');

insert into loan_app (app_no, loan_type, ass_type, branch_nm,
app_date, app_amount, app_year, prod_no, bizr_no) 
values(seq_loan_app_no.nextval, 'W', '신용보증기금', '경남', to_char(sysdate, 'yyyy-mm-dd'), 1000000, 1, '1', '1111');

select * from loan_app;
select * from acnt;
commit;

insert into loan_history(loan_no, loan_type, start_date, fin_date, pcpl_amt, interest, loan_acnt,
interest_acnt, interest_date, loan_status, empno, prod_no, bizr_no)
values(seq_loan_history_no.nextval, 'W', sysdate, 
sysdate + (interval '1' year), 10000, 1.2, '1986180041914', '1986180041914', extract(day from sysdate),
'I', '322', '1', '1111');

commit;
create sequence seq_loan_history_no nocache;
select * from loan_app where bizr_no = '1111';
select * from loan_history;
update loan_history set left_amt = 10000 where loan_no = 1; 

select *, (pcpl_amt - left_amt) / pcpl_amt * 100 as rpyRate
from loan_history;

select (a.pcpl_amt - a.left_amt) / a.pcpl_amt * 100 as rpyRate, 
a.left_amt * (a.interest / 100) as interestAmt, a.*,
(select name 
 from loan_prod
 where prod_no = a.prod_no) as prod_name
from (select * 
      from loan_history) a;
      
select (a.pcpl_amt - a.left_amt) / a.pcpl_amt * 100 as rpyRate, 
		a.left_amt * (a.interest / 100) as interestAmt, a.*,
		(select name 
		 from loan_prod
		 where prod_no = a.prod_no) as prod_name
		from (select loan_no, loan_type, to_char(start_date, 'yyyy-mm-dd') as start_date, left_amt,
			  		 to_char(fin_date, 'yyyy-mm-dd') as fin_date, pcpl_amt, interest, loan_acnt, 
			  		 interest_acnt, interest_date, ass_type, loan_status, empno, prod_no, bizr_no
      		  from loan_history) a;
select name
from loan_prod
where prod_no = '1';

select * from corp;

commit;
insert into doc values(seq_doc_no.nextval, '사업자등록증', sysdate, 'buisness_no', '1111_biz', '1111', 10000, sysdate, '1111'); 
insert into doc values(seq_doc_no.nextval, '재무제표', sysdate, 'buisness_no', '1111_biz', '1111', 10000, sysdate, '1111'); 
insert into doc values(seq_doc_no.nextval, '주주명부', sysdate, 'buisness_no', '1111_biz', '1111', 10000, sysdate, '1111'); 

select doc_no, doc_type, issue_date, doc_ori_name, doc_save_name,
				uploader, doc_size, to_char(uld_date, 'yyyy-mm-dd'), bizr_no
		from doc
		where bizr_no = '1111';
        
desc t_reply

select * from doc;

delete from doc where doc_no = '3';

-- 재무제표 테이블 수정
drop table fs_status;
drop table cash_flow;
drop table icm_stmt;
drop table fnc_stmt;

/* 손익계산서 */
CREATE TABLE SCOTT.ICM_STMT (
	TURN NUMBER NOT NULL, /* 회차 */
	BIZR_NO VARCHAR2(10) NOT NULL, /* 사업자등록번호 */
	SALES NUMBER, /* 매출액 */
	BUSI_PROFITS NUMBER, /* 영업이익 */
	NET_INCM NUMBER /* 당기순이익 */
);

COMMENT ON TABLE SCOTT.ICM_STMT IS '손익계산서';

COMMENT ON COLUMN SCOTT.ICM_STMT.TURN IS '회차';

COMMENT ON COLUMN SCOTT.ICM_STMT.BIZR_NO IS '사업자등록번호';

COMMENT ON COLUMN SCOTT.ICM_STMT.SALES IS '매출액';

COMMENT ON COLUMN SCOTT.ICM_STMT.BUSI_PROFITS IS '영업이익';

COMMENT ON COLUMN SCOTT.ICM_STMT.NET_INCM IS '당기순이익';

CREATE UNIQUE INDEX SCOTT.PK_ICM_STMT
	ON SCOTT.ICM_STMT (
		TURN ASC,
		BIZR_NO ASC
	);

ALTER TABLE SCOTT.ICM_STMT
	ADD
		CONSTRAINT PK_ICM_STMT
		PRIMARY KEY (
			TURN,
			BIZR_NO
		);
        
alter table icm_stmt
    add
        constraint fk_corp_to_icm_stmt
        foreign key (
            bizr_no
        )
        references corp (
            bizr_no
        ) on delete cascade;
        
alter table icm_stmt add (issue_date date);
alter table cash_flow add (issue_date date);
alter table fs_status add (issue_date date);

/* 현금흐름표 */
CREATE TABLE SCOTT.CASH_FLOW (
	TURN NUMBER NOT NULL, /* 회차 */
	BIZR_NO VARCHAR2(10) NOT NULL, /* 사업자등록번호 */
	SALES_CF NUMBER, /* 영업활동현금흐름 */
	FIN_CF NUMBER, /* 투자활동현금흐름 */
	INVST_CF NUMBER /* 재무활동현금흐름 */
);

COMMENT ON TABLE SCOTT.CASH_FLOW IS '현금흐름표';

COMMENT ON COLUMN SCOTT.CASH_FLOW.TURN IS '회차';

COMMENT ON COLUMN SCOTT.CASH_FLOW.BIZR_NO IS '사업자등록번호';

COMMENT ON COLUMN SCOTT.CASH_FLOW.SALES_CF IS '영업활동현금흐름';

COMMENT ON COLUMN SCOTT.CASH_FLOW.FIN_CF IS '투자활동현금흐름';

COMMENT ON COLUMN SCOTT.CASH_FLOW.INVST_CF IS '재무활동현금흐름';

CREATE UNIQUE INDEX SCOTT.PK_CASH_FLOW
	ON SCOTT.CASH_FLOW (
		TURN ASC,
		BIZR_NO ASC
	);

ALTER TABLE SCOTT.CASH_FLOW
	ADD
		CONSTRAINT PK_CASH_FLOW
		PRIMARY KEY (
			TURN,
			BIZR_NO
		);
        
alter table cash_flow
    add
        constraint fk_corp_to_cash_flow
        foreign key (
            bizr_no
        )
        references corp (
            bizr_no
        ) on delete cascade;
        

        
/* 재무상태표 */
CREATE TABLE SCOTT.FS_STATUS (
	TURN NUMBER NOT NULL, /* 회차 */
	BIZR_NO VARCHAR2(10) NOT NULL, /* 사업자등록번호 */
	CURR_AST NUMBER, /* 유동자산 */
	NON_CURR_AST NUMBER, /* 비유동자산 */
	TTL_AST NUMBER, /* 자산총계 */
	CURR_LIAB NUMBER, /* 유동부채 */
	NON_CURR_LIAB NUMBER, /* 비유동부채 */
	TTL_LIAB NUMBER, /* 부채총계 */
	CAPITAL NUMBER, /* 자본 */
	ERND_SPLUS NUMBER, /* 이익잉여금 */
	TTL_CAPITAL NUMBER /* 자본총계 */
);

COMMENT ON TABLE SCOTT.FS_STATUS IS '재무상태표';

COMMENT ON COLUMN SCOTT.FS_STATUS.TURN IS '회차';

COMMENT ON COLUMN SCOTT.FS_STATUS.BIZR_NO IS '사업자등록번호';

COMMENT ON COLUMN SCOTT.FS_STATUS.CURR_AST IS '유동자산';

COMMENT ON COLUMN SCOTT.FS_STATUS.NON_CURR_AST IS '비유동자산';

COMMENT ON COLUMN SCOTT.FS_STATUS.TTL_AST IS '자산총계';

COMMENT ON COLUMN SCOTT.FS_STATUS.CURR_LIAB IS '유동부채';

COMMENT ON COLUMN SCOTT.FS_STATUS.NON_CURR_LIAB IS '비유동부채';

COMMENT ON COLUMN SCOTT.FS_STATUS.TTL_LIAB IS '부채총계';

COMMENT ON COLUMN SCOTT.FS_STATUS.CAPITAL IS '자본';

COMMENT ON COLUMN SCOTT.FS_STATUS.ERND_SPLUS IS '이익잉여금';

COMMENT ON COLUMN SCOTT.FS_STATUS.TTL_CAPITAL IS '자본총계';

CREATE UNIQUE INDEX SCOTT.PK_FS_STATUS
	ON SCOTT.FS_STATUS (
		TURN ASC,
		BIZR_NO ASC
	);

ALTER TABLE SCOTT.FS_STATUS
	ADD
		CONSTRAINT PK_FS_STATUS
		PRIMARY KEY (
			TURN,
			BIZR_NO
		);
        
alter table FS_STATUS
    add
        constraint fk_corp_to_FS_STATUS
        foreign key (
            bizr_no
        )
        references corp (
            bizr_no
        ) on delete cascade;
        
---------------------- 데이터 인서트 -------------------
insert into icm_stmt values(16, '1111', 24347218,	120381,	-1629679, to_date('20180420', 'yyyymmdd'));
select * from cash_flow;
insert into cash_flow values(16, '1111', 1161698,	-15785668,	830508,	to_date('20180420', 'yyyymmdd'));
insert into fs_status values(16, '1111', 23053799,	55270950,	78324749,	15314213, 11512077,	26826290,	1366450,	17919915,	51498459, to_date('20180420', 'yyyymmdd'));
commit;

insert into icm_stmt values(17,	'1111',	34158734,	870002,	735372, to_date('20190430', 'yyyymmdd'));
insert into cash_flow values(17, '1111',-493045,	-8849543,	5488735,	to_date('20190430', 'yyyymmdd'));
insert into fs_status values(17,	'1111',25353086,	56696861,	82049947,	20401851, 11050832,	31452683,	1366450,	17183344,	50597264,to_date('20190430', 'yyyymmdd')); 

insert into icm_stmt values(18,	'1111',	32067422, -2688741,	-6263868,	to_date('20200424', 'yyyymmdd'));
insert into cash_flow values(18, '1111',	2396747,	147906,	-134921,	to_date('20200424', 'yyyymmdd'));
insert into fs_status values(18,	'1111',	16744383,	55112776,	71857159,	14425198,	7569035,	21994233,	1692086,	10919476,	49862926, to_date('20200424', 'yyyymmdd'));


insert into credit_rank_history values('1111', to_date('20190430', 'yyyymmdd'), 'BBB', to_date('20190101', 'yyyymmdd'));
insert into credit_rank_history values('1111', to_date('20180420', 'yyyymmdd'), 'BB', to_date('20180420', 'yyyymmdd'));
insert into credit_rank_history values('1111', to_date('20200424', 'yyyymmdd'), 'A', to_date('20200424', 'yyyymmdd'));
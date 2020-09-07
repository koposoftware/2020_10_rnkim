spool db.lst;
@/Users/linakim/Desktop/최종프로젝트/DB/CRUD_TBL_v2.sql;
spool off;

drop sequence seq_loan_app_no;
create sequence seq_loan_app_no nocache;
commit;

select * from corp;

alter table loan_app add constraint fk_loan_app_to_acnt 
foreign key (loan_acnt) 
references acnt (no);

alter table acnt modify (bizr_no not null);

drop table loan_app;
drop table loan_doc;
drop table loan_eval;

insert into acnt(no, bizr_no) values('1111', '1111');
insert into acnt(no, bizr_no) values('2222', '1111');

truncate table acnt;

select * from acnt;
select * from loan_app;
insert into loan_app (app_no, loan_type, loan_acnt, interest_acnt, ass_type, branch_nm,
app_date, app_amount, app_year, loan_app_status, prod_no, bizr_no) 
values(seq_loan_app_no.nextval, 'W', '1111', '2222', '신용보증기금', '서울', to_char(sysdate, 'yyyy-mm-dd'), 1000000, 1, 'W', '1', '1111');

-- 테이블변경 ---------------------------------------------------------------------------------

commit;
update acnt set balance=0 where balance is null;
alter table acnt modify (balance default 0);
alter table acnt modify (balance not null);
alter table acnt modify (reg_date default sysdate);
alter table loan_app modify (app_date default sysdate);
alter table loan_app modify (loan_app_status default 'FW');
alter table loan_app modify (loan_acnt null);
alter table loan_app modify (interest_acnt null);
alter table loan_history add left_amt number;
alter table loan_history modify (fin_date DATE);
alter table loan_history modify (interest_date NUMBER);
alter table doc modify (uld_date default sysdate);
alter table doc rename column exp_date to issue_date;
alter table rep drop constraint fk_corp_to_rep;
ALTER TABLE SCOTT.REP ADD CONSTRAINT FK_CORP_TO_REP FOREIGN KEY (bizr_no) REFERENCES SCOTT.CORP (BIZR_NO) on delete cascade;
alter table rpy_history drop constraint fk_loan_his_to_rpy_his;
alter table rpy_history add constraint fk_loan_his_to_rpy_his foreign key (loan_no) references loan_history (loan_no) on delete cascade;
alter table acc_auth drop constraint fk_corp_to_acc_auth;
alter table acc_auth add constraint fk_corp_to_acc_auth foreign key (bizr_no) REFERENCES SCOTT.CORP (BIZR_NO) on delete cascade;
alter table acc_auth drop constraint FK_ACCOUNTANT_TO_acc_auth;
alter table acc_auth add constraint FK_ACCOUNTANT_TO_acc_auth foreign key (ACC_NO) REFERENCES SCOTT.ACCOUNTANT (ACC_NO) on delete cascade;
alter table DOC drop constraint FK_CORP_TO_DOC;
alter table DOC add constraint FK_CORP_TO_DOC foreign key (BIZR_NO) REFERENCES SCOTT.CORP (BIZR_NO) on delete cascade;
alter table ACNT drop constraint FK_CORP_TO_ACNT;
alter table ACNT add constraint FK_CORP_TO_ACNT foreign key (BIZR_NO) REFERENCES SCOTT.CORP (BIZR_NO) on delete cascade;


-- 테이블변경 ----------------------------------------------------------------------------------- 테이블변경 ---------------------------------------------------------------------------------

select *
from (select * from corp)
where rownum <= 10;
insert into rep values('김리나', '1111');
insert into rep values('김루키', '1111');
commit;

insert into accountant(acc_no, name, pw) values('0000', '손인범', '1111');
insert into accountant(acc_no, name, pw) values('0001', '이기창', '1111');
insert into accountant(acc_no, name, pw) values('0002', '김승원', '1111');

insert into acc_auth values('1111', '0000', sysdate, sysdate, 'C');
insert into acc_auth values('1111', '0001', sysdate, sysdate, 'C');
insert into acc_auth values('1111', '0002', sysdate, sysdate, 'C');

-- 세무사 목록 끌어오기 ----
select ac.acc_no, ac.name, ac.phone
from acc_auth aa, accountant ac
where aa.acc_no = ac.acc_no and aa.auth_status = 'C' and aa.bizr_no = '1111';

select * from accountant where bizr_no = '1111';


-- 신용등급 이력 끌어오기 ----
select a.*
from (select bizr_no, to_char(fnc_stmt_date, 'yyyy-mm-dd') as fnc_stmt_date, credit_rnk, to_char(rnk_date, 'yyyy-mm-dd') as rnk_date
      from credit_rank_history
      where bizr_no = '1111'
      order by rnk_date ) a
where rownum <= 3;

-- 기업분석 데이터 끌어오기 ----
select a.* 
from (select i.turn, sales, busi_profits, net_incm, curr_ast, non_curr_ast,
            ttl_ast, curr_liab, non_curr_liab, ttl_liab, capital, ernd_splus, ttl_capital,
            sales_cf, fin_cf, invst_cf
       from icm_stmt i, fs_status f, cash_flow c
       where i.turn = f.turn and f.turn = c.turn and c.bizr_no = '1111'
       order by turn desc) a
where rownum <= 3;


-- 대출내역 끌어오기 ----
select (a.pcpl_amt - a.left_amt) / a.pcpl_amt * 100 as rpyRate, 
		a.left_amt * (a.interest / 100) as interestAmt, a.*,
		(select name 
		 from loan_prod
		 where prod_no = a.prod_no) as prod_name
		from (select loan_no, loan_type, to_char(start_date, 'yyyy-mm-dd') as start_date, left_amt,
			  		 to_char(fin_date, 'yyyy-mm-dd') as fin_date, pcpl_amt, interest, loan_acnt, 
			  		 interest_acnt, interest_date, ass_type, loan_status, empno, prod_no, bizr_no
      		  from loan_history) a
        where bizr_no = '1111'
        order by start_date;

-- 대출 신청 현황 끌어오기 -----
select name, a.*
		from (select app_no, loan_type, loan_acnt, interest_acnt, ass_type, branch_nm,
            to_char(app_date, 'yyyy-mm-dd') as app_date, app_amount, app_year, loan_app_status,
            la.prod_no, empno, bizr_no
      		from loan_app la
      		where bizr_no = '1111') a, loan_prod lp
		where a.prod_no = lp.prod_no and loan_app_status = 'FW'
		order by app_date;
        
select * from loan_history;
        
create sequence seq_doc_no nocache;

select * from rep where bizr_no = '1111';

select to_char(issue_date - 360, 'yyyy') from fs_status where bizr_no = '1111'; 

select * from loan_app;
desc loan_app

select name, a.*
from (select app_no, loan_type, loan_acnt, interest_acnt, ass_type, branch_nm,
            to_char(app_date, 'yyyy-mm-dd'), app_amount, app_year, loan_app_status,
            la.prod_no, empno, bizr_no
      from loan_app la
      where bizr_no = '1111') a, loan_prod lp
where a.prod_no = lp.prod_no;

select * from loan_prod;

delete from loan_app where loan_app_status = 'W';

select * from loan_history;



/* 대출신청 */

CREATE TABLE SCOTT.LOAN_APP (
	APP_NO VARCHAR2(7) NOT NULL, /* 신청번호 */
	loan_type VARCHAR2(2) NOT NULL, /* 대출유형 */
	loan_acnt VARCHAR2(13) NOT NULL, /* 대출계좌 */
	interest_acnt VARCHAR2(13) NOT NULL, /* 이자납부계좌 */
	ass_type VARCHAR2(100), /* 담보유형 */
	branch_nm VARCHAR2(100), /* 지점명 */
	app_date DATE, /* 신청일 */
	APP_AMOUNT NUMBER NOT NULL, /* 신청금액 */
	APP_YEAR NUMBER NOT NULL, /* 신청개월수 */
	loan_app_status VARCHAR2(2) NOT NULL, /* 상태 */
	PROD_NO VARCHAR2(10) NOT NULL, /* 대출상품번호 */
	EMPNO VARCHAR2(6) NOT NULL, /* 직원번호 */
	BIZR_NO VARCHAR2(10) NOT NULL /* 사업자등록번호 */
);
CREATE UNIQUE INDEX SCOTT.PK_LOAN_WAITING
	ON SCOTT.LOAN_APP (
		APP_NO ASC
	);

ALTER TABLE SCOTT.LOAN_APP
	ADD
		CONSTRAINT PK_LOAN_WAITING
		PRIMARY KEY (
			APP_NO
		);
        
ALTER TABLE SCOTT.LOAN_APP
	ADD
		CONSTRAINT FK_CORP_TO_LOAN_WAITING
		FOREIGN KEY (
			BIZR_NO
		)
		REFERENCES SCOTT.CORP (
			BIZR_NO
		);
ALTER TABLE SCOTT.LOAN_APP
	ADD
		CONSTRAINT FK_LOAN_PROD_TO_LOAN_WAITING
		FOREIGN KEY (
			PROD_NO
		)
		REFERENCES SCOTT.LOAN_PROD (
			PROD_NO
		);
ALTER TABLE SCOTT.LOAN_APP
	ADD
		CONSTRAINT FK_BANK_EMP_TO_LOAN_WAITING
		FOREIGN KEY (
			EMPNO
		)
		REFERENCES SCOTT.BANK_EMP (
			EMPNO
		);
        
/* 신청서류 */
CREATE TABLE SCOTT.LOAN_DOC (
	APP_NO VARCHAR2(7) NOT NULL, /* 신청번호 */
	doc_no VARCHAR2(7) NOT NULL /* 서류번호 */
);

ALTER TABLE SCOTT.LOAN_DOC
	ADD
		CONSTRAINT PK_LOAN_DOC
		PRIMARY KEY (
			APP_NO,
			doc_no
		);
        
ALTER TABLE SCOTT.LOAN_DOC
	ADD
		CONSTRAINT FK_LOAN_WAITING_TO_LOAN_DOC
		FOREIGN KEY (
			APP_NO
		)
		REFERENCES SCOTT.LOAN_APP (
			APP_NO
		);

/* 대출심사 */
CREATE TABLE SCOTT.LOAN_EVAL (
	APP_NO VARCHAR2(7) NOT NULL, /* 신청번호 */
	EVAL_STEP NUMBER NOT NULL, /* 심사단계 */
	EVAL_DATE DATE NOT NULL, /* 심사일 */
	EVAL_RESULT VARCHAR2(2) NOT NULL, /* 심사결과 */
	EVAL_COMMENT VARCHAR2(300) /* 심사코멘트 */
);
CREATE UNIQUE INDEX SCOTT.PK_LOAN_EVAL
	ON SCOTT.LOAN_EVAL (
		APP_NO ASC,
		EVAL_STEP ASC
	);

ALTER TABLE SCOTT.LOAN_EVAL
	ADD
		CONSTRAINT PK_LOAN_EVAL
		PRIMARY KEY (
			APP_NO,
			EVAL_STEP
		);
        
ALTER TABLE SCOTT.LOAN_EVAL
	ADD
		CONSTRAINT FK_LOAN_WAITING_TO_LOAN_EVAL
		FOREIGN KEY (
			APP_NO
		)
		REFERENCES SCOTT.LOAN_APP (
			APP_NO
		);
       
        
alter table loan_app add constraint fk_loan_app_to_acnt
foreign key (loan_acnt)
references acnt (no);
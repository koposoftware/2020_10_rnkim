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
alter table transaction modify (no NUMBER);
alter table loan_history add (auto_interest_trans varchar2(1));
alter table loan_app add (auto_interest_trans varchar2(1));
alter table loan_app add (interest_date NUMBER);
alter table transaction modify (main_acnt_no not null);
alter table transaction modify (balance not null);


-- 테이블변경 ----------------------------------------------------------------------------------- 테이블변경 ---------------------------------------------------------------------------------
select * from loan_app;
update loan_app set auto_interest_trans = 'Y' where auto_interest_trans != 'Y';
select * from acnt;
/* 신청 목록 데이터에 이자납부일 랜덤 추가 */
update loan_app set interest_date = random_interest_date() where interest_date is null;
/* 기업 고유번호 테이블 */
create table corp_code (
    corp_code       VARCHAR2(20) primary key,
    bizr_no         VARCHAR2(40)
);
commit;
select add_months(sysdate, +1) from dual;
select count(*) from corp_code;
select corp_code from corp_code where bizr_no = '2208114806';
desc loan_app
/* 이자 납부 내역 */
create table pay_interest (
	pay_no					NUMBER primary key, /* 납부번호 */
	LOAN_NO					varchar2(7), /* 대출번호 */
	pay_amt					NUMBER,	/* 납부액 */
	pay_date				DATE default sysdate, /* 납부일 */
	next_mon_amt		NUMBER, /* 다음달 납부금액 */
	constraint fk_loan_his_to_pay_int foreign key (loan_no) references loan_history (loan_no) on delete cascade
);
create sequence seq_pay_interest_no nocache;
select * from loan_history where bizr_no = '2208114806';

create table tbl_left_mons (
    no              NUMBER primary key,
    left_mons       NUMBER
);

-- 이자 자동이체 로직
set serveroutput on
declare
    TYPE t_loan_no IS TABLE OF loan_history.loan_no%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_interest_acnt IS TABLE OF loan_history.interest_acnt%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_next_mon_amt IS TABLE OF pay_interest.next_mon_amt%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_pcpl_amt IS TABLE OF loan_history.pcpl_amt%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_interest IS TABLE OF loan_history.interest%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_left_mons IS TABLE OF tbl_left_mons.left_mons%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_pay_amt IS TABLE OF pay_interest.pay_amt%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_balance IS TABLE OF acnt.balance%TYPE INDEX BY BINARY_INTEGER;
    
    v_loan_no           t_loan_no;
    v_interest_acnt     t_interest_acnt;
    v_next_mon_amt      t_next_mon_amt;
    v_pcpl_amt          t_pcpl_amt;
    v_interest          t_interest;
    v_balance           t_balance;
    v_left_mons         t_left_mons;
    v_pay_amt           t_pay_amt;
    v_pay_ori           t_pay_amt;
    v_cnt               NUMBER;
    
begin
    -- 오늘날짜로 이자납부할 기업이 총 몇개인지 구하기 
    select count(*) into v_cnt
    from(
        select loan_no, interest_acnt
        from loan_history
        where interest_date = extract(day from sysdate));
    
    -- 오늘 날짜가 이자납부일인 대출 내역 찾기 
    for i in 1..v_cnt loop
        select loan_no, interest_acnt, left_mons, pcpl_amt, interest  
        into v_loan_no(i), v_interest_acnt(i), v_left_mons(i), v_pcpl_amt(i), v_interest(i)
        from (select loan_no, interest_acnt, trunc((fin_date - start_date)/30) as left_mons, pcpl_amt, interest
              from loan_history
              where interest_date = extract(day from sysdate)) 
        where rownum = i;
        
        dbms_output.put_line('v_loan_no'||v_loan_no(i));
        dbms_output.put_line('v_interest_acnt'||v_interest_acnt(i));
        dbms_output.put_line('v_left_mons'||v_left_mons(i));
        dbms_output.put_line('v_pcpl_amt'||v_pcpl_amt(i));
        dbms_output.put_line('v_interest'||v_interest(i));
        
    -- 대출 내역의 가장 최근 '다음달 납부금액' 찾기 
        select max(next_mon_amt) into v_next_mon_amt(i)
        from (select next_mon_amt
                from pay_interest
                where loan_no = v_loan_no(i)
                order by pay_date desc
                )
        where rownum <= 1;
        dbms_output.put_line('v_next_mon_amt'||v_next_mon_amt(i));
    
    -- '다음달 납부금액'이 없을때 (첫 이자납입) : interest_amt만큼 
        v_pay_ori(i) := trunc(v_pcpl_amt(i) * (v_interest(i) / 100) / 12 * v_left_mons(i) / v_left_mons(i));
        
        if v_next_mon_amt(i) is null then
            v_pay_amt(i) := v_pay_ori(i);
            
    -- '다음달 납부금액'이 있을때 그만큼을 이번달에 납부해야함.
        else
            v_pay_amt(i) := v_next_mon_amt(i);
        end if;
        
        dbms_output.put_line(v_pay_amt(i));
        
    -- 이자납부계좌의 잔액 가져오기
        select balance into v_balance(i)
        from acnt
        where no = v_interest_acnt(i);
        dbms_output.put_line(v_balance(i));
    
    -- 이자납입계좌에서 납부금액만큼 차감
        update acnt set balance = balance - v_pay_amt(i) where no = v_interest_acnt(i);
   
    -- 거래내역 테이블에 추가
        insert into transaction(no, summary, main_acnt_no, obj_name, w_amount, corr, balance)
        values(seq_transaction_no.nextval, '하나 대출 '||v_loan_no(i)||'이자납입', v_interest_acnt(i), '하나은행', v_pay_amt(i), '하나', (v_balance(i) - v_pay_amt(i)));
        
    -- 이자 납부 내역 추가      
        -- 잔액이 충분할 경우 
        if v_balance(i) >= v_pay_amt(i) then
            dbms_output.put_line('잔액이 있을경우');
            insert into pay_interest values(seq_interest_no.nextval, v_loan_no(i), v_pay_amt(i), sysdate, v_pay_ori(i));
        else
        -- 잔액이 부족할 경우 : 내야할금액 + 다음달금액 + 연체료(1%)
            dbms_output.put_line('잔액이 없을경우');
            insert into 
            pay_interest values(seq_interest_no.nextval, v_loan_no(i), 0, sysdate, (v_pay_ori(i) + v_pay_amt(i)) * 1.01);
        end if;
            
    end loop;
    
end;
/

-- 계좌에 랜덤하게 잔액 넣기
update acnt set balance = trunc(dbms_random.value(100, 80000)) * 10000 where balance is not null;
commit;

select seq_transaction_no.currval from dual;
select * from transaction;
select (trunc(dbms_random.value(100, 80000)) * 10000) from dual;
select balance 
        from acnt
        where no = '9032508194826';
        
        
        select max(next_mon_amt)
            from (select next_mon_amt
                  from pay_interest
                  where loan_no = '95'
                  order by pay_date desc
                  )
            where rownum <= 1;
      
select * from pay_interest where next_mon_amt is not null;
delete from pay_interest where pay_no = 10;


select * from pay_interest where loan_no = '5724942433231';
 select loan_no, interest_acnt
        from loan_history
        where interest_date = extract(day from sysdate);
        
        
select a.loan_no, a.interest_acnt, a.left_mons, a.pcpl_amt, a.interest  
        from (select loan_no, interest_acnt, trunc((fin_date - start_date)/30) as left_mons, pcpl_amt, interest
              from loan_history
              where interest_date = extract(day from sysdate)) a
        where rownum = 1;     
select count(*) 
    from(
        select loan_no, interest_acnt into v_loan_no, v_interest_acnt
        from loan_history
        where interest_date = extract(day from sysdate));
        
        
select *
from (
    select next_mon_amt
    from pay_interest
    where loan_no = '1372'
    order by pay_date desc
)
where rownum <= 1;

-- 월 이자금액 다시 계산 
select *
		from (select (a.pcpl_amt - a.left_amt) / a.pcpl_amt * 100 as rpyRate, 
			a.left_amt * (a.interest / 100 / 12 * a.loan_mons / a.loan_mons) as interestAmt, a.*,
			(select name 
			 from loan_prod
			 where prod_no = a.prod_no) as prod_name
			from (select loan_no, loan_type, to_char(start_date, 'yyyy-mm-dd') as start_date, trunc((fin_date - start_date)/30) as loan_mons,
                         left_amt, to_char(fin_date, 'yyyy-mm-dd') as fin_date, pcpl_amt, interest, loan_acnt, 
				  		 interest_acnt, interest_date, ass_type, loan_status, empno, prod_no, bizr_no
	      		  from loan_history) a
	        where bizr_no = '2208114806'
	        order by start_date desc)
		where rownum <= 1;
        
select trunc((fin_date - start_date)/30) as loan_mons from loan_history where loan_no = '1372';   

insert into pay_interest values(seq_pay_interest_no.nextval, '1372', 590000, '2020-04-12', 590000);
insert into pay_interest values(seq_pay_interest_no.nextval, '1372', 590000, '2020-05-12', 590000);

insert into pay_interest values(seq_pay_interest_no.nextval, '1372', 590000, '2020-07-12', 590000);
insert into pay_interest values(seq_pay_interest_no.nextval, '1372', 590000, '2020-08-12', 590000);
insert into pay_interest values(seq_pay_interest_no.nextval, '1372', 590000, '2020-09-12', 590000);

insert into pay_interest values(seq_pay_interest_no.nextval, '1372', 590000, '2020-07-12', 590000);
insert into pay_interest values(seq_pay_interest_no.nextval, '1372', 590000, '2020-08-12', 590000);
insert into pay_interest values(seq_pay_interest_no.nextval, '1372', 590000, '2020-09-12', 590000);

select * from loan_history where bizr_no = '';
commit;

update loan_history set auto_interest_trans = 'Y';
update pay_interest set pay_date = '2020-06-12' where pay_no = 3;

desc loan_history
truncate table transaction;
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
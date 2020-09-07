insert into acnt(no, bizr_no) 
    select trunc(dbms_random.value(1000000000000, 10000000000000)),
    (select bizr_no from corp 
    order by dbms_random.value) 
    from dual
    where rownum <= 1
connect by level <= 100000;

-- 대용량 데이터 삽입
-- 계좌테이블 
set serveroutput on;
declare
    t_acnt_no       acnt.no%TYPE;
    t_bizr_no       corp.bizr_no%TYPE;
begin
    
    
    for i in 1..200000 loop
    
        select trunc(dbms_random.value(1000000000000, 10000000000000)) into t_acnt_no
        from dual;
    
        select * into t_bizr_no
        from
        (select bizr_no from corp 
        order by dbms_random.value) 
        where rownum <= 1 
    
        insert into acnt(no, bizr_no) 
        values(t_acnt_no, t_bizr_no);
    end loop;
end;

create table bulk_test (
   no NUMBER
);

select * 
        
        from
        (select bizr_no from corp 
        order by dbms_random.value) 
        where rownum <= 1000; 
select * 
    from
        (select bizr_no from corp 
        order by dbms_random.value);
        
select bizr_no from corp 
        order by dbms_random.value;

-- 시도   
set serveroutput on;  
begin
    for i in 1..5000 loop
        insert into acnt(no, bizr_no) values(
            (select trunc(dbms_random.value(1000000000000, 10000000000000)) from dual),
            (select * 
            from
                (select bizr_no from corp 
                order by dbms_random.value) 
            where rownum <= 1));
    end loop;
end;



select * from acnt;




-- bulk insert 시도 1            
DECLARE
-- 1. MAXTEST 레코드 형식의 배열 선언
TYPE tbl_ins IS TABLE OF acnt%ROWTYPE INDEX BY BINARY_INTEGER;
w_ins tbl_ins;
t_acnt_no       acnt.no%TYPE;
t_bizr_no       acnt.bizr_no%TYPE;
BEGIN
        
-- 2. 배열에 값 설정
        FOR i IN 1..1000 LOOP 
            select trunc(dbms_random.value(1000000000000, 10000000000000)) into t_acnt_no
            from dual;
            
            select * into t_bizr_no
            from
            (select bizr_no from corp 
            order by dbms_random.value) 
            where rownum <= 1;
            
            DBMS_OUTPUT.PUT_LINE('t_acnt_no : ' || t_acnt_no);
            DBMS_OUTPUT.PUT_LINE('t_bizr_no : ' || t_bizr_no);
            
            w_ins(i).no := t_acnt_no;
            w_ins(i).bizr_no := t_bizr_no;
            w_ins(i).nickname := null;
            w_ins(i).reg_date := sysdate;
            w_ins(i).balance := 0;
            w_ins(i).valid := 'V';
           
        END LOOP;
        -- 3. 벌크 INSERT 실행
           FORALL i in 1..1000 INSERT INTO acnt VALUES w_ins(i);
           COMMIT;
END;
/
select count(*) from acnt;

delete from corp where bizr_no not in (select bizr_no from fs_status);

select * from bulk_test;
truncate table bulk_test;

select * from acnt;


-- 시도 2

DECLARE
-- 1. MAXTEST 레코드 형식의 배열 선언
    TYPE tbl_ins IS TABLE OF acnt%ROWTYPE INDEX BY BINARY_INTEGER;
    w_ins           tbl_ins;
    t_acnt_no       acnt.no%TYPE;
    t_bizr_no       acnt.bizr_no%TYPE;
   
BEGIN
            
-- 2. 배열에 값 설정
            
        FOR i IN 1..7000 LOOP 
            select trunc(dbms_random.value(1000000000000, 10000000000000)) into t_acnt_no
            from dual;
            
            select * into t_bizr_no
            from
            (select bizr_no from tbl_bizr_no 
            order by dbms_random.value) 
            where rownum <= 1;
            /*
            DBMS_OUTPUT.PUT_LINE('t_acnt_no : ' || t_acnt_no);
            DBMS_OUTPUT.PUT_LINE('t_bizr_no : ' || t_bizr_no);
            */
            w_ins(i).no := t_acnt_no;
            w_ins(i).bizr_no := t_bizr_no;
            w_ins(i).nickname := null;
            w_ins(i).reg_date := sysdate;
            w_ins(i).balance := 0;
            w_ins(i).valid := 'V';
           
        END LOOP;
        
        -- 3. 벌크 INSERT 실행
           FORALL i in 1..7000 INSERT INTO acnt VALUES w_ins(i);
           COMMIT;
END;
/
select count(*) from acnt;

select *
from (select * from acnt)
where rownum <= 2500;

select * from corp where bizr_no = '1258126711';
select count(bizr_no) from corp where bizr_no in 
(select bizr_no from fs_status);

select count(c.bizr_no) from corp c, fs_status f
where c.bizr_no = f.bizr_no;


select *
from
    (select c.bizr_no 
    from corp c, fs_status f
    where c.bizr_no = f.bizr_no
    order by dbms_random.value) 
where rownum <= 20;
    
            
select count(*) from fs_status;

-- 그냥... 새 테이블에 재무정보까지 있는 기업 사업자등록번호만 입력한 테이블 생성 
create table tbl_bizr_no as
select c.bizr_no from corp c, fs_status f
where c.bizr_no = f.bizr_no;

select count(*) from tbl_bizr_no;
--------------------------------- 대출 신청 테이블 ------------------------------------------------------------------
declare
    TYPE t_app_no IS TABLE OF loan_app.app_no%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_loan_type IS TABLE OF loan_app.loan_type%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_loan_acnt IS TABLE OF loan_app.loan_acnt%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_interest_acnt IS TABLE OF loan_app.interest_acnt%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_ass_type IS TABLE OF loan_app.ass_type%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_branch_nm IS TABLE OF loan_app.branch_nm%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_app_date IS TABLE OF loan_app.app_date%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_app_amount IS TABLE OF loan_app.app_amount%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_app_month IS TABLE OF loan_app.app_month%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_loan_app_status IS TABLE OF loan_app.loan_app_status%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_prod_no IS TABLE OF loan_app.prod_no%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_bizr_no IS TABLE OF loan_app.bizr_no%TYPE INDEX BY BINARY_INTEGER; 
    
    v_app_no                t_app_no;
    v_loan_type             t_loan_type;
    v_loan_acnt             t_loan_acnt;
    v_interest_acnt         t_interest_acnt;
    v_ass_type              t_ass_type;
    v_branch_nm             t_branch_nm;
    v_app_date              t_app_date;
    v_app_amount            t_app_amount;
    v_app_month             t_app_month;
    v_loan_app_status       t_loan_app_status;
    v_prod_no               t_prod_no; 
    v_bizr_no               t_bizr_no;
    
    vd_sysdate              DATE;        -- 현재일자
    vn_total_time           NUMBER := 0;  -- 소요시간 계산용 변수
    
begin
    vd_sysdate := SYSDATE;
    
    for i in 1..100000 LOOP
        v_app_no(i)                := seq_loan_app_no.nextval;
        v_loan_type(i)             := loan_type_weighted();
        v_branch_nm(i)             := pop_weighted();
        v_app_amount(i)            := trunc(dbms_random.value(1, 100)) * 10000000;
        v_app_month(i)             := trunc(dbms_random.value(6, 60));
        v_loan_app_status(i)       := 'FW';
        
        /*select seq_loan_app_no.nextval into v_app_no from dual;*/
        
        select a.no, a.no, a.bizr_no into v_loan_acnt(i), v_interest_acnt(i), v_bizr_no(i)
        from (select no, bizr_no
              from acnt 
              order by dbms_random.value) a
        where rownum <= 1;
        
        if v_loan_type(i) = 'M' then
            v_ass_type(i) := loan_type_weighted_M();
        elsif v_loan_type(i) = 'W' then
            v_ass_type(i) := loan_type_weighted_W();
        else 
            v_ass_type(i) := null;
        end if;
        
        SELECT TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2019-09-10','J')
                            ,TO_CHAR(DATE '2020-09-10','J')
                        )),'J'
               ) into v_app_date(i) FROM DUAL;  
               
        select a.prod_no into v_prod_no(i)
        from (select prod_no
              from loan_prod
              order by dbms_random.value) a
        where rownum <= 1;
        
    end loop;
    
    FORALL i in 1..100000 
        INSERT INTO loan_app(app_no, loan_type, loan_acnt, interest_acnt, ass_type,
        branch_nm, app_date, app_amount, app_month, loan_app_status, prod_no, bizr_no)
        VALUES (v_app_no(i),v_loan_type(i), v_loan_acnt(i),
                v_interest_acnt(i), v_ass_type(i),v_branch_nm(i), v_app_date(i),v_app_amount(i),
                v_app_month(i),v_loan_app_status(i),v_prod_no(i), v_bizr_no(i));
    COMMIT;

    -- INSERT 소요 시간 계산(초로 계산하기 위해 60 * 60 * 24을 곱함)
      vn_total_time := (SYSDATE - vd_sysdate) * 60 * 60 * 24;
      DBMS_OUTPUT.PUT_LINE('INSERT 건수 : ' || SQL%ROWCOUNT || ' , 소요시간: ' || vn_total_time );
   
end;
/


--------------------------------- 대출 내역 테이블 ------------------------------------------------------------------
declare
    TYPE t_loan_no IS TABLE OF loan_history.loan_no%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_loan_type IS TABLE OF loan_history.loan_type%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_start_date IS TABLE OF loan_history.start_date%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_fin_date IS TABLE OF loan_history.fin_date%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_pcpl_amt IS TABLE OF loan_history.pcpl_amt%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_interest IS TABLE OF loan_history.interest%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_loan_acnt IS TABLE OF loan_history.loan_acnt%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_interest_acnt IS TABLE OF loan_history.interest_acnt%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_interest_date IS TABLE OF loan_history.interest_date%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_ass_type IS TABLE OF loan_history.ass_type%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_loan_status IS TABLE OF loan_history.loan_status%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_empno IS TABLE OF loan_history.empno%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_prod_no IS TABLE OF loan_history.prod_no%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_bizr_no IS TABLE OF loan_history.bizr_no%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_left_amt IS TABLE OF loan_history.left_amt%TYPE INDEX BY BINARY_INTEGER;
    
    v_loan_no                   t_loan_no;
    v_loan_type                 t_loan_type;
    v_start_date                t_start_date;
    v_fin_date                  t_fin_date;
    v_pcpl_amt                  t_pcpl_amt;
    v_interest                  t_interest;
    v_loan_acnt                 t_loan_acnt;
    v_interest_acnt             t_interest_acnt;
    v_interest_date             t_interest_date;
    v_ass_type                  t_ass_type;
    v_loan_status               t_loan_status; 
    v_empno                     t_empno;
    v_prod_no                   t_prod_no;
    v_bizr_no                   t_bizr_no;
    v_left_amt                  t_left_amt;
    
    
    vd_sysdate              DATE;        -- 현재일자
    vn_total_time           NUMBER := 0;  -- 소요시간 계산용 변수
    
begin
    vd_sysdate := SYSDATE;
    
    for i in 1..200000 LOOP
    
         SELECT TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2016-01-01','J')
                            ,TO_CHAR(DATE '2018-12-31','J')
                        )),'J'
               ) into v_start_date(i) FROM DUAL; 
               
        SELECT TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2019-01-01','J')
                            ,TO_CHAR(DATE '2020-09-10','J')
                        )),'J'
               ) into v_fin_date(i) FROM DUAL; 
               
               
        v_loan_no (i)                  := seq_loan_history_no.nextval;
        v_loan_type(i)                 := loan_type_weighted();
        v_pcpl_amt(i)                  := trunc(dbms_random.value(1, 100)) * 10000000;
        v_interest(i)                  := round(dbms_random.value(1, 5), 2);
        v_interest_date(i)             := trunc(dbms_random.value(1, 30));
        v_loan_status(i)               := 'C'; 
        v_left_amt(i)                  := v_pcpl_amt(i);
        
        /*select seq_loan_app_no.nextval into v_app_no from dual;*/
        
        
               
               
        select a.no, a.no, a.bizr_no into v_loan_acnt(i), v_interest_acnt(i), v_bizr_no(i)
        from (select no, bizr_no
              from acnt 
              order by dbms_random.value) a
        where rownum <= 1;
        
        if v_loan_type(i) = 'M' then
            v_ass_type(i) := loan_type_weighted_M();
        elsif v_loan_type(i) = 'W' then
            v_ass_type(i) := loan_type_weighted_W();
        else 
            v_ass_type(i) := null;
        end if;
        

        select a.prod_no into v_prod_no(i)
        from (select prod_no
              from loan_prod
              order by dbms_random.value) a
        where rownum <= 1;
        
        SELECT * into v_empno(i)
        FROM
            (SELECT empno FROM bank_emp 
            ORDER BY DBMS_RANDOM.VALUE
            ) WHERE ROWNUM <= 1;
        
    end loop;
    
    FORALL i in 1..200000 
        INSERT INTO loan_history
        VALUES (v_loan_no(i), v_loan_type(i), v_start_date(i), v_fin_date(i), v_pcpl_amt(i), v_interest(i),
                v_loan_acnt(i), v_interest_acnt(i), v_interest_date(i), v_ass_type(i), v_loan_status(i),
                v_empno(i), v_prod_no(i), v_bizr_no(i), v_left_amt(i));
    COMMIT;

    -- INSERT 소요 시간 계산(초로 계산하기 위해 60 * 60 * 24을 곱함)
      vn_total_time := (SYSDATE - vd_sysdate) * 60 * 60 * 24;
      DBMS_OUTPUT.PUT_LINE('INSERT 건수 : ' || SQL%ROWCOUNT || ' , 소요시간: ' || vn_total_time );
   
end;
/


-- 직원 더 생성하는 프로시저
-- 5. 반복문 돌며 insert
set serveroutput on;
begin
    for i in 1..4500 loop
        insert into bank_emp values(seq_bank_emp_no.nextval, pop_weighted(), get_kornm('1', '3'),
                                (trunc(dbms_random.value(100, 120))), dbms_random.string('X', 10));
    end loop;
end;

commit;


-- 신용데이터 넣기
declare
    
    TYPE t_bizr_no IS TABLE OF credit_rank_history.bizr_no%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_fnc_stmt_date IS TABLE OF credit_rank_history.t_fnc_stmt_date%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_credit_rnk IS TABLE OF credit_rank_history.credit_rnk%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_rnk_date IS TABLE OF credit_rank_history.rnk_date%TYPE INDEX BY BINARY_INTEGER;
    
    v_bizr_no                   t_bizr_no;
    v_fnc_stmt_date             t_fnc_stmt_date;
    v_credit_rnk                t_credit_rnk;
    v_rnk_date                  t_rnk_date;

begin
    
    for i in 1..5000 LOOP
        
        select a.bizr_no into v_bizr_no(i)
        from (select bizr_no
              from acnt 
              order by dbms_random.value) a
        where rownum <= 1;

        SELECT TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2017-01-01','J')
                            ,TO_CHAR(DATE '2017-12-31','J')
                        )),'J'
               ) into v_rnk_date(i) FROM DUAL; 
               
        select issue_date into v_fnc_stmt_date(i)
        from fs_status
        where bizr_no = v_bizr_no(i);
        
        v_credit_rnk(i)            := credit_rnk_weighted();
    
    end loop;
    
    
    FORALL i in 1..5000 
        INSERT INTO credit_rank_history
        VALUES (v_bizr_no(i), v_fnc_stmt_date(i), v_credit_rnk(i), v_rnk_date(i));
    COMMIT;
end;
/

--- 신용데이터 - cursor 이용 (bizr_no)
declare
    cursor cur_bizr_no is
        select distinct bizr_no from tbl_bizr_no; 
    
    type t_bizr_no is table of credit_rank_history.bizr_no%TYPE;
    
    
    v_bizr_no                   t_bizr_no;
    
begin
    open cur_bizr_no;
    
    -- v_bizr_no
    fetch cur_bizr_no bulk collect into v_bizr_no;
       
    close cur_bizr_no; 
    
    forall i in 1..v_bizr_no.count 
        insert into credit_rank_history(bizr_no)
        values (v_bizr_no(i));
    commit;
    
end;
/

--- 신용데이터 (credit_rnk, rnk_date)
declare
    cursor cur_bizr_no is
        select bizr_no from credit_rank_history; 
    TYPE t_bizr_no IS TABLE OF credit_rank_history.bizr_no%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_fnc_stmt_date IS TABLE OF credit_rank_history.fnc_stmt_date%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_credit_rnk IS TABLE OF credit_rank_history.credit_rnk%TYPE INDEX BY BINARY_INTEGER;
    TYPE t_rnk_date IS TABLE OF credit_rank_history.rnk_date%TYPE INDEX BY BINARY_INTEGER;
    
    v_bizr_no                   t_bizr_no;
    v_fnc_stmt_date             t_fnc_stmt_date;
    v_credit_rnk                t_credit_rnk;
    v_rnk_date                  t_rnk_date;
begin
    open cur_bizr_no;
    
    -- v_bizr_no
    fetch cur_bizr_no bulk collect into v_bizr_no;
       
    close cur_bizr_no; 
    
    for i in 1..2067 loop
    
        SELECT TO_DATE(TRUNC(DBMS_RANDOM.VALUE(TO_CHAR(DATE '2019-01-01','J')
                            ,TO_CHAR(DATE '2019-12-31','J')
                        )),'J'
               ) into v_rnk_date(i) FROM DUAL; 
               
        v_credit_rnk(i)            := credit_rnk_weighted();
    
        insert into credit_rank_history(bizr_no, credit_rnk, rnk_date) 
        values(v_bizr_no(i), v_credit_rnk(i), v_rnk_date(i));
        
    end loop;
    /*
    forall j in 1..2067
        update credit_rank_history set credit_rnk = v_credit_rnk(j) where bizr_no = v_bizr_no(j);
        update credit_rank_history set rnk_date = v_rnk_date(j) where bizr_no = v_bizr_no(j);
    */    
    commit;
end;
/


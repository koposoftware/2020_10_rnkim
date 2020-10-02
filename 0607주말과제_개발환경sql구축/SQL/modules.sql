
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

---------------------------------------------------------------------------------------------------------
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

---------------------------------------------------------------------------------------------------------

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
        insert into acnt(no, bizr_no, valid) values(t_random_acnt, :NEW.bizr_no, 'I');
        :NEW.loan_acnt := t_random_acnt;
    end if;
    if :NEW.interest_acnt is null then
        :NEW.interest_acnt := t_random_acnt;
    end if;
end;
/

---------------------------------------------------------------------------------------------------------

-- 대출 상환 내역이 생기면 잔금 - 상환금액 & 중도상환수수료를 계산해주는 트리거
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
    t_updated_balance       NUMBER;
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
    :NEW.mid_rpy_fee := trunc(:NEW.mid_rpy_amt * (t_mid_rpy_fee_rate / 100) *
                        t_left_days / t_term_days);
    -- 대출 내역의 잔금을 상환액에서 이자를 뺀만큼 차감
    update loan_history set left_amt = (left_amt - (:NEW.mid_rpy_amt - :NEW.mid_rpy_fee))
    where loan_history.loan_no = :NEW.loan_no;

    -- 새로 들어온 상환내역의 잔금을 입력
    select left_amt into t_updated_balance from loan_history where loan_no = :NEW.loan_no;
    :NEW.balance := t_updated_balance;
end;
/
---------------------------------------------------------------------------------------------------------
-- 대량 corp 입력시 자동으로 비밀번호 생성해주는 트리거
create or replace trigger get_password
before insert on corp
for each row
declare
    t_pw     corp.pw%TYPE;
begin
    SELECT DBMS_RANDOM.STRING('P', 12) into t_pw
    FROM DUAL;

    :NEW.pw := t_pw;
end;

---------------------------------------------------------------------------------------------------------


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
    for i in 2..v_cnt loop
        select loan_no, interest_acnt, left_mons, pcpl_amt, interest
        into v_loan_no(i), v_interest_acnt(i), v_left_mons(i), v_pcpl_amt(i), v_interest(i)
        from (select rownum as rownumber, loan_no, interest_acnt, trunc((fin_date - start_date)/30) as left_mons, pcpl_amt, interest
              from loan_history
              where interest_date = extract(day from sysdate))
        where rownumber = i;

        --dbms_output.put_line('v_loan_no'||v_loan_no(i));
        -- '제수가 0입니다' 에러 방지용
        if v_left_mons(i) = 0 then
            v_left_mons(i) := 1;
        end if;

    -- 대출 내역의 가장 최근 '다음달 납부금액' 찾기
        select max(next_mon_amt) into v_next_mon_amt(i)
        from (select next_mon_amt
                from pay_interest
                where loan_no = v_loan_no(i)
                order by pay_date desc
                )
        where rownum <= 1;


    -- '다음달 납부금액'이 없을때 (첫 이자납입) : interest_amt만큼
        v_pay_ori(i) := trunc(v_pcpl_amt(i) * (v_interest(i) / 100) / 12 * v_left_mons(i) / v_left_mons(i));

        if v_next_mon_amt(i) is null then
            v_pay_amt(i) := v_pay_ori(i);

    -- '다음달 납부금액'이 있을때 그만큼을 이번달에 납부해야함.
        else
            v_pay_amt(i) := v_next_mon_amt(i);
        end if;



    -- 이자납부계좌의 잔액 가져오기
        select balance into v_balance(i)
        from acnt
        where no = v_interest_acnt(i);
        --dbms_output.put_line(v_balance(i));

    -- 이자납입계좌에서 납부금액만큼 차감
        update acnt set balance = balance - v_pay_amt(i) where no = v_interest_acnt(i);

    -- 거래내역 테이블에 추가
        insert into transaction(no, summary, main_acnt_no, obj_name, w_amount, corr, balance)
        values(seq_transaction_no.nextval, '하나 대출 '||v_loan_no(i)||'이자납입', v_interest_acnt(i), '하나은행', v_pay_amt(i), '하나', (v_balance(i) - v_pay_amt(i)));

    -- 이자 납부 내역 추가
        -- 잔액이 충분할 경우
        if v_balance(i) >= v_pay_amt(i) then
            --dbms_output.put_line('잔액이 있을경우');
            insert into pay_interest values(seq_interest_no.nextval, v_loan_no(i), v_pay_amt(i), sysdate, v_pay_ori(i));
        else
        -- 잔액이 부족할 경우 : 내야할금액 + 다음달금액 + 연체료(1%)
            --dbms_output.put_line('잔액이 없을경우');
            insert into
            pay_interest values(seq_interest_no.nextval, v_loan_no(i), 0, sysdate, (v_pay_ori(i) + v_pay_amt(i)) * 1.01);
        end if;

    end loop;

    exception
        when no_data_found then
        null;
end;
/

---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------

------- 대용량 삽입을 위한 함수들 ---------

-- 대출유형 랜덤 생성 함수
create or replace function loan_type_weighted
return char
is
        loan_type char(1);
begin
with T as
(
select 'M' as lt, 30 rate from dual union all
select 'W' , 50 rate from dual union all
select 'C' , 20 rate from dual
)
select lt into loan_type from (
select * from T A,
(select level lv from dual connect by level <= 100) B
 where rate >= LV
 order by dbms_random.value
)
where rownum <= 1;
return loan_type;
end;
/

-- 담보 유형 랜덤 생성 함수 (물적담보)
create or replace function loan_type_weighted_M
return char
is
        ass_type char(10);
begin
with T as
(
select '토지' as at, 30 rate from dual union all
select '부동산', 70 rate from dual
)
select at into ass_type from (
select * from T A,
( SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 100) B
  WHERE RATE >= LV
  ORDER BY DBMS_RANDOM.VALUE
)
WHERE ROWNUM <= 1;
RETURN ass_type;
END;
/

-- 담보 유형 랜덤 생성 함수 (보증서담보)
create or replace function loan_type_weighted_W
return char
is
        ass_type char(30);
begin
with T as
(
select '신용보증기금' as at, 25.5 rate from dual union all
select '기술보증기금', 10.5 rate from dual union all
select '신용보증재단', 25 rate from dual union all
select '소상공인 진흥원', 17.5 rate from dual union all
select '무역보험공사', 21.5 rate from dual
)
select at into ass_type from (
select * from T A,
( SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 100) B
  WHERE RATE >= LV
  ORDER BY DBMS_RANDOM.VALUE
)
WHERE ROWNUM <= 1;
RETURN ass_type;
END;
/

-- 지점 랜덤 생성 함수
create or replace function branch_weighted
return char
is
        branch_nm char(30);
begin
with T as
(
select '신용보증기금' as at, 25.5 rate from dual union all
select '기술보증기금', 10.5 rate from dual union all
select '신용보증재단', 25 rate from dual union all
select '소상공인 진흥원', 17.5 rate from dual union all
select '무역보험공사', 21.5 rate from dual
)
select at into ass_type from (
select * from T A,
( SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 100) B
  WHERE RATE >= LV
  ORDER BY DBMS_RANDOM.VALUE
)
WHERE ROWNUM <= 1;
RETURN ass_type;
END;
/

-- 대출상품 랜덤 뽑기 함수
create or replace function branch_weighted
return char
is
        branch_nm char(30);
begin
with T as
(
select '신용보증기금' as at, 25.5 rate from dual union all
select '기술보증기금', 10.5 rate from dual union all
select '신용보증재단', 25 rate from dual union all
select '소상공인 진흥원', 17.5 rate from dual union all
select '무역보험공사', 21.5 rate from dual
)
select at into ass_type from (
select * from T A,
( SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 100) B
  WHERE RATE >= LV
  ORDER BY DBMS_RANDOM.VALUE
)
WHERE ROWNUM <= 1;
RETURN ass_type;
END;
/

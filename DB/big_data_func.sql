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


-- 신용등급 랜덤 뽑기 함수
create or replace function credit_rnk_weighted
return char
is
        credit_rnk varchar2(30);
begin
with T as
(
select 'AAA' as cr, 8.5 rate from dual union all
select 'AA', 14.5 rate from dual union all
select 'A', 19 rate from dual union all
select 'BBB', 20 rate from dual union all
select 'BB', 18 rate from dual union all
select 'B', 15 rate from dual union all
select 'CCC', 5 rate from dual 
)
select cr into credit_rnk from (
select * from T A,
( SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 100) B
  WHERE RATE >= LV
  ORDER BY DBMS_RANDOM.VALUE
)
WHERE ROWNUM <= 1;
RETURN credit_rnk;
END;
/

-- 이자납입일 3, 12, 23중 랜덤선택 
create or replace function random_interest_date
return char
is
        interest_date NUMBER;
begin
with T as
(
select 3 as id from dual union all
select 12 from dual union all
select 23 from dual
)
select id into interest_date from (
select * from T A,
( SELECT LEVEL LV FROM DUAL CONNECT BY LEVEL <= 100) B
  ORDER BY DBMS_RANDOM.VALUE
)
WHERE ROWNUM <= 1;
RETURN interest_date;
END;
/

select random_interest_date() from dual;
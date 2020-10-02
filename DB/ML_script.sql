-- 머신러닝용 테이블 생성
create table learningTbl as 
select sales, busi_profits, net_incm, curr_ast, non_curr_ast,
       ttl_ast, curr_liab, non_curr_liab, ttl_liab, capital, ernd_splus, ttl_capital,
       sales_cf, fin_cf, invst_cf
from icm_stmt i, fs_status f, cash_flow c
where i.bizr_no = f.bizr_no and f.bizr_no = c.bizr_no and 
      i.turn = f.turn and f.turn = c.turn and extract(year from c.issue_date) = '2019';

-- 정규화 후의 데이터 넣을 테이블 생성
create table MLTBL (
    busi_profits      NUMBER, 
    net_incm          NUMBER, 
    ttl_liab          NUMBER, 
    credit_rnk        NUMBER, 
    interest          NUMBER
);
  
commit;    
select * from MLTBL;
select * from MLTBL where interest = 2.12;
truncate table MLTBL;
select max(busi_profits), max(net_incm) from MLTBL;

select * from MLTBL where interest < 1.5;
alter table learningTbl add (limit number);
alter table learningTbl add (interest number);
alter table learningTbl add (credit_rnk number);

-- 피처값 줄이기 
alter table learningTbl drop column curr_ast;
alter table learningTbl drop column non_curr_ast;
alter table learningTbl drop column curr_liab;
alter table learningTbl drop column non_curr_liab;
alter table learningTbl drop column sales_cf;
alter table learningTbl drop column fin_cf;
alter table learningTbl drop column invst_cf;
alter table learningTbl drop column capital;
alter table learningTbl drop column sales;
alter table learningTbl drop column ttl_ast;
alter table learningTbl drop column ernd_splus;
alter table learningTbl drop column ttl_capital;
alter table learningTbl drop column sales;

-- null 값 없애기
delete from learningTbl where busi_profits is null or net_incm is null or ttl_ast is null 
or ttl_liab is null or ernd_splus is null or ttl_capital is null;

select max(busi_profits), min(busi_profits), trunc(avg(busi_profits)), max(busi_profits) - min(busi_profits) / 10 
from learningTbl;

commit;

select * from icm_stmt, fs_status, cash_flow;
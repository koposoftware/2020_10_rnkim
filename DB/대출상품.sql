/* 대출상품 */
CREATE TABLE SCOTT.LOAN_PROD (
	PROD_NO             VARCHAR2(10)    NOT NULL, /* 대출상품번호 */
	TERM_MON            NUMBER          NOT NULL, /* 대출기간(개월) */
	NAME                VARCHAR2(100)   NOT NULL, /* 상품명 */
	OBJECT              VARCHAR2(700)   NOT NULL, /* 대상 */
	interest            NUMBER          NOT NULL, /* 최저금리 */
	limit               NUMBER          NOT NULL, /* 한도 */
	interest_cal_mtd    VARCHAR2(700),            /* 이자계산방법 */
	cancle_re_mtd       VARCHAR2(700),            /* 계약해지/갱신방법 */
	rep_type            VARCHAR2(100),            /* 상환방식 */
	rep_mtd             VARCHAR2(700),            /* 원리금 상환방법 */
	notice              VARCHAR2(700),            /* 유의사항 */
	MID_RPY_FEE_RATE    NUMBER                    /* 중도상환수수료율 */
);

ALTER TABLE SCOTT.LOAN_PROD
	ADD
		CONSTRAINT PK_LOAN_PROD
		PRIMARY KEY (
			PROD_NO
		);
        
create sequence seq_loan_prod nocache;

insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);
insert into loan_prod values(seq_loan_prod.nextval, 12, '대출상품', '대상', 1.2, 30000000, 
'방법', '해지방법', '상환방식', '원리금 상환방법', '유의사항', 3);

select * from loan_prod order by prod_no asc;
commit;
select count(*)from loan_prod;

select * 
from (select rownum as rnum, a.*
      from (select * from loan_prod) a
      where rownum <= 6*3)
where rnum > 6*(3-1); 

select * from loan_prod where prod_no in (1, 2);
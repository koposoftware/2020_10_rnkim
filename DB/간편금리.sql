/* 간편금리 */
drop table interest_test;
drop sequence seq_interest_no;
CREATE TABLE SCOTT.interest_test (
	interest_no VARCHAR2(7) NOT NULL, /* 금리번호 */
	loan_type VARCHAR2(2) NOT NULL, /* 대출유형 */
	standard VARCHAR2(100) NOT NULL, /* 분할기준 */
	standard_val VARCHAR2(100) NOT NULL, /* 분할값 */
	interest NUMBER NOT NULL /* 금리 */
);

ALTER TABLE SCOTT.interest_test
	ADD
		CONSTRAINT PK_interest_test
		PRIMARY KEY (
			interest_no
		);

create sequence seq_interest_no nocache;
insert into interest_test values(seq_interest_no.nextval, 'M', '신용등급', 'AAA ~ A', 2.36); 
insert into interest_test values(seq_interest_no.nextval, 'M', '신용등급', 'BBB', 2.56); 
insert into interest_test values(seq_interest_no.nextval, 'M', '신용등급', 'BB', 2.76); 
insert into interest_test values(seq_interest_no.nextval, 'M', '신용등급', 'B', 3.03); 
insert into interest_test values(seq_interest_no.nextval, 'M', '신용등급', 'CCC ~ D', 4.23); 

insert into interest_test values(seq_interest_no.nextval, 'C', '신용등급', 'AAA ~ A', 2.41); 
insert into interest_test values(seq_interest_no.nextval, 'C', '신용등급', 'BBB', 3.16); 
insert into interest_test values(seq_interest_no.nextval, 'C', '신용등급', 'BB', 3.98); 
insert into interest_test values(seq_interest_no.nextval, 'C', '신용등급', 'B', 5.41); 
insert into interest_test values(seq_interest_no.nextval, 'C', '신용등급', 'CCC ~ D', 6.74); 

insert into interest_test values(seq_interest_no.nextval, 'W', '보증비율', '100%', 1.96); 
insert into interest_test values(seq_interest_no.nextval, 'W', '보증비율', '90%', 2.62); 
insert into interest_test values(seq_interest_no.nextval, 'W', '보증비율', '85%', 2.89); 
insert into interest_test values(seq_interest_no.nextval, 'W', '보증비율', '80%', 3.10); 
insert into interest_test values(seq_interest_no.nextval, 'W', '보증비율', '80% 미만', 3.82); 

select * from interest_test;

commit;

select interest from interest_test where loan_type='W' and standard_val = '100%';


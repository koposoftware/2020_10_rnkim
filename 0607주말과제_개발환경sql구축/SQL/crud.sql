SELECT calc_left_days('000001') from dual;
-- from loan_history로 하면 000001 무시하고 모든 행에 함수가 적용됨 유의 

SELECT lh.fin_mon 
    FROM loan_history lh
    WHERE lh.loan_no = '000001';
 
  
SELECT corp_id
FROM loan_history
WHERE pcpl_amt > (SELECT AVG(pcpl_amt) 
                    FROM loan_history);

SELECT a.name 
FROM accountant a, corp c
WHERE c.acc_no = a.acc_no
AND c.corp_id = 'hanafnc';

SELECT c.corp_name, crh.rnk_date, crh.credit_rnk 
FROM corp c, credit_rank_history crh
WHERE c.corp_id = crh.corp_id(+);

SELECT ename, (SELECT COUNT(loan_no) 
                FROM loan_history lh
                WHERE be.empno = lh.empno) as count
FROM bank_emp be
ORDER BY ename;

spool off
ed high_amt_loan_corp.list


SPOOL 18_양은희.lst
@C:\plsqlProject\18_양은희_CRD_TBL;
@C:\plsqlProject\18_양은희_CRUD;
@C:\plsqlProject\18_양은희_PLSQL;
SPOOL OFF
ed 18_양은희.lst

SPOOL /Users/linakim/Documents/POLITEC/프로젝트/최종프로젝트/0607주말과제_개발환경sql구축/13_김리나10.lst;
@/Users/linakim/Documents/POLITEC/프로젝트/최종프로젝트/0607주말과제_개발환경sql구축/2060340013_김리나_CRD_TBL.SQL;
@/Users/linakim/Documents/POLITEC/프로젝트/최종프로젝트/0607주말과제_개발환경sql구축/2060340013_김리나_PL.SQL;
@/Users/linakim/Documents/POLITEC/프로젝트/최종프로젝트/0607주말과제_개발환경sql구축/2060340013_김리나_PL(2).sql;
@/Users/linakim/Documents/POLITEC/프로젝트/최종프로젝트/0607주말과제_개발환경sql구축/2060340013_김리나_CRUD.sql;
SPOOL OFF;

SPOOL /Users/linakim/Documents/POLITEC/프로젝트/최종프로젝트/0607주말과제_개발환경sql구축/13_김리나9.lst
select * from emp;
SPOOL OFF;
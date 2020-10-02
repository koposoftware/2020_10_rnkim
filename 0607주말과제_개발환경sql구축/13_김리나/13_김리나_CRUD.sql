REM 해당 기업을 담당하는 세무사 이름 조회
REM 이유 : 기업이 대출신청을 했을경우 세무사가 떼어줘야하는 서류가 필요하다면 해당 기업을 담당하는 기장 세무사를 바로 찾을 수 있어야 하기 때문.
SELECT a.name
FROM accountant a, corp c
WHERE c.acc_no = a.acc_no
AND c.corp_id = 'hanafnc';

REM 기업들의 평균 대출금액보다 큰 금액을 대출한 기업 아이디 조회
REM 이유 : 은행의 입장에서 대출 추이를 확인하기 위해
SELECT corp_id
FROM loan_history
WHERE pcpl_amt > (SELECT AVG(pcpl_amt)
                    FROM loan_history);

REM 신용평가를 한 기업과 안한 기업 모두의 신용평가 기록 및 기업 이름 조회
REM 이유 : 신용평가를 한 기업과 그렇지 않은 기업을 구분하기 위해
SELECT c.corp_name, crh.rnk_date, crh.credit_rnk
FROM corp c, credit_rank_history crh
WHERE c.corp_id = crh.corp_id(+);

REM 은행 직원별 대출건수 실적 조회
REM 이유 : 실적이 높은 직원에게 상여금을 지급하기 위해
SELECT ename, (SELECT COUNT(loan_no)
                FROM loan_history lh
                WHERE be.empno = lh.empno) AS count
FROM bank_emp be
ORDER BY ename;

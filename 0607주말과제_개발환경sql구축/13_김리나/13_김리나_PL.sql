REM ******************************************************************
REM SCRIPT 용도   : 특정 대출의 상환 기간이 얼마나 남았는지 알 수 있는 FUNCTION
REM 작성자         : 김리나
REM 작성일         : 2020-06-08, Version 1
REM
REM 주의사항       : 1. 대출 기간이 1년 이상 5년 이하의 대출에만 해당한다.
REM                2. 1년 ~ 5년 외의 다른 값을 입력시 연산할 수 없다.
REM 원리          : 알고자하는 대출 번호를 매개변수로 받아 SELECT 문을 돌며 필요한 변수를 받아온다.
REM                대출 개월수가 각각 1년부터 5년일 경우를 나누어 남은 상환일 = 대출 시작일 + 대출 기간 - 오늘날짜 식을 이용한다.
REM ******************************************************************

set serveroutput on;
CREATE OR REPLACE FUNCTION calc_left_days(p_loan_no VARCHAR2)
RETURN NUMBER
IS
    left_days       NUMBER  := 0;
    today           DATE    := to_char(SYSDATE);
    p_mon           NUMBER  := 0;
    p_start_dt      DATE;

BEGIN
    -- 대출개월수 (년수)로 대출 잔여일 구하기
    SELECT lh.fin_mon INTO p_mon
    FROM loan_history lh
    WHERE lh.loan_no = p_loan_no;

    SELECT lh.start_date INTO p_start_dt
    FROM loan_history lh
    WHERE lh.loan_no = p_loan_no;

    IF      p_mon = 12     then
                left_days := p_start_dt + 365 - today;
    ELSIF   p_mon = 24     then
                left_days := p_start_dt + 730 - today;
    ELSIF   p_mon = 36     then
                left_days := p_start_dt + 1095 - today;
    ELSIF   p_mon = 48     then
                left_days := p_start_dt + 1460 - today;
    ELSE    left_days := p_start_dt + 1825 - today;

    END IF;
    return left_days;

end;
/

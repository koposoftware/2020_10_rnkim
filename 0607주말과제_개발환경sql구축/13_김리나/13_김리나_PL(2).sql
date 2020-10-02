REM ******************************************************************************************************************************************************************************************************
REM SCRIPT 용도 : 기업이 중도 상환했을시 자동으로 중도 상환 수수료를 계산하여 테이블에 저장하는 TRIGGER
REM 작성자       : 김리나
REM 작성일       : 2020-06-08
REM
REM 주의사항      : 1. 아직 완성되지 못하였다. nested block의 insert 구문이 작동하지 않아 여러차례 디버깅해보았지만 원인을 알 수 없었다.
REM 원리         : 1. 여러 테이블의 여러 칼럼을 써야하기때문에 RECORD 형식으로 변수를 선언해준다.
REM             : 2. 필요한 변수들을 select into 문을 활용해 찾아넣는다.
REM             : 3. 대출 잔여일수를 구할때는 function calc_left_days를 이용한다.
REM             : 4. 금리의경우 계산을 위해 %를 다시 소숫점으로 변환해준다.
REM             : 5. 중도상환수수료액의 경우 은행에서 채택한 식으로 계산해준다.
REM 수정사항 format yy/mm/dd  수정자 수정내용
REM           1.  20/06/08  김리나 INSERT가 일어날시 발생되는 트리거인데 트리거 내에서 다시 INSERT를 호출하고있으므로 계속 재귀적으로 insert를 하다가 세션 개수를 초과하는 문제가 발생했었다.
REM                               insert 대신 update를 해보았지만 before insert의 실행시점에 trigger가 발생하기때문에 이미 행이 insert 된 상태가 아니라 update가 불가능했다.
REM                               After insert 와 update를 사용해보았지만 테이블이 변경되서 trigger가 실행될 수 없다는 에러가 떴다.
REM                               고민해보니 trigger 안에서 굳이 dml문을 쓰지 않고, 어차피 trigger의 호출시점이 before insert 이기때문에 trigger가 끝난 후 insert문이 실행된다.
REM                               이 점을 이용하여 내가 바꾸고자 하는 변수인 :New.mid_rpy_fee 만 업데이트해주면 해당 값을 가지고 trigger이 끝난 후 insert해주게된다.
REM ******************************************************************************************************************************************************************************************************

CREATE OR REPLACE TRIGGER TRG_mid_rpy_fee
BEFORE INSERT ON RPY_HISTORY
FOR EACH ROW
DECLARE
    TYPE T_mid_rpy_record IS RECORD (
        t_corp_id         corp.corp_id%TYPE,
        t_mid_rpy_fee     NUMBER,
        t_rpy_fee_rate    NUMBER,
        t_start_dt        DATE,
        t_mons            NUMBER,
        t_days            NUMBER,
        t_left_days       NUMBER
    );

rec T_mid_rpy_record;
gbl_mid_rpy_fee NUMBER;

BEGIN
    -- 중도 상환이 일어났을경우 rpy_history 테이블에 입력된 값을 이용해 중도상환수수료금액을 자동으로 계산해 값을 넣는다.
    -- 다른 테이블에서 record의 field값 대입하기
        -- 기업아이디
    SELECT corp_id INTO rec.t_corp_id
    FROM loan_history lh
    WHERE :NEW.loan_no = lh.loan_no;
    DBMS_OUTPUT.PUT_LINE(rec.t_corp_id);


        -- 중도상환수수료율
    SELECT lp.mid_rpy_fee_rate INTO rec.t_rpy_fee_rate
    FROM loan_prod lp, loan_history lh
    WHERE lp.prod_no = lh.prod_no
    AND lh.corp_id = rec.t_corp_id
    AND lh.loan_no = :NEW.loan_no;
    DBMS_OUTPUT.PUT_LINE(rec.t_rpy_fee_rate);

        -- 기준일자
    SELECT lh.start_date INTO rec.t_start_dt
    FROM loan_history lh
    WHERE lh.loan_no = :NEW.loan_no;
    DBMS_OUTPUT.PUT_LINE(rec.t_start_dt);

        -- 개월수
    SELECT lh.fin_mon INTO rec.t_mons
    FROM loan_history lh
    WHERE lh.loan_no = :NEW.loan_no;
    DBMS_OUTPUT.PUT_LINE(rec.t_mons);

        -- 대출잔여일수
    SELECT calc_left_days(:NEW.loan_no) INTO rec.t_left_days
    FROM dual;

    DBMS_OUTPUT.PUT_LINE(rec.t_left_days);

    -- 총 대출일수 (개월을 일로 변환)
    IF      rec.t_mons = 12     then
                rec.t_days := 365;
    ELSIF   rec.t_mons = 24     THEN
                rec.t_days := 730;
    ELSIF   rec.t_mons = 36     THEN
                rec.t_days := 1095;
    ELSIF   rec.t_mons = 48     THEN
                rec.t_days := 1460;
    ELSE    rec.t_days := 1825;
    END IF;

    DBMS_OUTPUT.PUT_LINE(rec.t_days);


    -- 중도상환수수료율은 x.xx%이므로 계산을 위해 100으로 나눈다.
    rec.t_rpy_fee_rate := rec.t_rpy_fee_rate / 100;
    DBMS_OUTPUT.PUT_LINE(rec.t_rpy_fee_rate);

    -- 중도상환수수료액
    rec.t_mid_rpy_fee := round(:NEW.mid_rpy_amt * rec.t_rpy_fee_rate * rec.t_left_days / rec.t_days);
    DBMS_OUTPUT.PUT_LINE(rec.t_mid_rpy_fee);
    :NEW.mid_rpy_fee := rec.t_mid_rpy_fee;


    DBMS_OUTPUT.PUT_LINE('시작');
    --UPDATE rpy_history SET mid_rpy_fee = gbl_mid_rpy_fee WHERE loan_no = :NEW.loan_no;
    --INSERT INTO rpy_history values (:NEW.mid_rpy, :NEW.loan_no, :NEW.mid_rpy_amt, rec.t_mid_rpy_fee);
    DBMS_OUTPUT.PUT_LINE('insert 완료');


    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            Null;
            WRITE_LOG('TGR_mid_rpy_fee', SQLERRM, 'VALUES : [loan_no] => '||:NEW.loan_no);
        WHEN OTHERS THEN
            NULL;
            WRITE_LOG('TGR_mid_rpy_fee', SQLERRM, 'VALUES : [loan_no] => '||:NEW.loan_no);
            dbms_output.put_line(SQLERRM);
END;
/

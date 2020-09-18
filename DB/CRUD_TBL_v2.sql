
/* 세무사 */
CREATE TABLE SCOTT.ACCOUNTANT (
	ACC_NO VARCHAR2(7) NOT NULL, /* 세무사등록번호 */
	NAME VARCHAR2(30) NOT NULL, /* 세무사이름 */
	PW VARCHAR2(20) NOT NULL, /* 비밀번호 */
	PHONE VARCHAR2(13) /* 연락처 */
);

COMMENT ON TABLE SCOTT.ACCOUNTANT IS '세무사';

COMMENT ON COLUMN SCOTT.ACCOUNTANT.ACC_NO IS '세무사등록번호';

COMMENT ON COLUMN SCOTT.ACCOUNTANT.NAME IS '세무사이름';

COMMENT ON COLUMN SCOTT.ACCOUNTANT.PW IS '비밀번호';

COMMENT ON COLUMN SCOTT.ACCOUNTANT.PHONE IS '연락처';

CREATE UNIQUE INDEX SCOTT.PK_ACCOUNTANT
	ON SCOTT.ACCOUNTANT (
		ACC_NO ASC
	);

CREATE UNIQUE INDEX SCOTT.UK_ACCOUNTANT
	ON SCOTT.ACCOUNTANT (
	);

ALTER TABLE SCOTT.ACCOUNTANT
	ADD
		CONSTRAINT PK_ACCOUNTANT
		PRIMARY KEY (
			ACC_NO
		);

ALTER TABLE SCOTT.ACCOUNTANT
	ADD
		CONSTRAINT UK_ACCOUNTANT
		UNIQUE (
		);

/* 은행직원 */
CREATE TABLE SCOTT.BANK_EMP (
	EMPNO VARCHAR2(6) NOT NULL, /* 직원번호 */
	BRANCH_NM VARCHAR2(100) NOT NULL, /* 직원지점명 */
	ENAME VARCHAR2(20) NOT NULL, /* 직원이름 */
	DEPTNO VARCHAR2(3) NOT NULL /* 부서번호 */
);

COMMENT ON TABLE SCOTT.BANK_EMP IS '은행직원';

COMMENT ON COLUMN SCOTT.BANK_EMP.EMPNO IS '직원번호';

COMMENT ON COLUMN SCOTT.BANK_EMP.BRANCH_NM IS '지점번호';

COMMENT ON COLUMN SCOTT.BANK_EMP.ENAME IS '직원이름';

COMMENT ON COLUMN SCOTT.BANK_EMP.DEPTNO IS '부서번호';

CREATE UNIQUE INDEX SCOTT.PK_BANK_EMP
	ON SCOTT.BANK_EMP (
		EMPNO ASC
	);

ALTER TABLE SCOTT.BANK_EMP
	ADD
		CONSTRAINT PK_BANK_EMP
		PRIMARY KEY (
			EMPNO
		);
alter table bank_emp add (pw VARCHAR(20));

/* 현금흐름표 */
CREATE TABLE SCOTT.CASH_FLOW (
	TURN NUMBER NOT NULL, /* 회차 */
	BIZR_NO VARCHAR2(40) NOT NULL, /* 사업자등록번호 */
	SALES_CF NUMBER, /* 영업활동현금흐름 */
	FIN_CF NUMBER, /* 재무활동현금흐름*/
	INVST_CF NUMBER /* 투자활동현금흐름 */
);

COMMENT ON TABLE SCOTT.CASH_FLOW IS '현금흐름표';

COMMENT ON COLUMN SCOTT.CASH_FLOW.TURN IS '회차';

COMMENT ON COLUMN SCOTT.CASH_FLOW.BIZR_NO IS '사업자등록번호';

COMMENT ON COLUMN SCOTT.CASH_FLOW.SALES_CF IS '영업활동현금흐름';

COMMENT ON COLUMN SCOTT.CASH_FLOW.FIN_CF IS '투자활동현금흐름';

COMMENT ON COLUMN SCOTT.CASH_FLOW.INVST_CF IS '재무활동현금흐름';

CREATE UNIQUE INDEX SCOTT.PK_CASH_FLOW
	ON SCOTT.CASH_FLOW (
		TURN ASC,
		BIZR_NO ASC
	);

ALTER TABLE SCOTT.CASH_FLOW
	ADD
		CONSTRAINT PK_CASH_FLOW
		PRIMARY KEY (
			TURN,
			BIZR_NO
		);

/* 코드 */
CREATE TABLE SCOTT.CODE (
	ATT VARCHAR2(20) NOT NULL, /* 속성 */
	CODE VARCHAR2(20) NOT NULL, /* 코드 */
	TBL VARCHAR2(20) NOT NULL, /* 테이블 */
	NAME VARCHAR2(100) NOT NULL /* 코드이름 */
);

COMMENT ON TABLE SCOTT.CODE IS '코드';

COMMENT ON COLUMN SCOTT.CODE.ATT IS '속성';

COMMENT ON COLUMN SCOTT.CODE.CODE IS '코드';

COMMENT ON COLUMN SCOTT.CODE.TBL IS '테이블';

COMMENT ON COLUMN SCOTT.CODE.NAME IS '코드이름';

CREATE UNIQUE INDEX SCOTT.PK_CODE
	ON SCOTT.CODE (
		ATT ASC,
		CODE ASC
	);

ALTER TABLE SCOTT.CODE
	ADD
		CONSTRAINT PK_CODE
		PRIMARY KEY (
			ATT,
			CODE
		);

/* 기업 */
CREATE TABLE SCOTT.CORP (
	BIZR_NO VARCHAR2(40) NOT NULL, /* 사업자등록번호 */
	PW VARCHAR2(20) NOT NULL, /* 비밀번호 */
	name VARCHAR2(100) NOT NULL, /* 기업체명 */
	name_eng VARCHAR2(50), /* 기업체영문명 */
	JURIR_NO VARCHAR2(13), /* 법인등록번호 */
	corp_cls VARCHAR2(2), /* 법인구분 */
	INDUTY_CODE VARCHAR2(6), /* 업종 */
	ADRES VARCHAR2(200), /* 주소 */
	hm_url VARCHAR2(100), /* 홈페이지 */
	country_code VARCHAR2(5), /* 전화번호 국가코드 */
	PHN_NO VARCHAR2(40), /* 전화번호 */
	country_code_fax VARCHAR2(5), /* 팩스번호 국가코드 */
	FAX_NO VARCHAR2(40), /* 팩스번호 */
	EST_DT DATE, /* 설립일 */
	acc_mt VARCHAR2(2) /* 결재월 */
);

COMMENT ON TABLE SCOTT.CORP IS '기업';

COMMENT ON COLUMN SCOTT.CORP.BIZR_NO IS '사업자등록번호';

COMMENT ON COLUMN SCOTT.CORP.PW IS '비밀번호';

COMMENT ON COLUMN SCOTT.CORP.name IS '기업체명';

COMMENT ON COLUMN SCOTT.CORP.name_eng IS '기업체영문명';

COMMENT ON COLUMN SCOTT.CORP.JURIR_NO IS '법인등록번호';

COMMENT ON COLUMN SCOTT.CORP.corp_cls IS '법인구분';

COMMENT ON COLUMN SCOTT.CORP.INDUTY_CODE IS '업종';

COMMENT ON COLUMN SCOTT.CORP.ADRES IS '주소';

COMMENT ON COLUMN SCOTT.CORP.hm_url IS '홈페이지';

COMMENT ON COLUMN SCOTT.CORP.country_code IS '전화번호 국가코드';

COMMENT ON COLUMN SCOTT.CORP.PHN_NO IS '연락처';

COMMENT ON COLUMN SCOTT.CORP.country_code_fax IS '팩스번호 국가코드';

COMMENT ON COLUMN SCOTT.CORP.FAX_NO IS '팩스';

COMMENT ON COLUMN SCOTT.CORP.EST_DT IS '설립일';

COMMENT ON COLUMN SCOTT.CORP.acc_mt IS '결재월';

CREATE UNIQUE INDEX SCOTT.PK_CORP
	ON SCOTT.CORP (
		BIZR_NO ASC
	);

ALTER TABLE SCOTT.CORP
	ADD
		CONSTRAINT PK_CORP
		PRIMARY KEY (
			BIZR_NO
		);

/* 신용등급이력 */
CREATE TABLE SCOTT.CREDIT_RANK_HISTORY (
	BIZR_NO VARCHAR2(40) NOT NULL, /* 사업자등록번호 */
	FNC_STMT_DATE DATE, /* 재무기준일 */
	CREDIT_RNK VARCHAR2(3) NOT NULL, /* 신용등급 */
	RNK_DATE DATE NOT NULL /* 산정일 */
);

COMMENT ON TABLE SCOTT.CREDIT_RANK_HISTORY IS '신용등급이력';

COMMENT ON COLUMN SCOTT.CREDIT_RANK_HISTORY.BIZR_NO IS '사업자등록번호';

COMMENT ON COLUMN SCOTT.CREDIT_RANK_HISTORY.FNC_STMT_DATE IS '재무기준일';

COMMENT ON COLUMN SCOTT.CREDIT_RANK_HISTORY.CREDIT_RNK IS '신용등급';

COMMENT ON COLUMN SCOTT.CREDIT_RANK_HISTORY.RNK_DATE IS '산정일';

CREATE UNIQUE INDEX SCOTT.PK_CREDIT_RANK_HISTORY
	ON SCOTT.CREDIT_RANK_HISTORY (
		BIZR_NO ASC,
		RNK_DATE ASC
	);

ALTER TABLE SCOTT.CREDIT_RANK_HISTORY
	ADD
		CONSTRAINT PK_CREDIT_RANK_HISTORY
		PRIMARY KEY (
			BIZR_NO,
			RNK_DATE
		);


/* 재무상태표 */
CREATE TABLE SCOTT.FS_STATUS (
	TURN NUMBER NOT NULL, /* 회차 */
	BIZR_NO VARCHAR2(40) NOT NULL, /* 사업자등록번호 */
	CURR_AST NUMBER, /* 유동자산 */
	NON_CURR_AST NUMBER, /* 비유동자산 */
	TTL_AST NUMBER, /* 자산총계 */
	CURR_LIAB NUMBER, /* 유동부채 */
	NON_CURR_LIAB NUMBER, /* 비유동부채 */
	TTL_LIAB NUMBER, /* 부채총계 */
	CAPITAL NUMBER, /* 자본 */
	ERND_SPLUS NUMBER, /* 이익잉여금 */
	TTL_CAPITAL NUMBER /* 자본총계 */
);

COMMENT ON TABLE SCOTT.FS_STATUS IS '재무상태표';

COMMENT ON COLUMN SCOTT.FS_STATUS.TURN IS '회차';

COMMENT ON COLUMN SCOTT.FS_STATUS.BIZR_NO IS '사업자등록번호';

COMMENT ON COLUMN SCOTT.FS_STATUS.CURR_AST IS '유동자산';

COMMENT ON COLUMN SCOTT.FS_STATUS.NON_CURR_AST IS '비유동자산';

COMMENT ON COLUMN SCOTT.FS_STATUS.TTL_AST IS '자산총계';

COMMENT ON COLUMN SCOTT.FS_STATUS.CURR_LIAB IS '유동부채';

COMMENT ON COLUMN SCOTT.FS_STATUS.NON_CURR_LIAB IS '비유동부채';

COMMENT ON COLUMN SCOTT.FS_STATUS.TTL_LIAB IS '부채총계';

COMMENT ON COLUMN SCOTT.FS_STATUS.CAPITAL IS '자본';

COMMENT ON COLUMN SCOTT.FS_STATUS.ERND_SPLUS IS '이익잉여금';

COMMENT ON COLUMN SCOTT.FS_STATUS.TTL_CAPITAL IS '자본총계';

CREATE UNIQUE INDEX SCOTT.PK_FS_STATUS
	ON SCOTT.FS_STATUS (
		TURN ASC,
		BIZR_NO ASC
	);

ALTER TABLE SCOTT.FS_STATUS
	ADD
		CONSTRAINT PK_FS_STATUS
		PRIMARY KEY (
			TURN,
			BIZR_NO
		);

/* 손익계산서 */
CREATE TABLE SCOTT.ICM_STMT (
	TURN NUMBER NOT NULL, /* 회차 */
	BIZR_NO VARCHAR2(40) NOT NULL, /* 사업자등록번호 */
	SALES NUMBER, /* 매출액 */
	BUSI_PROFITS NUMBER, /* 영업이익 */
	NET_INCM NUMBER /* 당기순이익 */
);

COMMENT ON TABLE SCOTT.ICM_STMT IS '손익계산서';

COMMENT ON COLUMN SCOTT.ICM_STMT.TURN IS '회차';

COMMENT ON COLUMN SCOTT.ICM_STMT.BIZR_NO IS '사업자등록번호';

COMMENT ON COLUMN SCOTT.ICM_STMT.SALES IS '매출액';

COMMENT ON COLUMN SCOTT.ICM_STMT.BUSI_PROFITS IS '영업이익';

COMMENT ON COLUMN SCOTT.ICM_STMT.NET_INCM IS '당기순이익';

CREATE UNIQUE INDEX SCOTT.PK_ICM_STMT
	ON SCOTT.ICM_STMT (
		TURN ASC,
		BIZR_NO ASC
	);

ALTER TABLE SCOTT.ICM_STMT
	ADD
		CONSTRAINT PK_ICM_STMT
		PRIMARY KEY (
			TURN,
			BIZR_NO
		);

alter table icm_stmt add (issue_date date);
alter table cash_flow add (issue_date date);
alter table fs_status add (issue_date date);


/* 신청서류 */
CREATE TABLE SCOTT.LOAN_DOC (
	loan_doc_no NUMBER primary key,
	APP_NO NUMBER, /* 신청번호 */
	doc_no NUMBER NOT NULL /* 서류번호 */
);

COMMENT ON TABLE SCOTT.LOAN_DOC IS '신청서류';

COMMENT ON COLUMN SCOTT.LOAN_DOC.APP_NO IS '신청번호';

COMMENT ON COLUMN SCOTT.LOAN_DOC.doc_no IS '서류종류';

CREATE UNIQUE INDEX SCOTT.PK_LOAN_DOC2
	ON SCOTT.LOAN_DOC (
		loan_doc_no asc
	);

alter table loan_doc add constraint FK_LOAN_DOC_TO_DOC foreign key (doc_no) references doc (doc_no) on delete set null;

/* 대출심사 */
CREATE TABLE SCOTT.LOAN_EVAL (
	APP_NO NUMBER NOT NULL, /* 신청번호 */
	EVAL_DATE DATE default sysdate, /* 심사일 */
	EVAL_RESULT VARCHAR2(2) NOT NULL, /* 심사결과 */
	EVAL_COMMENT VARCHAR2(300) /* 심사코멘트 */
);

COMMENT ON TABLE SCOTT.LOAN_EVAL IS '대출심사';

COMMENT ON COLUMN SCOTT.LOAN_EVAL.APP_NO IS '신청번호';

COMMENT ON COLUMN SCOTT.LOAN_EVAL.EVAL_STEP IS '심사단계';

COMMENT ON COLUMN SCOTT.LOAN_EVAL.EVAL_DATE IS '심사일';

COMMENT ON COLUMN SCOTT.LOAN_EVAL.EVAL_RESULT IS '심사결과';

COMMENT ON COLUMN SCOTT.LOAN_EVAL.EVAL_COMMENT IS '심사코멘트';

CREATE UNIQUE INDEX SCOTT.PK_LOAN_EVAL
	ON SCOTT.LOAN_EVAL (
		APP_NO ASC
	);

ALTER TABLE SCOTT.LOAN_EVAL
	ADD
		CONSTRAINT PK_LOAN_EVAL
		PRIMARY KEY (
			APP_NO
		);

		/* 대출이력 */
		CREATE TABLE SCOTT.LOAN_HISTORY (
			LOAN_NO VARCHAR2(7) primary key, /* 대출번호 */
			loan_type VARCHAR2(2) NOT NULL, /* 대출유형 */
			START_DATE DATE NOT NULL, /* 시작일 */
			FIN_DATE DATE NOT NULL, /* 만기일 */
			PCPL_AMT NUMBER NOT NULL, /* 원금 */
			INTEREST NUMBER NOT NULL, /* 최종금리 */
			loan_acnt VARCHAR2(13) NOT NULL, /* 대출계좌 */
			interest_acnt VARCHAR2(13) NOT NULL, /* 이자납부계좌 */
			interest_date NUMBER NOT NULL, /* 이자납부일 */
			ass_type VARCHAR2(100), /* 담보유형 */
			loan_status VARCHAR2(2) NOT NULL, /* 상태 */
			EMPNO VARCHAR2(6) NOT NULL, /* 직원번호 */
			PROD_NO VARCHAR2(10) NOT NULL, /* 대출상품번호 */
			BIZR_NO VARCHAR2(40) NOT NULL, /* 사업자등록번호 */
		  left_amt NUMBER, /* 잔금 */
			auto_interest_trans varchar2(1), /* 자동이체여부 */
			focus_loan varchar2(1) default 'N' /* 관심대출 여부 */
		);


CREATE UNIQUE INDEX SCOTT.PK_LOAN_HISTORY
	ON SCOTT.LOAN_HISTORY (
		LOAN_NO ASC
	);


/* 대출상품 */
CREATE TABLE SCOTT.LOAN_PROD (
	PROD_NO VARCHAR2(10) NOT NULL, /* 대출상품번호 */
	term_mom varchar(1500) NOT NULL, /* 대출기간(년) */
	NAME VARCHAR2(100) NOT NULL, /* 상품명 */
	OBJECT VARCHAR2(1500) NOT NULL, /* 대상 */
	interest NUMBER NOT NULL, /* 최저금리 */
	limit varchar2(1500) NOT NULL, /* 한도 */
	interest_cal_mtd VARCHAR2(1500), /* 이자계산방법 */
	cancle_re_mtd VARCHAR2(1500), /* 계약해지/갱신방법 */
	rep_type VARCHAR2(1500), /* 상환방식 */
	rep_mtd VARCHAR2(1500), /* 원리금 상환방법 */
	notice VARCHAR2(1500), /* 유의사항 */
	MID_RPY_FEE_RATE NUMBER /* 중도상환수수료율 */
);

COMMENT ON TABLE SCOTT.LOAN_PROD IS '대출상품';

COMMENT ON COLUMN SCOTT.LOAN_PROD.PROD_NO IS '대출상품번호';

COMMENT ON COLUMN SCOTT.LOAN_PROD.TERM_year IS '기준개월수';

COMMENT ON COLUMN SCOTT.LOAN_PROD.NAME IS '상품명';

COMMENT ON COLUMN SCOTT.LOAN_PROD.OBJECT IS '대상';

COMMENT ON COLUMN SCOTT.LOAN_PROD.interest IS '기준금리상한선';

COMMENT ON COLUMN SCOTT.LOAN_PROD.limit IS '기준한도';

COMMENT ON COLUMN SCOTT.LOAN_PROD.interest_cal_mtd IS '이자계산방법';

COMMENT ON COLUMN SCOTT.LOAN_PROD.cancle_re_mtd IS '계약해지/갱신방법';

COMMENT ON COLUMN SCOTT.LOAN_PROD.rep_type IS '상환방식';

COMMENT ON COLUMN SCOTT.LOAN_PROD.rep_mtd IS '상환방법';

COMMENT ON COLUMN SCOTT.LOAN_PROD.notice IS '유의사항';

COMMENT ON COLUMN SCOTT.LOAN_PROD.MID_RPY_FEE_RATE IS '중도상환수수료율';

CREATE UNIQUE INDEX SCOTT.PK_LOAN_PROD
	ON SCOTT.LOAN_PROD (
		PROD_NO ASC
	);

ALTER TABLE SCOTT.LOAN_PROD
	ADD
		CONSTRAINT PK_LOAN_PROD
		PRIMARY KEY (
			PROD_NO
		);

/* 대출신청 */
CREATE TABLE SCOTT.LOAN_APP (
	APP_NO NUMBER primary key, /* 신청번호 */
	loan_type VARCHAR2(2) NOT NULL, /* 대출유형 */
	loan_acnt VARCHAR2(13), /* 대출계좌 */
	interest_acnt VARCHAR2(13), /* 이자납부계좌 */
	ass_type VARCHAR2(100), /* 담보유형 */
	branch_nm VARCHAR2(100), /* 지점명 */
	app_date DATE default sysdate, /* 신청일 */
	APP_AMOUNT NUMBER NOT NULL, /* 신청금액 */
	APP_month NUMBER NOT NULL, /* 신청개월수 */
	loan_app_status VARCHAR2(2) default 'FW', /* 상태 */
	PROD_NO VARCHAR2(10) NOT NULL, /* 대출상품번호 */
	EMPNO VARCHAR2(6) NOT NULL, /* 직원번호 */
	BIZR_NO VARCHAR2(40) NOT NULL, /* 사업자등록번호 */
	auto_interest_trans varchar2(1), /* 자동이체여부 */
	interest_date NUMBER /* 이자 자동 납부일 */
);

COMMENT ON TABLE SCOTT.LOAN_APP IS '대출승인대기';

COMMENT ON COLUMN SCOTT.LOAN_APP.APP_NO IS '신청번호';

COMMENT ON COLUMN SCOTT.LOAN_APP.loan_type IS '대출유형';

COMMENT ON COLUMN SCOTT.LOAN_APP.loan_acnt IS '대출계좌';

COMMENT ON COLUMN SCOTT.LOAN_APP.interest_acnt IS '이자납부계좌';

COMMENT ON COLUMN SCOTT.LOAN_APP.ass_type IS '담보유형';

COMMENT ON COLUMN SCOTT.LOAN_APP.branch_nm IS '지점명';

COMMENT ON COLUMN SCOTT.LOAN_APP.app_date IS '신청일';

COMMENT ON COLUMN SCOTT.LOAN_APP.APP_AMOUNT IS '신청금액';

COMMENT ON COLUMN SCOTT.LOAN_APP.APP_MON IS '신청개월수';

COMMENT ON COLUMN SCOTT.LOAN_APP.loan_app_status IS '상태';

COMMENT ON COLUMN SCOTT.LOAN_APP.PROD_NO IS '대출상품번호';

COMMENT ON COLUMN SCOTT.LOAN_APP.EMPNO IS '직원번호';

COMMENT ON COLUMN SCOTT.LOAN_APP.BIZR_NO IS '사업자등록번호';

CREATE UNIQUE INDEX SCOTT.PK_LOAN_WAITING
	ON SCOTT.LOAN_APP (
		APP_NO ASC
	);


create sequence seq_loan_app_no nocache;


/* 대표자 */
CREATE TABLE SCOTT.REP (
	REP_NAME VARCHAR2(200), /* 대표자명 */
	BIZR_NO VARCHAR2(40), /* 사업자등록번호 */
    constraint fk_corp_to_rep foreign key (bizr_no) references corp (bizr_no) on delete cascade
    , constraint pk_rep primary key (bizr_no, rep_name)
);

COMMENT ON TABLE SCOTT.REP IS '대표자';

COMMENT ON COLUMN SCOTT.REP.REP_NAME IS '대표자명';

COMMENT ON COLUMN SCOTT.REP.BIZR_NO IS '사업자등록번호';

CREATE UNIQUE INDEX SCOTT.PK_REP
	ON SCOTT.REP (
		REP_NAME ASC,
		BIZR_NO ASC
	);


/* 상환이력 */
/*
CREATE TABLE SCOTT.RPY_HISTORY (
	MID_RPY DATE NOT NULL,
	LOAN_NO VARCHAR2(7) NOT NULL,
	MID_RPY_AMT NUMBER NOT NULL,
	MID_RPY_FEE NUMBER
);

COMMENT ON TABLE SCOTT.RPY_HISTORY IS '상환이력';

COMMENT ON COLUMN SCOTT.RPY_HISTORY.MID_RPY IS '중도상환일';

COMMENT ON COLUMN SCOTT.RPY_HISTORY.LOAN_NO IS '대출번호';

COMMENT ON COLUMN SCOTT.RPY_HISTORY.MID_RPY_AMT IS '중도상환금액';

COMMENT ON COLUMN SCOTT.RPY_HISTORY.MID_RPY_FEE IS '중도상환수수료';

CREATE UNIQUE INDEX SCOTT.PK_RPY_HISTORY
	ON SCOTT.RPY_HISTORY (
		MID_RPY ASC,
		LOAN_NO ASC
	);

ALTER TABLE SCOTT.RPY_HISTORY
	ADD
		CONSTRAINT PK_RPY_HISTORY
		PRIMARY KEY (
			MID_RPY,
			LOAN_NO
		);

alter table rpy_history modify (mid_rpy default sysdate);
alter table rpy_history modify (mid_rpy_fee default 0);
*/
/* 상환이력 (수정후) */
CREATE TABLE SCOTT.rpy_history (
	rep_no 					varchar2(7) PRIMARY key,
	MID_RPY_date 		DATE default sysdate,
	LOAN_NO 				VARCHAR2(7) NOT NULL,
	MID_RPY_AMT 		NUMBER NOT NULL,
	MID_RPY_FEE	 		NUMBER default 0,
    balance             NUMBER,
	constraint fk_loan_his_to_rpy_his foreign key (loan_no) references loan_history(loan_no) on delete cascade
);

create sequence seq_rpy_no nocache;

/* 세무사 인증 */
CREATE TABLE SCOTT.acc_auth (
	BIZR_NO VARCHAR2(40) NOT NULL, /* 사업자등록번호 */
	ACC_NO VARCHAR2(7) NOT NULL, /* 세무사등록번호 */
	auth_req_date DATE, /* 인증요청일 */
	auth_date DATE, /* 인증완료일 */
	auth_status VARCHAR2(2) NOT NULL /* 인증상태 */
);

COMMENT ON TABLE SCOTT.acc_auth IS '세무사 인증';

COMMENT ON COLUMN SCOTT.acc_auth.BIZR_NO IS '사업자등록번호';

COMMENT ON COLUMN SCOTT.acc_auth.ACC_NO IS '세무사등록번호';

COMMENT ON COLUMN SCOTT.acc_auth.auth_req_date IS '인증요청일';

COMMENT ON COLUMN SCOTT.acc_auth.auth_date IS '인증완료일';

COMMENT ON COLUMN SCOTT.acc_auth.auth_status IS '인증상태';

CREATE UNIQUE INDEX SCOTT.PK_acc_auth
	ON SCOTT.acc_auth (
		BIZR_NO ASC,
		ACC_NO ASC
	);

ALTER TABLE SCOTT.acc_auth
	ADD
		CONSTRAINT PK_acc_auth
		PRIMARY KEY (
			BIZR_NO,
			ACC_NO
		);


/* 서류 */
CREATE TABLE SCOTT.DOC (
	doc_no number NOT NULL, /* 서류번호 */
	doc_type VARCHAR2(100), /* 서류종류 */
	exp_date DATE, /* 만료일 => issue_date 발급일 */
	doc_ori_name VARCHAR2(300), /* 서류이름 */
	doc_save_name VARCHAR2(300), /* 서류저장이름 */
	uploader VARCHAR2(100), /* 제출인 */
	doc_size NUMBER, /* 서류크기 */
	uld_date DATE, /* 제출일 */
	BIZR_NO VARCHAR2(40) /* 사업자등록번호 */
);

COMMENT ON TABLE SCOTT.DOC IS '서류';

COMMENT ON COLUMN SCOTT.DOC.doc_no IS '서류번호';

COMMENT ON COLUMN SCOTT.DOC.doc_type IS '서류종류';

COMMENT ON COLUMN SCOTT.DOC.exp_date IS '만료일';

COMMENT ON COLUMN SCOTT.DOC.doc_ori_name IS '서류이름';

COMMENT ON COLUMN SCOTT.DOC.doc_save_name IS '서류저장이름';

COMMENT ON COLUMN SCOTT.DOC.uploader IS '제출인';

COMMENT ON COLUMN SCOTT.DOC.doc_size IS '서류크기';

COMMENT ON COLUMN SCOTT.DOC.uld_date IS '제출일';

COMMENT ON COLUMN SCOTT.DOC.BIZR_NO IS '사업자등록번호';

CREATE UNIQUE INDEX SCOTT.PK_DOC
	ON SCOTT.DOC (
		doc_no ASC
	);

ALTER TABLE SCOTT.DOC
	ADD
		CONSTRAINT PK_DOC
		PRIMARY KEY (
			doc_no
		);

create sequence seq_doc_no nocache;
alter table doc modify (uld_date default sysdate);
alter table doc rename column exp_date to issue_date;
alter table doc modify (uld_date default sysdate);

/* 계좌 */
CREATE TABLE SCOTT.ACNT (
	no VARCHAR2(13) NOT NULL, /* 계좌번호 */
	balance NUMBER, /* 잔액 */
	nickname VARCHAR2(30), /* 별명 */
	reg_date DATE default sysdate, /* 등록일 */
	BIZR_NO VARCHAR2(40) NOT NULL /* 계좌주 */
);



COMMENT ON TABLE SCOTT.ACNT IS '계좌';

COMMENT ON COLUMN SCOTT.ACNT.no IS '계좌번호';

COMMENT ON COLUMN SCOTT.ACNT.balance IS '잔액';

COMMENT ON COLUMN SCOTT.ACNT.nickname IS '별명';

COMMENT ON COLUMN SCOTT.ACNT.reg_date IS '등록일';

COMMENT ON COLUMN SCOTT.ACNT.BIZR_NO IS '계좌주';

CREATE UNIQUE INDEX SCOTT.PK_ACNT
	ON SCOTT.ACNT (
		no ASC
	);

ALTER TABLE SCOTT.ACNT
	ADD
		CONSTRAINT PK_ACNT
		PRIMARY KEY (
			no
		);

alter table acnt modify (balance default 0);
alter table acnt modify (balance not null);
alter table acnt add (valid varchar2(2) default 'V');/* 효력이 있는 계좌인지 여부 */

/* 질문답변게시판 */
CREATE TABLE SCOTT.QNA (
	code number(5), /* 게시글번호 */
	originno number(5), /* 원글번호 */
	groupord number(5), /* 그룹내순서 */
	grouplayer number(5), /* 그룹계층 */
	title VARCHAR2(1000), /* 제목 */
	content VARCHAR2(2000), /* 내용 */
	reg_date DATE, /* 등록일 */
	secret VARCHAR2(5), /* 비밀글 */
	BIZR_NO VARCHAR2(40) /* 글쓴이 */
);

COMMENT ON TABLE SCOTT.QNA IS '질문답변게시판';

COMMENT ON COLUMN SCOTT.QNA.code IS '게시글번호';

COMMENT ON COLUMN SCOTT.QNA.originno IS '원글번호';

COMMENT ON COLUMN SCOTT.QNA.groupord IS '그룹내순서';

COMMENT ON COLUMN SCOTT.QNA.grouplayer IS '그룹계층';

COMMENT ON COLUMN SCOTT.QNA.title IS '제목';

COMMENT ON COLUMN SCOTT.QNA.content IS '내용';

COMMENT ON COLUMN SCOTT.QNA.reg_date IS '등록일';

COMMENT ON COLUMN SCOTT.QNA.secret IS '비밀글';

COMMENT ON COLUMN SCOTT.QNA.BIZR_NO IS '글쓴이';

/* 업종코드 */
CREATE TABLE SCOTT.induty_code (
	COL VARCHAR2(10) NOT NULL, /* 코드 */
	COL3 VARCHAR2(100) /* 업종 */
);

COMMENT ON TABLE SCOTT.induty_code IS '업종코드';

COMMENT ON COLUMN SCOTT.induty_code.COL IS '코드';

COMMENT ON COLUMN SCOTT.induty_code.COL3 IS '업종';

CREATE UNIQUE INDEX SCOTT.PK_induty_code
	ON SCOTT.induty_code (
		COL ASC
	);

ALTER TABLE SCOTT.induty_code
	ADD
		CONSTRAINT PK_induty_code
		PRIMARY KEY (
			COL
		);

/* 거래내역 */
create table transaction (
	no						varchar2(13) primary key, -- 거래번호
	occur_time		date default sysdate, -- 발생날짜 및 시간
	summary				varchar2(100), -- 적요
	main_acnt_no	varchar2(13) not null, -- 거래 주체 계좌번호
	obj_acnt_no		varchar2(13), -- 거래 대상 계좌번호
	obj_name			varchar2(13), -- 보낸분/받는분
	w_amount			number(30), -- 출금액
	d_amount			number(30), -- 입금액
	corr   				varchar2(100), -- 거래점
	balance 			number not null, -- 잔액
	constraint fk_transaction_to_acnt foreign key (obj_acnt_no) references acnt (no) on delete cascade set null,
	constraint fk_transaction_to_acnt2 foreign key (main_acnt_no) references acnt (no) on delete cascade set null

)

/* 이자 납부 내역 */
create table pay_interest (
	pay_no					NUMBER primary key, /* 납부번호 */
	LOAN_NO					varchar2(7), /* 대출번호 */
	pay_amt					NUMBER,	/* 납부액 */
	pay_date				DATE default sysdate, /* 납부일 */
	next_mon_amt		NUMBER, /* 다음달 납부금액 */
	constraint fk_loan_history_to_pay_interest foreign key (loan_no) references loan_history (loan_no) on delete cascade
)




		alter table cash_flow
		    add
		        constraint fk_corp_to_cash_flow
		        foreign key (
		            bizr_no
		        )
		        references corp (
		            bizr_no
		        ) on delete cascade;




alter table icm_stmt
		add
			 constraint fk_corp_to_icm_stmt
			 foreign key (
					bizr_no
				)
				references corp (
					 bizr_no
				) on delete cascade;

ALTER TABLE SCOTT.CREDIT_RANK_HISTORY
	ADD
		CONSTRAINT FK_CORP_TO_CREDIT_RANK_HISTORY
		FOREIGN KEY (
			BIZR_NO
		)
		REFERENCES SCOTT.CORP (
			BIZR_NO
		) on delete cascade;



alter table FS_STATUS
		add
		    constraint fk_corp_to_FS_STATUS
		    foreign key (
		       bizr_no
		    )
		    references corp (
		       bizr_no
		    ) on delete cascade;


ALTER TABLE SCOTT.LOAN_DOC
	ADD
		CONSTRAINT FK_LOAN_WAITING_TO_LOAN_DOC
		FOREIGN KEY (
			APP_NO
		)
		REFERENCES SCOTT.LOAN_APP (
			APP_NO
		) on delete cascade;

ALTER TABLE SCOTT.LOAN_EVAL
	ADD
		CONSTRAINT FK_LOAN_WAITING_TO_LOAN_EVAL
		FOREIGN KEY (
			APP_NO
		)
		REFERENCES SCOTT.LOAN_APP (
			APP_NO
		) on delete cascade;

ALTER TABLE SCOTT.LOAN_HISTORY
	ADD
		CONSTRAINT FK_CORP_TO_LOAN_HISTORY
		FOREIGN KEY (
			BIZR_NO
		)
		REFERENCES SCOTT.CORP (
			BIZR_NO
		);

ALTER TABLE SCOTT.LOAN_HISTORY
	ADD
		CONSTRAINT FK_LOAN_PROD_TO_LOAN_HISTORY
		FOREIGN KEY (
			PROD_NO
		)
		REFERENCES SCOTT.LOAN_PROD (
			PROD_NO
		);

ALTER TABLE SCOTT.LOAN_HISTORY
	ADD
		CONSTRAINT FK_BANK_EMP_TO_LOAN_HISTORY
		FOREIGN KEY (
			EMPNO
		)
		REFERENCES SCOTT.BANK_EMP (
			EMPNO
		);


ALTER TABLE SCOTT.LOAN_APP
	ADD
		CONSTRAINT FK_CORP_TO_LOAN_WAITING
		FOREIGN KEY (
			BIZR_NO
		)
		REFERENCES SCOTT.CORP (
			BIZR_NO
		);

ALTER TABLE SCOTT.LOAN_APP
	ADD
		CONSTRAINT FK_LOAN_PROD_TO_LOAN_WAITING
		FOREIGN KEY (
			PROD_NO
		)
		REFERENCES SCOTT.LOAN_PROD (
			PROD_NO
		);

ALTER TABLE SCOTT.LOAN_APP
	ADD
		CONSTRAINT FK_BANK_EMP_TO_LOAN_WAITING
		FOREIGN KEY (
			EMPNO
		)
		REFERENCES SCOTT.BANK_EMP (
			EMPNO
		);

alter table loan_app add constraint fk_loan_app_to_acnt
foreign key (loan_acnt)
references acnt (no) on delete set null;


/*
ALTER TABLE SCOTT.RPY_HISTORY
	ADD
		CONSTRAINT FK_LOAN_HIS_TO_RPY_HIS
		FOREIGN KEY (
			LOAN_NO
		)
		REFERENCES SCOTT.LOAN_HISTORY (
			LOAN_NO
		) on delete cascade;
*/
ALTER TABLE SCOTT.acc_auth
	ADD
		CONSTRAINT FK_CORP_TO_acc_auth
		FOREIGN KEY (
			BIZR_NO
		)
		REFERENCES SCOTT.CORP (
			BIZR_NO
		) on delete cascade;

ALTER TABLE SCOTT.acc_auth
	ADD
		CONSTRAINT FK_ACCOUNTANT_TO_acc_auth
		FOREIGN KEY (
			ACC_NO
		)
		REFERENCES SCOTT.ACCOUNTANT (
			ACC_NO
		) on delete cascade;

ALTER TABLE SCOTT.DOC
	ADD
		CONSTRAINT FK_CORP_TO_DOC
		FOREIGN KEY (
			BIZR_NO
		)
		REFERENCES SCOTT.CORP (
			BIZR_NO
		) on delete cascade;

ALTER TABLE SCOTT.ACNT
	ADD
		CONSTRAINT FK_CORP_TO_ACNT
		FOREIGN KEY (
			BIZR_NO
		)
		REFERENCES SCOTT.CORP (
			BIZR_NO
		) on delete cascade;

ALTER TABLE SCOTT.QNA
	ADD
		CONSTRAINT FK_CORP_TO_QNA
		FOREIGN KEY (
			BIZR_NO
		)
		REFERENCES SCOTT.CORP (
			BIZR_NO
		);

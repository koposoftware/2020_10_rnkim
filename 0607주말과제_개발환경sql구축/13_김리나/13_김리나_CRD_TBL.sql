/* 기업 */
CREATE TABLE Corp (
	corp_id        	VARCHAR2(12)    NOT NULL, /* 기업아이디 */
	corp_name  			VARCHAR2(100)   NOT NULL, /* 기업체한글명 */
	corp_name_eng  	VARCHAR2(50),             /* 기업체영문명 */
	corp_cls      	VARCHAR2(20)    NOT NULL, /* 법인구분 */
	jurir_no   			VARCHAR2(13)    NOT NULL, /* 법인등록번호 */
	bizr_no   			VARCHAR2(10)    NOT NULL, /* 사업자등록번호 */
	adres        		VARCHAR2(200)   NOT NULL, /* 주소 */
	hm_rul        	VARCHAR2(100),            /* 홈페이지 */
	phn_no          VARCHAR2(13)    NOT NULL, /* 연락처 */
	fax_no          VARCHAR2(13),             /* 팩스 */
	induty_code     VARCHAR2(4)    NOT NULL, /* 업종 */
	est_dt     			DATE            NOT NULL, /* 설립일 */
	pw             	VARCHAR2(12)    NOT NULL, /* 비밀번호 */
	acc_no         	VARCHAR2(7)     NOT NULL /* 세무사등록번호 */
);

CREATE UNIQUE INDEX PK_Corp
	ON Corp (
		corp_id ASC
	);

	ALTER TABLE Corp
		ADD
			CONSTRAINT PK_Corp
			PRIMARY KEY (
				corp_id
			);

-- 테이블 Comment 설정
COMMENT ON TABLE Corp IS '기업';

COMMENT ON COLUMN Corp.corp_id IS '기업아이디';

COMMENT ON COLUMN Corp.corp_name IS '기업체명';

COMMENT ON COLUMN Corp.corp_name_eng IS '기업체영문명';

COMMENT ON COLUMN Corp.corp_cls IS '법인구분';

COMMENT ON COLUMN Corp.jurir_no IS '법인등록번호';

COMMENT ON COLUMN Corp.bizr_no IS '사업자등록번호';

COMMENT ON COLUMN Corp.adres IS '주소';

COMMENT ON COLUMN Corp.hm_rul IS '홈페이지';

COMMENT ON COLUMN Corp.phn_no IS '연락처';

COMMENT ON COLUMN Corp.fax_no IS '팩스';

COMMENT ON COLUMN Corp.induty_code IS '업종';

COMMENT ON COLUMN Corp.est_dt IS '설립일';

COMMENT ON COLUMN Corp.pw IS '비밀번호';

COMMENT ON COLUMN Corp.acc_no IS '세무사등록번호';

/* 대출이력 */
CREATE TABLE Loan_history (
	loan_no      VARCHAR2(6)     NOT NULL, /* 대출번호 */
	start_date   DATE            NOT NULL, /* 기준일 */
	fin_mon      NUMBER		       NOT NULL, /* 최종개월수 */
	rep_rate     NUMBER			     DEFAULT 0, /* 상환률 */
	pcpl_amt   	 NUMBER          NOT NULL, /* 대출금액 */
	fin_interest NUMBER			     NOT NULL, /* 최종금리 */
	left_amt		 NUMBER         NOT NULL, /* 잔금 */
	empno        VARCHAR2(6)     NOT NULL, /* 직원번호 */
	prod_no      VARCHAR2(3)     NOT NULL, /* 대출상품번호 */
	corp_id      VARCHAR2(12)    NOT NULL, /* 기업아이디 */
	loan_type    VARCHAR2(20)    NOT NULL  /* 대출구분 */
);

CREATE UNIQUE INDEX PK_Loan_history
	ON Loan_history (
		loan_no ASC
	);

	ALTER TABLE Loan_history
		ADD
			CONSTRAINT PK_Loan_history
			PRIMARY KEY (
				loan_no
			);

COMMENT ON TABLE Loan_history IS '대출이력';

COMMENT ON COLUMN Loan_history.loan_no IS '대출번호';

COMMENT ON COLUMN Loan_history.start_date IS '기준일';

COMMENT ON COLUMN Loan_history.fin_mon IS '최종개월수';

COMMENT ON COLUMN Loan_history.rep_rate IS '상환률';

COMMENT ON COLUMN Loan_history.pcpl_amt IS '대출금액';

COMMENT ON COLUMN Loan_history.fin_interest IS '최종금리';

COMMENT ON COLUMN Loan_history.left_amt IS '잔금';

COMMENT ON COLUMN Loan_history.empno IS '직원번호';

COMMENT ON COLUMN Loan_history.prod_no IS '대출상품번호';

COMMENT ON COLUMN Loan_history.corp_id IS '기업아이디';

COMMENT ON COLUMN Loan_history.loan_type IS '대출구분';

/* 대출상품 */
CREATE TABLE Loan_prod (
	prod_no            VARCHAR2(3)     NOT NULL, /* 대출상품번호 */
	loan_type          VARCHAR2(20)    NOT NULL, /* 대출구분 */
	term_mon           NUMBER         NOT NULL, /* 기준개월수 */
	name               VARCHAR2(100)   NOT NULL, /* 상품명 */
	object             VARCHAR2(100)   NOT NULL, /* 대상 */
	org_interest_low   NUMBER          NOT NULL, /* 기준금리하한선 */
	org_interest_high  NUMBER          NOT NULL, /* 기준금리상한선 */
	org_limit          NUMBER			     NOT NULL, /* 기준한도 */
	rep_method         VARCHAR2(100)   NOT NULL, /* 상환방법 */
	mid_rpy_fee_rate   NUMBER          DEFAULT 0 /* 중도상환수수료율 */
);

ALTER TABLE Loan_prod
	ADD
		CONSTRAINT PK_Loan_prod
		PRIMARY KEY (
			prod_no,
			loan_type
		);

COMMENT ON TABLE Loan_prod IS '대출상품';

COMMENT ON COLUMN Loan_prod.prod_no IS '대출상품번호';

COMMENT ON COLUMN Loan_prod.loan_type IS '대출구분';

COMMENT ON COLUMN Loan_prod.term_mon IS '기준개월수';

COMMENT ON COLUMN Loan_prod.name IS '상품명';

COMMENT ON COLUMN Loan_prod.object IS '대상';

COMMENT ON COLUMN Loan_prod.org_interest_low IS '기준금리하한선';

COMMENT ON COLUMN Loan_prod.org_interest_high IS '기준금리상한선';

COMMENT ON COLUMN Loan_prod.org_limit IS '기준한도';

COMMENT ON COLUMN Loan_prod.rep_method IS '상환방법';

COMMENT ON COLUMN Loan_prod.mid_rpy_fee_rate IS '중도상환수수료율';

/* 대출승인대기 */
CREATE TABLE Loan_waiting (
	app_no     VARCHAR2(6)   NOT NULL, 			  /* 신청번호 */
	approve    VARCHAR2(10)   DEFAULT '진행중', /* 승인여부 */
	app_date   DATE 				 NOT NULL,        /* 신청일 */
	app_amount NUMBER        NOT NULL,        /* 신청금액 */
	app_mon    NUMBER        NOT NULL,        /* 신청개월수 */
	corp_id    VARCHAR2(12)  NOT NULL,        /* 기업아이디 */
	prod_no    VARCHAR2(3)   NOT NULL,        /* 대출상품번호 */
	empno      VARCHAR2(6)   NOT NULL,        /* 직원번호 */
	loan_type  VARCHAR2(20)  NOT NULL         /* 대출구분 */
);

CREATE UNIQUE INDEX PK_Loan_waiting
	ON Loan_waiting (
		app_no ASC
	);

ALTER TABLE Loan_waiting
	ADD
		CONSTRAINT PK_Loan_waiting
		PRIMARY KEY (
			app_no
		);

COMMENT ON TABLE Loan_waiting IS '대출승인대기';

COMMENT ON COLUMN Loan_waiting.app_no IS '신청번호';

COMMENT ON COLUMN Loan_waiting.app_date IS '신청일';

COMMENT ON COLUMN Loan_waiting.app_amount IS '신청금액';

COMMENT ON COLUMN Loan_waiting.app_mon IS '신청개월수';

COMMENT ON COLUMN Loan_waiting.approve IS '승인여부';

COMMENT ON COLUMN Loan_waiting.corp_id IS '기업아이디';

COMMENT ON COLUMN Loan_waiting.prod_no IS '대출상품번호';

COMMENT ON COLUMN Loan_waiting.empno IS '직원번호';

COMMENT ON COLUMN Loan_waiting.loan_type IS '대출구분';

/* 신청서류 */
CREATE TABLE Loan_doc (
	app_no         VARCHAR2(6)   NOT NULL, /* 신청번호 */
	doc_type       VARCHAR2(40)  NOT NULL, /* 서류종류 */
	by_whom        VARCHAR2(20)  NOT NULL, /* 제출인 */
	upload_date    DATE          NOT NULL, /* 제출일 */
	file_name      VARCHAR2(30)  NOT NULL /* 서류이름 */
);

ALTER TABLE Loan_doc
	ADD
		CONSTRAINT PK_Loan_doc
		PRIMARY KEY (
			app_no,
			doc_type
		);

COMMENT ON TABLE Loan_doc IS '신청서류';

COMMENT ON COLUMN Loan_doc.app_no IS '신청번호';

COMMENT ON COLUMN Loan_doc.doc_type IS '서류종류';

COMMENT ON COLUMN Loan_doc.by_whom IS '제출인';

COMMENT ON COLUMN Loan_doc.upload_date IS '제출일';

COMMENT ON COLUMN Loan_doc.file_name IS '서류이름';

/* 은행직원 */
CREATE TABLE bank_emp (
	empno      VARCHAR2(6)   NOT NULL, /* 직원번호 */
	branch_no  VARCHAR2(3)   NOT NULL, /* 지점번호 */
	ename      VARCHAR2(20)  NOT NULL, /* 직원이름 */
	deptno     VARCHAR2(2)   NOT NULL, /* 부서번호 */
	title      VARCHAR2(20)  NOT NULL, /* 직급 */
	email      VARCHAR2(30)  NOT NULL, /* 이메일주소 */
	phone      VARCHAR2(13)  NOT NULL /* 연락처 */
);

CREATE UNIQUE INDEX PK_bank_emp
	ON bank_emp (
		empno ASC
	);

ALTER TABLE bank_emp
	ADD
		CONSTRAINT PK_bank_emp
		PRIMARY KEY (
			empno
		);

COMMENT ON TABLE bank_emp IS '은행직원';

COMMENT ON COLUMN bank_emp.empno IS '직원번호';

COMMENT ON COLUMN bank_emp.branch_no IS '지점번호';

COMMENT ON COLUMN bank_emp.ename IS '직원이름';

COMMENT ON COLUMN bank_emp.deptno IS '부서번호';

COMMENT ON COLUMN bank_emp.title IS '직급';

COMMENT ON COLUMN bank_emp.email IS '이메일주소';

COMMENT ON COLUMN bank_emp.phone IS '연락처';

/* 세무사 */
CREATE TABLE Accountant (
	acc_no   VARCHAR2(7)   NOT NULL, /* 세무사등록번호 */
	name     VARCHAR2(30)  NOT NULL, /* 세무사이름 */
	id       VARCHAR2(12)  NOT NULL, /* 아이디 */
	pw       VARCHAR2(12)  NOT NULL, /* 비밀번호 */
	phone    VARCHAR2(13)  NOT NULL /* 연락처 */
);

CREATE UNIQUE INDEX PK_Accountant
	ON Accountant (
		acc_no ASC
	);

ALTER TABLE Accountant
	ADD
		CONSTRAINT PK_Accountant
		PRIMARY KEY (
			acc_no
		);

ALTER TABLE Accountant
	ADD
		CONSTRAINT UK_Accountant
		UNIQUE (
			id
		);

COMMENT ON TABLE Accountant IS '세무사';

COMMENT ON COLUMN Accountant.acc_no IS '세무사등록번호';

COMMENT ON COLUMN Accountant.name IS '세무사이름';

COMMENT ON COLUMN Accountant.id IS '아이디';

COMMENT ON COLUMN Accountant.pw IS '비밀번호';

COMMENT ON COLUMN Accountant.phone IS '연락처';

/* 코드 */
CREATE TABLE code (
	att    VARCHAR2(20) NOT NULL, /* 속성 */
	code   VARCHAR2(20) NOT NULL, /* 코드 */
	tbl  VARCHAR2(20) NOT NULL, /* 테이블 */
	name   VARCHAR2(100) NOT NULL /* 코드이름 */
);

ALTER TABLE code
	ADD
		CONSTRAINT PK_code
		PRIMARY KEY (
			att,
			code
		);

COMMENT ON TABLE code IS '코드';

COMMENT ON COLUMN code.att IS '속성';

COMMENT ON COLUMN code.code IS '코드';

COMMENT ON COLUMN code.tbl IS '테이블';

COMMENT ON COLUMN code.name IS '코드이름';


/* 신용등급이력 */
CREATE TABLE Credit_rank_history (
	corp_id        VARCHAR2(12)  NOT NULL, /* 기업아이디 */
	rnk_date       DATE          NOT NULL, /* 산정일 */
	fnc_stmt_date  DATE          NOT NULL, /* 재무기준일 */
	credit_rnk     VARCHAR2(3)   NOT NULL /* 신용등급 */
);

CREATE UNIQUE INDEX PK_Credit_rank_history
	ON Credit_rank_history (
		corp_id ASC,
		rnk_date ASC
	);

ALTER TABLE Credit_rank_history
	ADD
		CONSTRAINT PK_Credit_rank_history
		PRIMARY KEY (
			corp_id,
			rnk_date
		);

COMMENT ON TABLE Credit_rank_history IS '신용등급이력';

COMMENT ON COLUMN Credit_rank_history.corp_id IS '기업아이디';

COMMENT ON COLUMN Credit_rank_history.rnk_date IS '산정일';

COMMENT ON COLUMN Credit_rank_history.fnc_stmt_date IS '재무기준일';

COMMENT ON COLUMN Credit_rank_history.credit_rnk IS '신용등급';

/* 재무상태표 */
CREATE TABLE Fs_status (
	corp_id        VARCHAR2(12)    NOT NULL, /* 기업아이디 */
	turn           NUMBER          NOT NULL, /* 회차 */
	curr_ast       NUMBER          NOT NULL, /* 유동자산 */
	non_curr_ast   NUMBER          NOT NULL, /* 비유동자산 */
	ttl_ast        NUMBER          NOT NULL, /* 자산총계 */
	curr_liab      NUMBER          NOT NULL, /* 유동부채 */
	non_curr_liab  NUMBER          NOT NULL, /* 비유동부채 */
	ttl_liab       NUMBER          NOT NULL, /* 부채총계 */
	capital        NUMBER          NOT NULL, /* 자본 */
	ernd_splus     NUMBER          NOT NULL, /* 이익잉여금 */
	ttl_capital    NUMBER          NOT NULL /* 자본총계 */
);

CREATE UNIQUE INDEX PK_Fs_status
	ON Fs_status (
		corp_id ASC,
		turn ASC
	);

ALTER TABLE Fs_status
	ADD
		CONSTRAINT PK_Fs_status
		PRIMARY KEY (
			corp_id,
			turn
		);

COMMENT ON TABLE Fs_status IS '재무상태표';

COMMENT ON COLUMN Fs_status.corp_id IS '기업아이디';

COMMENT ON COLUMN Fs_status.turn IS '회차';

COMMENT ON COLUMN Fs_status.curr_ast IS '유동자산';

COMMENT ON COLUMN Fs_status.non_curr_ast IS '비유동자산';

COMMENT ON COLUMN Fs_status.ttl_ast IS '자산총계';

COMMENT ON COLUMN Fs_status.curr_liab IS '유동부채';

COMMENT ON COLUMN Fs_status.non_curr_liab IS '비유동부채';

COMMENT ON COLUMN Fs_status.ttl_liab IS '부채총계';

COMMENT ON COLUMN Fs_status.capital IS '자본';

COMMENT ON COLUMN Fs_status.ernd_splus IS '이익잉여금';

COMMENT ON COLUMN Fs_status.ttl_capital IS '자본총계';

/* 손익계산서 */
CREATE TABLE icm_stmt (
	corp_id 			VARCHAR2(12) 	NOT NULL, /* 기업아이디 */
	turn 					NUMBER    		NOT NULL, /* 회차 */
	sales 				NUMBER    		NOT NULL, /* 매출액 */
	busi_profits 	NUMBER    		NOT NULL, /* 영업이익 */
	net_incm 			NUMBER     		NOT NULL /* 당기순이익 */
);

CREATE UNIQUE INDEX PK_icm_stmt
	ON icm_stmt (
		corp_id ASC,
		turn ASC
	);

ALTER TABLE icm_stmt
	ADD
		CONSTRAINT PK_icm_stmt
		PRIMARY KEY (
			corp_id,
			turn
		);

COMMENT ON TABLE icm_stmt IS '손익계산서';

COMMENT ON COLUMN icm_stmt.corp_id IS '기업아이디';

COMMENT ON COLUMN icm_stmt.turn IS '회차';

COMMENT ON COLUMN icm_stmt.sales IS '매출액';

COMMENT ON COLUMN icm_stmt.busi_profits IS '영업이익';

COMMENT ON COLUMN icm_stmt.net_incm IS '당기순이익';

/* 재무제표 */
CREATE TABLE fnc_stmt (
	corp_id 	VARCHAR2(12) 	NOT NULL, /* 기업아이디 */
	turn 			NUMBER    		NOT NULL, /* 회차 */
	reg_date 	DATE	 				NOT NULL /* 등록일 */
);

CREATE UNIQUE INDEX PK_fnc_stmt
	ON fnc_stmt (
		corp_id ASC,
		turn ASC
	);

ALTER TABLE fnc_stmt
	ADD
		CONSTRAINT PK_fnc_stmt
		PRIMARY KEY (
			corp_id,
			turn
		);

COMMENT ON TABLE Fnc_stmt IS '재무제표';

COMMENT ON COLUMN Fnc_stmt.corp_id IS '기업아이디';

COMMENT ON COLUMN Fnc_stmt.turn IS '회차';

COMMENT ON COLUMN Fnc_stmt.reg_date IS '등록일';

/* 대표자 */
CREATE TABLE Rep (
	corp_id 	VARCHAR2(12) NOT NULL, /* 기업아이디 */
	rep_name 	VARCHAR2(20) NOT NULL /* 대표자명 */
);

CREATE UNIQUE INDEX PK_Rep
	ON Rep (
		corp_id ASC,
		rep_name ASC
	);

ALTER TABLE Rep
	ADD
		CONSTRAINT PK_Rep
		PRIMARY KEY (
			corp_id,
			rep_name
		);

COMMENT ON TABLE Rep IS '대표자';

COMMENT ON COLUMN Rep.corp_id IS '기업아이디';

COMMENT ON COLUMN Rep.rep_name IS '대표자명';

/* 현금흐름표 */
CREATE TABLE Cash_flow (
	corp_id 		VARCHAR2(12) 	NOT NULL, /* 기업아이디 */
	turn 				NUMBER    		NOT NULL, /* 회차 */
	sales_cf 		NUMBER    		NOT NULL, /* 영업활동현금흐름 */
	fin_cf 			NUMBER    		NOT NULL, /* 투자활동현금흐름 */
	invst_cf 		NUMBER    		NOT NULL /* 재무활동현금흐름 */
);

CREATE UNIQUE INDEX PK_Cash_flow
	ON Cash_flow (
		corp_id ASC,
		turn ASC
	);

ALTER TABLE Cash_flow
	ADD
		CONSTRAINT PK_Cash_flow
		PRIMARY KEY (
			corp_id,
			turn
		);

COMMENT ON TABLE Cash_flow IS '현금흐름표';

COMMENT ON COLUMN Cash_flow.corp_id IS '기업아이디';

COMMENT ON COLUMN Cash_flow.turn IS '회차';

COMMENT ON COLUMN Cash_flow.sales_cf IS '영업활동현금흐름';

COMMENT ON COLUMN Cash_flow.fin_cf IS '투자활동현금흐름';

COMMENT ON COLUMN Cash_flow.invst_cf IS '재무활동현금흐름';

/* 대출담당자 */
CREATE TABLE Loan_mgr (
	corp_id 	VARCHAR2(12) NOT NULL, /* 기업아이디 */
	name 			VARCHAR2(20) NOT NULL, /* 담당자이름 */
	phone 		VARCHAR2(13) NOT NULL /* 담당자연락처 */
);

CREATE UNIQUE INDEX PK_Loan_mgr
	ON Loan_mgr (
		corp_id ASC,
		phone ASC
	);

ALTER TABLE Loan_mgr
	ADD
		CONSTRAINT PK_Loan_mgr
		PRIMARY KEY (
			corp_id,
			phone
		);

COMMENT ON TABLE Loan_mgr IS '대출담당자';

COMMENT ON COLUMN Loan_mgr.corp_id IS '기업아이디';

COMMENT ON COLUMN Loan_mgr.name IS '담당자이름';

COMMENT ON COLUMN Loan_mgr.phone IS '담당자연락처';

/* 대출심사 */
CREATE TABLE Loan_eval (
	app_no 				VARCHAR2(6) 	NOT NULL, /* 신청번호 */
	eval_step 		NUMBER    		NOT NULL, /* 심사단계 */
	eval_date 		DATE 					NOT NULL, /* 심사일 */
	eval_result 	VARCHAR2(1) 	NOT NULL, /* 심사결과 */
	eval_comment 	VARCHAR2(100) 					/* 심사코멘트 */
);

CREATE UNIQUE INDEX PK_Loan_eval
	ON Loan_eval (
		app_no ASC,
		eval_step ASC
	);

ALTER TABLE Loan_eval
	ADD
		CONSTRAINT PK_Loan_eval
		PRIMARY KEY (
			app_no,
			eval_step
		);

COMMENT ON TABLE Loan_eval IS '대출심사';

COMMENT ON COLUMN Loan_eval.app_no IS '신청번호';

COMMENT ON COLUMN Loan_eval.eval_step IS '심사단계';

COMMENT ON COLUMN Loan_eval.eval_date IS '심사일';

COMMENT ON COLUMN Loan_eval.eval_result IS '심사결과';

COMMENT ON COLUMN Loan_eval.eval_comment IS '심사코멘트';

/* 신청시담보 */
CREATE TABLE app_assurance (
	app_no 		VARCHAR2(6) 		NOT NULL, /* 신청번호 */
	ass_name 	VARCHAR2(100) 	NOT NULL, /* 담보명 */
	ass_type 	VARCHAR2(10) 		NOT NULL, /* 담보종류 */
	guarantor VARCHAR2(50) 							/* 담보인 또는 기관 */
);

ALTER TABLE app_assurance
	ADD
		CONSTRAINT PK_app_assurance
		PRIMARY KEY (
			app_no,
			ass_name
		);

COMMENT ON TABLE app_assurance IS '신청시담보';

COMMENT ON COLUMN app_assurance.app_no IS '신청번호';

COMMENT ON COLUMN app_assurance.ass_name IS '담보명';

COMMENT ON COLUMN app_assurance.ass_type IS '담보종류';

COMMENT ON COLUMN app_assurance.guarantor IS '담보인 또는 기관';


/* 상환이력 */
CREATE TABLE rpy_history (
	mid_rpy 		DATE 				NOT NULL, /* 중도상환일 */
	loan_no 		VARCHAR2(6) NOT NULL, /* 대출번호 */
	mid_rpy_amt NUMBER    	NOT NULL, /* 중도상환금액 */
	mid_rpy_fee NUMBER    						/* 중도상환수수료 */
);

ALTER TABLE rpy_history
	ADD
		CONSTRAINT PK_rpy_history
		PRIMARY KEY (
			mid_rpy,
			loan_no
		);

COMMENT ON TABLE rpy_history IS '상환이력';

COMMENT ON COLUMN rpy_history.mid_rpy IS '중도상환일';

COMMENT ON COLUMN rpy_history.loan_no IS '대출번호';

COMMENT ON COLUMN rpy_history.mid_rpy_amt IS '중도상환금액';

COMMENT ON COLUMN rpy_history.mid_rpy_fee IS '중도상환수수료';

/* 최종담보 */
CREATE TABLE loan_assurance (
	loan_no 		VARCHAR2(6) 	NOT NULL, /* 대출번호 */
	ass_name 		VARCHAR2(100) NOT NULL, /* 담보명 */
	ass_type 		VARCHAR2(10) 	NOT NULL, /* 담보종류 */
	guarantor 	VARCHAR2(50) 						/* 담보인 또는 기관 */
);

ALTER TABLE loan_assurance
	ADD
		CONSTRAINT PK_loan_assurance
		PRIMARY KEY (
			loan_no,
			ass_name
		);

COMMENT ON TABLE loan_assurance IS '최종담보';

COMMENT ON COLUMN loan_assurance.loan_no IS '대출번호';

COMMENT ON COLUMN loan_assurance.ass_name IS '담보명';

COMMENT ON COLUMN loan_assurance.ass_type IS '담보종류';

COMMENT ON COLUMN loan_assurance.guarantor IS '담보인 또는 기관';

/* 외래키 제약조건 */

ALTER TABLE Corp
	ADD
		CONSTRAINT FK_Accountant_TO_Corp
		FOREIGN KEY (
			acc_no
		)
		REFERENCES Accountant (
			acc_no
		);

ALTER TABLE Loan_history
	ADD
		CONSTRAINT FK_bank_emp_TO_Loan_history
		FOREIGN KEY (
			empno
		)
		REFERENCES bank_emp (
			empno
		);

ALTER TABLE Loan_history
	ADD
		CONSTRAINT FK_Corp_TO_Loan_history
		FOREIGN KEY (
			corp_id
		)
		REFERENCES Corp (
			corp_id
		);

ALTER TABLE Loan_history
	ADD
		CONSTRAINT FK_Loan_prod_TO_Loan_history
		FOREIGN KEY (
			prod_no,
			loan_type
		)
		REFERENCES Loan_prod (
			prod_no,
			loan_type
		);

ALTER TABLE Loan_waiting
	ADD
		CONSTRAINT FK_Corp_TO_Loan_waiting
		FOREIGN KEY (
			corp_id
		)
		REFERENCES Corp (
			corp_id
		);

ALTER TABLE Loan_waiting
	ADD
		CONSTRAINT FK_Loan_prod_TO_Loan_waiting
		FOREIGN KEY (
			prod_no,
			loan_type
		)
		REFERENCES Loan_prod (
			prod_no,
			loan_type
		);

ALTER TABLE Loan_waiting
	ADD
		CONSTRAINT FK_bank_emp_TO_Loan_waiting
		FOREIGN KEY (
			empno
		)
		REFERENCES bank_emp (
			empno
		);

ALTER TABLE Loan_doc
	ADD
		CONSTRAINT FK_Loan_waiting_TO_Loan_doc
		FOREIGN KEY (
			app_no
		)
		REFERENCES Loan_waiting (
			app_no
		);

ALTER TABLE Credit_rank_history
	ADD
		CONSTRAINT FK_Corp_TO_Credit_rank_history
		FOREIGN KEY (
			corp_id
		)
		REFERENCES Corp (
			corp_id
		);

ALTER TABLE Fs_status
	ADD
		CONSTRAINT FK_fnc_stmt_TO_Fs_status
		FOREIGN KEY (
			corp_id,
			turn
		)
		REFERENCES fnc_stmt (
			corp_id,
			turn
		);

ALTER TABLE icm_stmt
	ADD
		CONSTRAINT FK_fnc_stmt_TO_icm_stmt
		FOREIGN KEY (
			corp_id,
			turn
		)
		REFERENCES fnc_stmt (
			corp_id,
			turn
		);

ALTER TABLE fnc_stmt
	ADD
		CONSTRAINT FK_Corp_TO_fnc_stmt
		FOREIGN KEY (
			corp_id
		)
		REFERENCES Corp (
			corp_id
		);

ALTER TABLE Rep
	ADD
		CONSTRAINT FK_Corp_TO_Rep
		FOREIGN KEY (
			corp_id
		)
		REFERENCES Corp (
			corp_id
		);

ALTER TABLE Cash_flow
	ADD
		CONSTRAINT FK_fnc_stmt_TO_Cash_flow
		FOREIGN KEY (
			corp_id,
			turn
		)
		REFERENCES fnc_stmt (
			corp_id,
			turn
		);

ALTER TABLE Loan_mgr
	ADD
		CONSTRAINT FK_Corp_TO_Loan_mgr
		FOREIGN KEY (
			corp_id
		)
		REFERENCES Corp (
			corp_id
		);

ALTER TABLE Loan_eval
	ADD
		CONSTRAINT FK_Loan_waiting_TO_Loan_eval
		FOREIGN KEY (
			app_no
		)
		REFERENCES Loan_waiting (
			app_no
		);

ALTER TABLE app_assurance
	ADD
		CONSTRAINT FK_Loan_wait_TO_app_ass
		FOREIGN KEY (
			app_no
		)
		REFERENCES Loan_waiting (
			app_no
		);

ALTER TABLE rpy_history
	ADD
		CONSTRAINT FK_Loan_his_TO_rpy_his
		FOREIGN KEY (
			loan_no
		)
		REFERENCES Loan_history (
			loan_no
		);

ALTER TABLE loan_assurance
	ADD
		CONSTRAINT FK_Loan_his_TO_fin_ass
		FOREIGN KEY (
			loan_no
		)
		REFERENCES Loan_history (
			loan_no
		);

/* check 제약조건 */

ALTER TABLE Loan_waiting
	ADD
		CONSTRAINT CHK_approve
		CHECK (
			approve
			IN ('Y', 'N')
		);

ALTER TABLE Loan_waiting
	ADD
		CONSTRAINT CHK_app_amount
		CHECK (
			app_amount > 0
		);

ALTER TABLE Corp
	ADD
		CONSTRAINT CHK_corp_cls
		CHECK (
			corp_cls
			IN ('Y', 'K', 'N', 'E')
		);

ALTER TABLE Loan_prod
	ADD
		CONSTRAINT CHK_loan_type
		CHECK (
			loan_type
			IN ('시설자금대출', '운전자금대출')
		);

ALTER TABLE Credit_rank_history
	ADD
		CONSTRAINT CHK_credit_rank_his
		CHECK (
			credit_rnk
			IN (
				'AAA', 'AA', 'A', 'BBB', 'BB', 'B', 'CCC', 'CC', 'C', 'D', 'R'
			)
		);

ALTER TABLE Loan_eval
	ADD
		CONSTRAINT CHK_loan_eval
		CHECK (
			eval_result
			IN (
				'P', 'F'
			)
		);

ALTER TABLE Loan_history
	ADD
		CONSTRAINT CHK_fin_mon
		CHECK (
			Fin_mon > 0
		);

ALTER TABLE Loan_history
	ADD
		CONSTRAINT CHK_pcpl_amt
		CHECK (
			pcpl_amt > 0
		);

ALTER TABLE Loan_history
	ADD
		CONSTRAINT CHK_fin_interest
		CHECK (
			fin_interest > 0
		);

ALTER TABLE rpy_history
	ADD
		CONSTRAINT CHK_mid_rpy_amt
		CHECK (
			mid_rpy_amt > 0
		);

ALTER TABLE Loan_doc
	ADD
		CONSTRAINT CHK_loan_doc
		CHECK (
			by_whom
			IN (
				'세무사', '기업'
			)
		);

		/* 10건 이상의 샘플데이터 */

		-- Accountant
		INSERT INTO Accountant VALUES ('9100111', '김범수', 'bumsuKim', 'bumsuKim', '010-1111-1111');
		INSERT INTO Accountant VALUES ('9100112', '나한결', 'hankyeol', 'hankyeol', '010-2222-2222');
		INSERT INTO Accountant VALUES ('9100113', '박종진', 'jongjin', 'jongjin', '010-3333-3333');
		INSERT INTO Accountant VALUES ('9100114', '이혜리', 'hyeri', 'hyeri', '010-4444-4444');
		INSERT INTO Accountant VALUES ('9100115', '원상욱', 'sanguk', 'sanguk', '010-5555-5555');
		INSERT INTO Accountant VALUES ('9100116', '홍나혜', 'nahye', 'nahye', '010-6666-6666');
		INSERT INTO Accountant VALUES ('9100117', '박사랑', 'sarang', 'sarang', '010-7777-7777');
		INSERT INTO Accountant VALUES ('9100118', '김의동', 'euidong', 'euidong', '010-8888-8888');
		INSERT INTO Accountant VALUES ('9100119', '천인우', 'inwoo', 'inwoo', '010-9999-9999');
		INSERT INTO Accountant VALUES ('9100120', '이상희', 'sanghee', 'sanghee', '010-1010-1010');

		-- Corp
		INSERT INTO corp VALUES ('samsung', '삼성전자', 'SAMSUNG ELECTRONICS CO,.LTD', 'Y',
		'1301110006246', '1248100998', '경기도 수원시 영통구  삼성로 129 (매탄동)', 'www.sec.co.kr',
		'031-200-1114', '031-200-7538', '264', '1969-01-13', 'samsung', '9100111');

		INSERT INTO corp VALUES ('kakao', '카카오', 'KAKAO', 'Y',
		'1101111129497', '1208147521', '제주특별자치도 제주시 첨단로 242', 'www.kakaocorp.com',
		'02-6718-1082', '02-6003-5401', '231', '1995-02-16', 'kakao', '9100112');

		INSERT INTO corp VALUES ('e1', 'E1', 'E1 Corporation', 'Y',
		'1101110381387', '1148116585', '서울특별시 용산구 한강대로 92 LS용산타워', 'www.e1.co.kr',
		'02-3441-4114', '02-6204-1407', '49', '1984-09-06', 'e1', '9100113');

		INSERT INTO corp VALUES ('hyundae', '현대중공업', 'HYUNDAI HEAVY INDUSTRIES CO.,LTD.', 'E',
		'2301110312741', '2528701412', '울산광역시 동구 방어진순환도로 1000 (전하동)', 'www.hhi.co.kr',
		'052-203-4829', '052-202-3315', '55', '2019-06-03', 'hyeondae', '9100113');

		INSERT INTO corp VALUES ('hanafnc', '하나음융티아이', 'Hana TI Company Ltd.', 'E',
		'1101110719695', '2198103518', '인천광역시 서구 에코로 181 (경서동, 하나금융그룹통합데이터센터) 5층', 'www.hanati.co.kr',
		'02-2151-6400', '02-2151-6410', '100', '1990-08-30', 'hanafnc', '9100112');

		INSERT INTO corp VALUES ('ibkBank', '기업은행', 'INDUSTRIAL BANK OF KOREA', 'E',
		'1101350000903', '2028100978', '서울특별시 중구 을지로 79 중소기업은행본점', 'www.kiupbank.co.kr',
		'02-729-6114', '02-729-7105', '20', '1961-07-25', 'ibkBank', '9100111');

		INSERT INTO corp VALUES ('naver', 'NAVER', 'NAVER Corporation', 'E',
		'1101111707178', '2208162517', '경기도 성남시 분당구 불정로 6', 'www.navercorp.com',
		'1588-3830', '031-784-4175', '300', '1999-06-02', 'naver', '9100114');

		INSERT INTO corp VALUES ('lineBizPls', '라인비즈플러스', 'LINE Biz Plus Corporation', 'E',
		'1311110385011', '1448129418', '경기도 성남시 분당구 분당내곡로 117 (백현동, 크래프톤타워)', null,
		'031-8039-8580', '031-784-1000', '150', '2014-08-26', 'lineBizPls', '9100115');

		INSERT INTO corp VALUES ('kakyung', '가경', 'gageung', 'E',
		'2241110033668', '4288800375', '제주특별자치도 제주시 광평중길 73 (노형동)', null,
		'010-4964-3697', null, '340', '2016-06-30', 'kakyung', '9100112');

		INSERT INTO corp VALUES ('hansae', '한세실업', 'HANSAE CO.,LTD.', 'E',
		'1201110484303', '1378192214', '서울특별시 영등포구 은행로 29 정우빌딩', 'www.hansae.com',
		'02-3779-0779', '02-3779-5596', '311', '2009-01-06', 'hansae', '9100116');


		-- Loan_prod
		INSERT INTO Loan_prod VALUES ('001', '시설자금대출', 24, 'RD 자금',  '설립된지 3년이내 중소기업', 2, 3, 300000000, '만기일시상환', 1.2);

		INSERT INTO Loan_prod VALUES ('002', '시설자금대출', 36, '제조업 지원 자금', '5년이내 제조업 중소기업', 2.5, 3.8, 230000000,'만기일시상환', 2.3);

		INSERT INTO Loan_prod VALUES ('003', '시설자금대출',48, '중소기업 시설자금', '2년이내 중소기업', 2.1, 2.9, 400000000,'만기일시상환', 3.1);

		INSERT INTO Loan_prod VALUES ('004', '운전자금대출',36, '핀테크기업 대상 운전자금', '3년이내 핀테크기업', 1.9, 3.1, 430000000, '만기일시상환',2.9);

		INSERT INTO Loan_prod VALUES ('005', '시설자금대출',36, '스타트업 자립자금', '4년이내 스타트업', 2.1, 2.9, 250000000, '만기일시상환',2.8);

		INSERT INTO Loan_prod VALUES ('006', '시설자금대출',36, '외국기업 지원금','2년이내 스타트업', 2.0, 3.0, 230000000, '만기일시상환',2.3);

		INSERT INTO Loan_prod VALUES ('007', '운전자금대출',24, '벤처기업 지원대출', '5년이내 벤처기업', 2.3, 3.8, 400000000,'만기일시상환', 3.1);

		INSERT INTO Loan_prod VALUES ('008', '시설자금대출',48, '스마트팩토리 지원대출', '3년이내 중소기업', 2.0, 2.5, 300000000, '만기일시상환',2.1);

		INSERT INTO Loan_prod VALUES ('009', '시설자금대출',12, '단기 설비자금대출', '1년이내 스타트업', 2.5, 3.2, 250000000, '만기일시상환',2.2);

		INSERT INTO Loan_prod VALUES ('010','운전자금대출',24, '기술벤처기업 지원대출', '4차산업혁명 벤처기업', 2.3, 3.1, 450000000, '만기일시상환',2.3);


		-- bank_emp

		INSERT INTO bank_emp VALUES ('000001', '001', '이길동', '10', '과장', 'hana@naver.com', '010-1111-1313');

		INSERT INTO bank_emp VALUES ('000002', '001', '이한동', '10', '차장', 'hana1@naver.com', '010-1111-1414');

		INSERT INTO bank_emp VALUES ('000003', '001', '김상욱', '10', '대리', 'hana2@naver.com', '010-1111-1515');

		INSERT INTO bank_emp VALUES ('000004', '001', '박길자', '20', '사원', 'hana3@naver.com', '010-1111-1616');

		INSERT INTO bank_emp VALUES ('000005', '001', '김관모', '30', '사원', 'hana4@naver.com', '010-1111-1717');

		INSERT INTO bank_emp VALUES ('000006', '001', '함예욱', '10', '사원', 'hana5@naver.com', '010-1111-1818');

		INSERT INTO bank_emp VALUES ('000007', '001', '이지훈', '20', '대리', 'hana6@naver.com', '010-1111-1919');

		INSERT INTO bank_emp VALUES ('000008', '001', '박의한', '20', '과장', 'hana7@naver.com', '010-1111-2020');

		INSERT INTO bank_emp VALUES ('000009', '001', '홍길동', '30', '대리', 'hana8@naver.com', '010-1111-2121');

		INSERT INTO bank_emp VALUES ('000010', '001', '박은혜', '10', '사2', 'hana9@naver.com', '010-1111-2222');

		-- Loan_waiting
		INSERT INTO Loan_waiting VALUES ('000001', 'Y', '2020-06-07', 10000000, 12, 'samsung','001', '000001', '시설자금대출');

		INSERT INTO Loan_waiting VALUES ('000002', 'Y', '2020-06-07', 30000000, 12, 'samsung', '001', '000001', '시설자금대출');

		INSERT INTO Loan_waiting VALUES ('000003', 'Y', '2020-06-07', 25000000, 12, 'kakao', '003', '000001', '시설자금대출');

		INSERT INTO Loan_waiting VALUES ('000004', 'Y', '2020-06-07', 10000000, 12, 'kakyung', '004', '000001', '운전자금대출');

		INSERT INTO Loan_waiting VALUES ('000005', null, '2020-06-07', 10000000, 12, 'samsung', '005', '000001', '시설자금대출');

		INSERT INTO Loan_waiting VALUES ('000006', null, '2020-06-07', 10000000, 12, 'hansae', '001', '000001', '시설자금대출');

		INSERT INTO Loan_waiting VALUES ('000007', null, '2020-06-07', 12000000, 12, 'hanafnc', '002', '000001', '시설자금대출');

		INSERT INTO Loan_waiting VALUES ('000008', null, '2020-06-07', 13000000, 12, 'naver', '003', '000001', '시설자금대출');

		INSERT INTO Loan_waiting VALUES ('000009', null, '2020-06-07', 14000000, 12, 'lineBizPls', '002', '000001', '시설자금대출');

		INSERT INTO Loan_waiting VALUES ('000010', null, '2020-06-07', 22000000, 12, 'hanafnc', '003', '000001', '시설자금대출');

		-- Loan_history

		INSERT INTO Loan_history VALUES ('000001', '2020-06-07', 12, null, 10000000, 2.2, 5000000, '000001', '001', 'samsung', '시설자금대출');

		INSERT INTO Loan_history VALUES ('000002', '2020-06-07', 12, null, 30000000, 2.3, 30000000, '000001', '001', 'samsung', '시설자금대출');

		INSERT INTO Loan_history VALUES ('000003', '2020-06-07', 12, null, 25000000, 2.5, 25000000, '000001', '003', 'kakao', '시설자금대출');

		INSERT INTO Loan_history VALUES ('000004', '2020-06-07', 12, null, 10000000, 2.4, 10000000, '000001', '004', 'kakyung', '운전자금대출');


		-- loan_assurance

		INSERT INTO loan_assurance VALUES ('000001', '담보명1', '보증서', '기술보증기금');
		INSERT INTO loan_assurance VALUES ('000002', '담보명2', '보증서', '기술보증기금');
		INSERT INTO loan_assurance VALUES ('000003', '담보명3', '보증서', '기술보증기금');
		INSERT INTO loan_assurance VALUES ('000004', '담보명4', '보증서', '기술보증기금');

		-- rpy_history

		INSERT INTO rpy_history VALUES ('2020-06-07', '000001', 5000000, null);


		-- app_assurance
		INSERT INTO app_assurance VALUES ('000001', '담보명', '보증서', '기술보증기금');
		INSERT INTO app_assurance VALUES ('000002', '담보명', '보증서', '기술보증기금');
		INSERT INTO app_assurance VALUES ('000003', '담보명', '보증서', '기술보증기금');
		INSERT INTO app_assurance VALUES ('000004', '담보명', '보증서', '기술보증기금');
		INSERT INTO app_assurance VALUES ('000005', '담보명', '보증서', '기술보증기금');
		INSERT INTO app_assurance VALUES ('000006', '담보명', '보증서', '기술보증기금');
		INSERT INTO app_assurance VALUES ('000007', '담보명', '보증서', '기술보증기금');
		INSERT INTO app_assurance VALUES ('000008', '담보명', '보증서', '기술보증기금');
		INSERT INTO app_assurance VALUES ('000009', '담보명', '보증서', '기술보증기금');
		INSERT INTO app_assurance VALUES ('000010', '담보명', '보증서', '중소기업진흥공단');


		-- Loan_eval
		INSERT INTO loan_eval VALUES ('000001', '001', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000001', '002', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000001', '003', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000002', '001', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000002', '002', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000002', '003', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000003', '001', '2020-06-07', 'F', null);
		INSERT INTO loan_eval VALUES ('000004', '001', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000004', '002', '2020-06-07', 'P', null);

		INSERT INTO loan_eval VALUES ('000005', '001', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000005', '002', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000005', '003', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000006', '001', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000006', '002', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000006', '003', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000007', '001', '2020-06-07', 'F', null);
		INSERT INTO loan_eval VALUES ('000008', '001', '2020-06-07', 'P', null);
		INSERT INTO loan_eval VALUES ('000009', '001', '2020-06-07', 'P', null);

		-- Loan_doc
		INSERT INTO loan_doc VALUES ('000001', '법인등록증', '기업', '2020-06-07', '서류이름1');
		INSERT INTO loan_doc VALUES ('000001', '재무제표', '세무사', '2020-06-07', '서류이름2');
		INSERT INTO loan_doc VALUES ('000001', '비과세과세표준증명원', '세무사', '2020-06-07', '서류이름3');
		INSERT INTO loan_doc VALUES ('000001', '납세증명원', '세무사', '2020-06-07', '서류이름4');
		INSERT INTO loan_doc VALUES ('000002', '법인등록증', '기업', '2020-06-07', '서류이름1');
		INSERT INTO loan_doc VALUES ('000002', '재무제표', '세무사', '2020-06-07', '서류이름2');
		INSERT INTO loan_doc VALUES ('000002', '비과세과세표준증명원', '세무사', '2020-06-07', '서류이름3');
		INSERT INTO loan_doc VALUES ('000002', '납세증명원', '세무사', '2020-06-07', '서류이름4');
		INSERT INTO loan_doc VALUES ('000003', '법인등록증', '기업', '2020-06-07', '서류이름1');
		INSERT INTO loan_doc VALUES ('000003', '재무제표', '세무사', '2020-06-07', '서류이름2');
		INSERT INTO loan_doc VALUES ('000003', '비과세과세표준증명원', '세무사', '2020-06-07', '서류이름3');
		INSERT INTO loan_doc VALUES ('000003', '납세증명원', '세무사', '2020-06-07', '서류이름4');
		INSERT INTO loan_doc VALUES ('000004', '법인등록증', '기업', '2020-06-07', '서류이름1');
		INSERT INTO loan_doc VALUES ('000004', '재무제표', '세무사', '2020-06-07', '서류이름2');
		INSERT INTO loan_doc VALUES ('000004', '비과세과세표준증명원', '세무사', '2020-06-07', '서류이름3');
		INSERT INTO loan_doc VALUES ('000004', '납세증명원', '세무사', '2020-06-07', '서류이름4');
		INSERT INTO loan_doc VALUES ('000005', '법인등록증', '기업', '2020-06-07', '서류이름1');
		INSERT INTO loan_doc VALUES ('000005', '재무제표', '세무사', '2020-06-07', '서류이름2');
		INSERT INTO loan_doc VALUES ('000005', '비과세과세표준증명원', '세무사', '2020-06-07', '서류이름3');
		INSERT INTO loan_doc VALUES ('000005', '납세증명원', '세무사', '2020-06-07', '서류이름4');
		INSERT INTO loan_doc VALUES ('000006', '법인등록증', '기업', '2020-06-07', '서류이름1');
		INSERT INTO loan_doc VALUES ('000006', '재무제표', '세무사', '2020-06-07', '서류이름2');
		INSERT INTO loan_doc VALUES ('000006', '비과세과세표준증명원', '세무사', '2020-06-07', '서류이름3');
		INSERT INTO loan_doc VALUES ('000006', '납세증명원', '세무사', '2020-06-07', '서류이름4');
		INSERT INTO loan_doc VALUES ('000007', '법인등록증', '기업', '2020-06-07', '서류이름1');
		INSERT INTO loan_doc VALUES ('000007', '재무제표', '세무사', '2020-06-07', '서류이름2');
		INSERT INTO loan_doc VALUES ('000007', '비과세과세표준증명원', '세무사', '2020-06-07', '서류이름3');
		INSERT INTO loan_doc VALUES ('000007', '납세증명원', '세무사', '2020-06-07', '서류이름4');
		INSERT INTO loan_doc VALUES ('000008', '법인등록증', '기업', '2020-06-07', '서류이름1');
		INSERT INTO loan_doc VALUES ('000008', '재무제표', '세무사', '2020-06-07', '서류이름2');
		INSERT INTO loan_doc VALUES ('000008', '비과세과세표준증명원', '세무사', '2020-06-07', '서류이름3');
		INSERT INTO loan_doc VALUES ('000008', '납세증명원', '세무사', '2020-06-07', '서류이름4');

		-- code

		INSERT INTO code VALUES ('corp_cls', 'Y', 'corp', '유가증권시장');
		INSERT INTO code VALUES ('corp_cls', 'K', 'corp', '코스닥시장');
		INSERT INTO code VALUES ('corp_cls', 'N', 'corp', '코넥스시장');
		INSERT INTO code VALUES ('corp_cls', 'E', 'corp', '기타');
		INSERT INTO code VALUES ('eval_result', 'P', 'loan_eval', '심사통과');
		INSERT INTO code VALUES ('eval_result', 'F', 'loan_eval', '심사불통과');


		-- Loan_mgr

		INSERT INTO Loan_mgr VALUES ('samsung', '010-1111-1111', '김길동');
		INSERT INTO Loan_mgr VALUES ('lineBizPls', '010-2222-1111', '강길동');
		INSERT INTO Loan_mgr VALUES ('kakao', '010-3333-1111', '한길동');
		INSERT INTO Loan_mgr VALUES ('kakyung', '010-4444-1111', '한길동');
		INSERT INTO Loan_mgr VALUES ('hanafnc', '010-5555-1111', '오길동');
		INSERT INTO Loan_mgr VALUES ('naver', '010-6666-1111', '유길동');
		INSERT INTO Loan_mgr VALUES ('hansae', '010-7777-1111', '함길동');
		INSERT INTO Loan_mgr VALUES ('hyundae', '010-8888-1111', '이길동');
		INSERT INTO Loan_mgr VALUES ('kakyung', '010-9999-1111', '윤길동');
		INSERT INTO Loan_mgr VALUES ('ibkBank', '010-0000-1111', '최길동');

		-- Credit_rank_history

		INSERT INTO Credit_rank_history VALUES ('samsung', '2020-06-07', '2019-12-31', 'AAA');
		INSERT INTO Credit_rank_history VALUES ('samsung', '2019-06-07', '2018-12-31', 'AAA');
		INSERT INTO Credit_rank_history VALUES ('samsung', '2018-06-07', '2017-12-31', 'AAA');
		INSERT INTO Credit_rank_history VALUES ('samsung', '2017-06-07', '2016-12-31', 'AAA');
		INSERT INTO Credit_rank_history VALUES ('kakao', '2020-06-07', '2019-12-31', 'AAA');
		INSERT INTO Credit_rank_history VALUES ('hanafnc', '2020-06-07', '2019-12-31', 'AAA');

		-- rep

		INSERT INTO rep VALUES ('samsung', '김범수');
		INSERT INTO rep VALUES ('samsung', '박범수');
		INSERT INTO rep VALUES ('kakao', '홍범수');
		INSERT INTO rep VALUES ('hansae', '윤범수');
		INSERT INTO rep VALUES ('naver', '이범수');
		INSERT INTO rep VALUES ('hanafnc', '함범수');
		INSERT INTO rep VALUES ('lineBizPls', '최범수');
		INSERT INTO rep VALUES ('ibkBank', '윤범수');
		INSERT INTO rep VALUES ('kakyung', '한범수');

		-- fnc_stmt

		INSERT INTO fnc_stmt VALUES ('samsung', 51, '2019-12-31');
		INSERT INTO fnc_stmt VALUES ('samsung', 50, '2018-12-31');
		INSERT INTO fnc_stmt VALUES ('hanafnc', 10, '2019-12-31');
		INSERT INTO fnc_stmt VALUES ('naver', 30, '2019-12-31');
		INSERT INTO fnc_stmt VALUES ('kakao', 3, '2019-12-31');
		INSERT INTO fnc_stmt VALUES ('lineBizPls', 12, '2019-12-31');
		INSERT INTO fnc_stmt VALUES ('kakyung', 11, '2019-12-31');
		INSERT INTO fnc_stmt VALUES ('ibkBank', 60, '2019-12-31');
		INSERT INTO fnc_stmt VALUES ('hyundae', 70, '2019-12-31');
		INSERT INTO fnc_stmt VALUES ('hansae', 30, '2019-12-31');

		-- Cash_flow

		INSERT INTO Cash_flow VALUES ('samsung', 51, 1111, 1111, 1111);
		INSERT INTO Cash_flow VALUES ('samsung', 50, 1111, 1111, 1111);
		INSERT INTO Cash_flow VALUES ('hanafnc', 10, 1111, 1111, 1111);
		INSERT INTO Cash_flow VALUES ('naver', 30, 1111, 1111, 1111);
		INSERT INTO Cash_flow VALUES ('kakao', 3, 1111, 1111, 1111);
		INSERT INTO Cash_flow VALUES ('lineBizPls', 12, 1111, 1111, 1111);
		INSERT INTO Cash_flow VALUES ('kakyung', 11, 1111, 1111, 1111);
		INSERT INTO Cash_flow VALUES ('ibkBank', 60, 1111, 1111, 1111);
		INSERT INTO Cash_flow VALUES ('hyundae', 70, 1111, 1111, 1111);
		INSERT INTO Cash_flow VALUES ('hansae', 30, 1111, 1111, 1111);

		-- Fs_status

		INSERT INTO Fs_status VALUES ('samsung', 51, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);
		INSERT INTO Fs_status VALUES ('samsung', 50, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);
		INSERT INTO Fs_status VALUES ('hanafnc', 10, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);
		INSERT INTO Fs_status VALUES ('naver', 30, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);
		INSERT INTO Fs_status VALUES ('kakao', 3, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);
		INSERT INTO Fs_status VALUES ('lineBizPls', 12, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);
		INSERT INTO Fs_status VALUES ('kakyung', 11, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);
		INSERT INTO Fs_status VALUES ('ibkBank', 60, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);
		INSERT INTO Fs_status VALUES ('hyundae', 70, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);
		INSERT INTO Fs_status VALUES ('hansae', 30, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111, 1111);

		-- icm_stmt

		INSERT INTO icm_stmt VALUES ('samsung', 51, 1111, 1111, 1111);
		INSERT INTO icm_stmt VALUES ('samsung', 50, 1111, 1111, 1111);
		INSERT INTO icm_stmt VALUES ('hanafnc', 10, 1111, 1111, 1111);
		INSERT INTO icm_stmt VALUES ('naver', 30, 1111, 1111, 1111);
		INSERT INTO icm_stmt VALUES ('kakao', 3, 1111, 1111, 1111);
		INSERT INTO icm_stmt VALUES ('lineBizPls', 12, 1111, 1111, 1111);
		INSERT INTO icm_stmt VALUES ('kakyung', 11, 1111, 1111, 1111);
		INSERT INTO icm_stmt VALUES ('ibkBank', 60, 1111, 1111, 1111);
		INSERT INTO icm_stmt VALUES ('hyundae', 70, 1111, 1111, 1111);
		INSERT INTO icm_stmt VALUES ('hansae', 30, 1111, 1111, 1111);

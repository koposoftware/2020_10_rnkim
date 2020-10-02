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

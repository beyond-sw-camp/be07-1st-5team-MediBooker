-- 조건1 : 의사의 휴무일과 접수요일이 달라야 한다. 만약 같다면? -> 오류메시지 출력 (휴무일입니다.)
-- 접수테이블에 접수 상태로 추가, 대기 테이블 추가, 환자 테이블 업데이트 또는 추가



-- 테스트 1 : 이미 환자 테이블에 존재하는 환자를 주민번호를 제외하고 나머지 정보는 수정하여 입력한다 -> 주민번호를 제외한 나머지 정보 업데이트(식별자 : 주민번호), 접수와 대기 테이블 추가
CALL InsertOrUpdateRegistration(
    1, -- doctor_id_param (의사 ID)
    '흉통', -- symptom_param (증상)
    '김지뿡', -- patient_name_param (환자 이름)
    '123456-1234567', -- identity_number_param (환자 ID)
    '010-7712-8132', -- patient_phone_param (환자 전화번호)
    '서울특별시 종로구 오르막길..' -- address_param (환자 주소)
);

-- 테스트 2 : 환자 테이블에 존재하지 않는 새로운 데이터를 입력 -> 환자 테이블에 새로운 데이터 추가, 접수와 대기 테이블 추가
CALL InsertOrUpdateRegistration(
    1, -- doctor_id_param (의사 ID)
    '방구쟁이', -- symptom_param (증상)
    '정뿡기', -- patient_name_param (환자 이름)
    '980213-2912307', -- identity_number_param (환자 ID)
    '010-6442-9981', -- patient_phone_param (환자 전화번호)
    '서울특별시 신대방 제2동 sfc빌딩' -- address_param (환자 주소)
);

-- 테스트 3 : 의사의 휴무일과 일치하는 경우 데이터 입력 -> 오류메시지 출력
CALL InsertOrUpdateRegistration(
    3, -- 휴무인 doctor_id_param (의사 ID)
    '걸으면 허리 뿡', -- symptom_param (증상)
    '김창뿡', -- patient_name_param (환자 이름)
    '000604-3101943', -- identity_number_param (환자 ID)
    '010-8765-1225', -- patient_phone_param (환자 전화번호)
    '서울특별시 구로구 고척스카이돔' -- address_param (환자 주소)
);









-- 보류
-- 조건2 : 환자는 모두 사용자 인증을 하는 경우에만 접수가 가능하다. 만약 인증하지 않았다면? -> 오류메시지 출력(사용자 인증 오류입니다.)
-- 테스트 (보류) : 사용자 인증을 하지 않은 환자를 접수하면 ? -> 환자 테이블에 존재하는 사용자 인증 컬럼이 N이면 "사용자 인증 오류입니다." 문구 발생, Y면 데이터 삽입
CALL InsertOrUpdateRegistration(
    2, -- doctor_id_param (의사 ID)
    '귀가 들리지가 않아요', -- symptom_param (증상)
    '박수뿡', -- patient_name_param (환자 이름)
    '654321-7654321', -- identity_number_param (환자 ID)
    '010-9999-7623', -- patient_phone_param (환자 전화번호)
    '서울특별시 강남구 롯데백화점' -- address_param (환자 주소)
);

-- 이미 존재하는 환자 정보를 수정해서 입력

CALL InsertOrUpdateRegistration(
    1, -- doctor_id_param (의사 ID)
    '흉통', -- symptom_param (증상)
    '김철수', -- patient_name_param (환자 이름)
    'ID123456', -- identity_number_param (환자 ID)
    '010-1234-5678', -- patient_phone_param (환자 전화번호)
    '서울특별시 강남구 테헤란로 123' -- address_param (환자 주소)
);
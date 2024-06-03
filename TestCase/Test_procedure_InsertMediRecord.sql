-- 진료 기록 테이블에 추가, 대기테이블에서 삭제
SELECT * FROM Medical_Records;

SELECT * FROM Waiting;
-- 테스트 1 : 의사의 휴무일이 현재의 요일과 일치하는 경우 오류 메시지를 출력한다.
-- 날짜에 맞게 휴무일 수정해야함
CALL InsertMediRecord (
    13, -- patient_id (환자ID)
    3, -- 휴무인 doctor_id_param (의사 ID)
    '콧물 질질 줄줄', -- diagnosis_param (진단 내용)
    '콧물 다 빼버려', -- treatment_param (치료 내용)
    '파란 물약' -- prescription_param (처방 내용)
);

-- 테스트 2 : 입력받은 데이터와 일치하는 데이터가 대기 목록에 존재하지 않는 경우 오류 메시지를 출력한다.
CALL InsertMediRecord (
    13, -- 대기 목록에 존재하지 않는 patient_id (환자ID)
    2, -- 대기 목록에 존재하지 않는 doctor_id_param (의사 ID)
    '콧물 질질 줄줄', -- diagnosis_param (진단 내용)
    '콧물 다 빼버려', -- treatment_param (치료 내용)
    '파란 물약' -- prescription_param (처방 내용)
);

-- 테스트 3 : 진료기록 추가 및 대기 데이터 삭제
CALL InsertMediRecord (
    13, -- 대기 목록에 존재하는 patient_id (환자ID)
    1, -- 대기 목록에 존재하는 doctor_id_param (의사 ID)
    '콧물 질질 줄줄', -- diagnosis_param (진단 내용)
    '콧물 다 빼버려', -- treatment_param (치료 내용)
    '파란 물약' -- prescription_param (처방 내용)
);

-- 테스트 4 : 진료기록 추가 및 대기 데이터 삭제 + 결제 서비스 추가
CALL InsertMediRecord(
        3, -- 대기 목록에 존재하는 patient_id (환자ID)
        4, -- 대기 목록에 존재하는 doctor_id_param (의사 ID)
        '장염', -- diagnosis_param (진단 내용)
        '엄마 손은 약손',-- treatment_param (치료 내용)
        '빨간 물약', -- prescription_param (처방 내용)
        50000, -- 청구할 금액
        '오프라인'); -- 결제 방법
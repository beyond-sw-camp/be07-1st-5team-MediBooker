DELIMITER //

CREATE PROCEDURE InsertMediRecord(
    IN patient_id_param INT,
    IN doctor_id_param INT,
    IN diagnosis_param TEXT,
    IN treatment_param TEXT,
    IN prescription_param TEXT,
    IN payment_amount FLOAT,
    IN payment_method ENUM('온라인', '오프라인')
)
BEGIN
    DECLARE department_id INT;
    DECLARE manager_id INT;
    DECLARE vacation_day ENUM('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
    DECLARE doctor_name VARCHAR(10);
    DECLARE record_count INT;

    -- 의사 이름 조회
    SELECT d.doctor_name INTO doctor_name
    FROM Doctors d
    WHERE d.doctor_id = doctor_id_param;

    -- 의사ID로 진료과 조회
    SELECT d.department_id INTO department_id
    FROM Doctors d
    WHERE d.doctor_id = doctor_id_param;

    -- 진료과ID로 관리자ID 조회
    SELECT m.manager_id INTO manager_id
    FROM Manager m
    WHERE department_id = m.department_id;

    -- 입력한 데이터가 대기 목록에 없으면 오류 메시지 출력
    SELECT COUNT(*)
    INTO record_count
    FROM Waiting w
    WHERE patient_id_param = w.patient_id AND doctor_id_param = w.doctor_id;

    IF record_count = 0 THEN
        SET @error_message = CONCAT('입력한 정보가 대기 목록에 존재하지 않습니다.');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
    END IF;

    -- 의사 휴무일에 대한 진료 기록 작성 시 오류 메시지 출력
    SELECT s.vacation_date INTO vacation_day
    FROM Schedules s
    WHERE s.doctor_id = doctor_id_param;

    IF vacation_day = DAYNAME(CURDATE()) THEN
        SET @error_message = CONCAT(doctor_name, ' 선생님은 오늘 휴무입니다. ');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @error_message;
    END IF;

    -- 진료기록 삽입
    INSERT INTO Medical_Records (patient_id, doctor_id, department_id, manager_id, diagnosis, treatment, prescription)
    VALUES (patient_id_param, doctor_id_param, department_id, manager_id, diagnosis_param, treatment_param, prescription_param);

    -- 방금 삽입된 진료기록의 ID를 가져오기
    SET @record_id = LAST_INSERT_ID();

    -- 결제 삽입
    INSERT INTO Payments (record_id, amount, payment_date, payment_method)
    VALUES (@record_id, payment_amount, NOW(), payment_method);

    -- Waiting 테이블에서 환자 기록 삭제
    DELETE FROM Waiting
    WHERE patient_id = patient_id_param AND doctor_id = doctor_id_param;

END //

DELIMITER ;

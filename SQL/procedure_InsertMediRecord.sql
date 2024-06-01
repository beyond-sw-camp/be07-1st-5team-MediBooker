DELIMITER / /

CREATE PROCEDURE InsertChart(
    IN patient_id_param INT,
    IN doctor_id_param INT,
    IN diagnosis_param TEXT,
    IN treatment_param TEXT,
    IN prescription_param TEXT
)
BEGIN
    -- doctor_id 로 department_id 가져오기
    -- department_id 로 manger_id 가져오기
    -- 진료기록에 삽입
    DECLARE department_id INT;
    DECLARE manager_id INT;
    DECLARE vacation_day ENUM('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
    DECLARE day_off_message VARCHAR(255);
    DECLARE current_weekday VARCHAR(10);

    -- 현재 요일 구하기 (Sunday, Monday, ..., Saturday)
    SET current_weekday = DAYNAME(CURDATE());

    SELECT d.department_id INTO department_id
    FROM Doctors d
    where d.doctor_id = doctor_id_param;

    SELECT m.manager_id INTO manager_id
    FROM Manager m
    where department_id = m.department_id;

    -- 의사 휴무일에 대한 진료 기록 작성 시 오류
    SELECT s.vacation_date INTO vacation_day
    FROM Schedules s
    WHERE s.doctor_id = doctor_id_param;

    IF vacation_day = current_weekday THEN
        SET day_off_message = CONCAT('Doctor ', doctor_id_param, ' is off today (', current_weekday, ').');
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = day_off_message;
    END IF;

    INSERT INTO Medical_Records (patient_id, doctor_id, department_id, manager_id, diagnosis, treatment, prescription, visit_date)
    VALUES (patient_id_param, doctor_id_param, department_id, manager_id, diagnosis_param, treatment_param, prescription_param, NOW());

    -- Waiting 테이블에서 환자 기록 삭제
    DELETE FROM Waiting
    WHERE patient_id = Waiting.patient_id;
END//

DELIMITER;
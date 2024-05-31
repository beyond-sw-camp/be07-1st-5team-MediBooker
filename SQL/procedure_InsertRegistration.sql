-- 이 프로시저는 의사의 휴무일과 현재의 요일이 겹치지 않으면 데이터를 삽입한다. 
-- waiting_count 값 부여
-- status에 접수 값 default로 부여 

create
    definer = root@`%` procedure InsertRegistration(IN doctor_id_param int, IN symptom_param varchar(255))
BEGIN
    DECLARE today_day VARCHAR(10);
    DECLARE patient_id_param INT;
    DECLARE last_waiting_count INT;

    SET today_day = DAYNAME(NOW());


    INSERT INTO Registrations (doctor_id, symptom)
    SELECT doctor_id_param, symptom_param
    FROM Doctors AS d
    JOIN Schedules AS s ON d.doctor_id = s.doctor_id
    WHERE d.doctor_id = doctor_id_param AND s.vacation_date != today_day;

    SELECT LAST_INSERT_ID() INTO @last_inserted_id;

    SET @patient_id_param = @patient_id_param + 1;
    SELECT patient_id  INTO patient_id_param
    FROM Patients
    ORDER BY patient_id DESC
    LIMIT 1;


    INSERT INTO Waiting (registration_id, patient_id, waiting_count, status)
    SELECT @last_inserted_id, patient_id_param, (SELECT COALESCE(MAX(waiting_count), 0) + 1 FROM Waiting), '접수'
    WHERE EXISTS (SELECT 1 FROM Registrations WHERE registration_id = @last_inserted_id);
END;


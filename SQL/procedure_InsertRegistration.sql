-- 이 프로시저는 의사의 휴무일과 현재의 요일이 겹치지 않으면 데이터를 삽입한다.

create
    definer = root@`%` procedure InsertRegistration(IN doctor_id_param int, IN symptom_param varchar(255))
BEGIN
    DECLARE today_day VARCHAR(10);
    SET today_day = DAYNAME(NOW());

    INSERT INTO Registrations (doctor_id, symptom)
    SELECT doctor_id_param, symptom_param
    FROM Doctors AS d
    JOIN Schedules AS s ON d.doctor_id = s.doctor_id
    WHERE d.doctor_id = doctor_id_param AND s.vacation_date != today_day;
END;


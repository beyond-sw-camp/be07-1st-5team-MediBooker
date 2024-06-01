DELIMITER / /

CREATE PROCEDURE InsertChart(
    IN patient_id_param INT,
    IN doctor_id_param INT,
#     IN manager_id_param INT,
    IN diagnosis_param TEXT,
    IN treatment_param TEXT,
    IN prescription_param TEXT
#     IN visit_date_param DATETIME
)
BEGIN
    -- doctor_id 로 department_id 가져오기
    -- department_id 로 manger_id 가져오기
    -- 진료기록에 삽입
    DECLARE department_id INT;
    DECLARE manager_id INT;

    SELECT d.department_id INTO department_id
    FROM Doctors d
    where d.doctor_id = doctor_id_param;

    SELECT m.manager_id INTO manager_id
    FROM Manager m
    where department_id = m.department_id;

    INSERT INTO Medical_Records (patient_id, doctor_id, department_id, manager_id, diagnosis, treatment, prescription, visit_date)
    VALUES (patient_id_param, doctor_id_param, department_id, manager_id, diagnosis_param, treatment_param, prescription_param, NOW());

    DELETE FROM Waiting
    WHERE patient_id = Waiting.patient_id;
    
END//

DELIMITER;
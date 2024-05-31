
describe Departments;
describe Patients;
describe Manager;
describe Doctors;
describe Medical_Records;
describe Payments;
describe Schedules;
describe Feedback;
describe  Registrations;
describe Waiting;

select * from Departments;
select * from Patients;
select * from Manager;
select * from Doctors;
select * from Medical_Records;
select * from  Payments;
select * from Schedules;
select * from Feedback;
select * from Registrations;
select * from Waiting;

-- De, Pa, Ma, Do, M_R, Pay, Se, Feed, Reg, Waiting 



INSERT INTO Departments (name, description, department_phone_number)
VALUES ('내과', '내과 진료과', '02-1234-1234'),
       ('소아과', '소아과 진료과', '02-5678-5678');

INSERT INTO Patients (patient_name, identity_number, patient_phone, address)
VALUES ('홍길동', '900101-1234567', '010-1234-5678', '서울시 강남구'),
       ('김영희', '950202-2345678', '010-2345-6789', '서울시 서초구');

INSERT INTO Manager (department_id, manager_name)
VALUES
    (1, '관리자1'),
    (2, '관리자2');

INSERT INTO Doctors (doctor_name, department_id, phone, email, office_number)
VALUES
    ('김지은', 1, '010-3456-7890', 'kimcs@hospital.com', '101'),
    ('박수현', 2, '010-4567-8901', 'leeyh@hospital.com', '102');
INSERT INTO Doctors (doctor_name, department_id, phone, email, office_number)
VALUES('김창현', 2, '010-7755-6298', 'kch@naver.com','103');
 INSERT INTO Registrations (doctor_id, symptom)
SELECT d.doctor_id, '새로운 증상'  -- 실제로 사용할 증상 값으로 변경해야 합니다.
FROM Doctors AS d
JOIN Schedules AS s ON d.doctor_id = s.doctor_id
WHERE s.vacation_date != DAYNAME(NOW());

INSERT INTO Registrations (doctor_id, symptom)
VALUES
    (1, '감기'),
    (2, '독감');

INSERT INTO Registrations (doctor_id, symptom)
VALUES
    (1, '감기'),
    (2, '독감');

describe Waiting;

INSERT INTO Waiting (registration_id, patient_id, waiting_count, created_time)
VALUES
    (1, 1, 1, NOW());
INSERT INTO Waiting (registration_id, patient_id, waiting_count, created_time, status)
VALUES
    (2, 2, 2, NOW(), '접수');
                            -- 환자        의사          진료과         관리자         진단      치료          처방
INSERT INTO Medical_Records (patient_id, doctor_id, department_id, manager_id, diagnosis, treatment, prescription, visit_date)
VALUES
    (1, 1, 1, 1, '감기', '약물 치료', '타이레놀', CURDATE()),
    (2, 2, 2, 2, '독감', '약물 치료', '타미플루', CURDATE());
select * from Medical_Records;

INSERT INTO Payments (record_id, amount, payment_date, payment_method, del_yn)
VALUES
    (1, 50000, NOW(), '온라인', 'N'),
    (2, 70000, NOW(), '오프라인', 'N');

INSERT INTO Schedules (doctor_id, vacation_date, del_yn)
VALUES
    (1, 'Sunday', 'N'),
    (2, 'Saturday', 'N');
select * from Doctors;

INSERT INTO Schedules (doctor_id, vacation_date, del_yn)
VALUES (3, 'Friday','N');

INSERT INTO Feedback (record_id, rating, feedback_text, del_yn)
VALUES
    (1, 5, '친절한 진료 감사합니다.', 'N'),
    (2, 4, '진료가 만족스러웠습니다.', 'N');

-- insert문으로 데이터 삽입, 의사의 휴무일과 오늘의 날짜가 다른 경우에만 삽입 
 INSERT INTO Registrations (doctor_id, symptom)
SELECT 3, '감기'
FROM Doctors AS d
JOIN Schedules AS s ON d.doctor_id = s.doctor_id
WHERE d.doctor_id = docor_id && s.vacation_date != DAYNAME(NOW());


SELECT
    DAYOFWEEK('2024-05-30') AS day_of_week,
    DAYNAME(now()) AS day_name,
    WEEKDAY('2024-05-30') AS week_day;

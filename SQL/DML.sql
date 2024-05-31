
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
# De, Pa, Ma, Do, M_R, Pay, Se, Feed, Reg, Waiting

INSERT INTO Departments(name, description, department_phone_number)
VALUES ('내과', NULL, '02-1234-1234');
INSERT INTO Departments(name, description, department_phone_number)
VALUES ('이비인후과', '코, 귀 전문가', '02-1234-7777');
INSERT INTO Departments(name, description, department_phone_number)
VALUES ('정형외과','뼈는 내꺼', '02-8821-9330');

INSERT INTO Patients(patient_name, identity_number, patient_phone, address) VALUES ('김지은', '000810-3217647', '010-2677-9981', '신대방 제2동');
INSERT INTO Patients(patient_name, identity_number, patient_phone, address) VALUES ('박수현', '041102-4212553', '010-9942-2384', '도곡 1동');

insert into Manager(department_id, manager_name) values (1, '김창현');
insert into Manager(department_id, manager_name) values (2, '김창현');

insert into Doctors(doctor_name, department_id, phone, email, office_number)
values('홍문익', '1', '010-7331-9981', 'hong@naver.com', '1' );
insert into Doctors(doctor_name, department_id, phone, email, office_number)
values('김창식', '2', '010-8881-1234', 'goose@naver.com', '2' );

insert into Medical_Records(patient_id, doctor_id, department_id, manager_id, diagnosis, treatment, prescription, visit_date)
VALUES('1', '2', '2','1', '비염', '콧물 제거', '물약', '2024-01-31' );
insert into Medical_Records(patient_id, doctor_id, department_id, manager_id, diagnosis, treatment, prescription, visit_date)
VALUES('1', '2', '2','1', '중이염', '레이저 치료', '알약', '2024-02-12' );

insert into Payments(record_id, amount, payment_date, payment_method) VALUES ('1', '4800', '2024-01-31', '오프라인');
insert into Payments(record_id, amount, payment_date, payment_method) VALUES ('2', '8800', '2024-02-12', '온라인'); # 여태까지 결제한 이력을 보는 용도로

insert into Schedules(doctor_id, vacation_date) VALUES ('1', 'Sunday');
insert into Schedules(doctor_id, vacation_date) VALUES ('2', 'wednesday');
insert into Schedules(doctor_id, vacation_date) VALUES ('2', 'Friday');

insert into Feedback(record_id, rating, feedback_text)
values('1', 5, '무뚝뚝하세요');
insert into Feedback(record_id, rating, feedback_text)
values('2', 4, '아프게 치료해요');

insert into Registrations(patient_id,doctor_id, status, manager_id, symptoms) # status는 어떻게 정해? 접수는 여기서 정하는? 일단 테스트만, 테이블 분리 필요해보임
values ('1','2','완료', '1', '중이염');
insert into Registrations(doctor_id, status, manager_id, symptoms) # status는 어떻게 정해? 접수는 여기서 정하는? 일단 테스트만, 테이블 분리 필요해보임
values ('2','접수', '1', '중이염');

insert into Waiting(registration_id, patient_id) VALUES ('2', '2' );
insert into Waiting(registration_id, patient_id) VALUES ('2', '2' );




SELECT
    DAYOFWEEK('2024-05-30') AS day_of_week,
    DAYNAME(now()) AS day_name,
    WEEKDAY('2024-05-30') AS week_day;
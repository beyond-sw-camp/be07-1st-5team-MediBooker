use DOK;

-- 진료과 테이블 생성
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    department_phone_number VARCHAR(15) NOT NULL UNIQUE,
    del_yn ENUM('N', 'Y') DEFAULT 'N'
);

-- 환자 테이블 생성
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(30) NOT NULL,
    identity_number VARCHAR(20) NOT NULL UNIQUE,
    patient_phone VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    patient_authentication ENUM('N', 'Y') DEFAULT 'N',
    del_yn ENUM('N', 'Y') DEFAULT 'N'
);

-- 관리자 테이블 생성
CREATE TABLE Manager (
    manager_id INT PRIMARY KEY AUTO_INCREMENT,
    department_id INT,
    manager_name VARCHAR(20) NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 의사 테이블 생성
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(10) NOT NULL,
    department_id INT NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    office_number VARCHAR(10) NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 진료 기록 테이블 생성
CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    manager_id INT NOT NULL,
    diagnosis TEXT NOT NULL,
    treatment TEXT NOT NULL,
    prescription TEXT NOT NULL,
    visit_date DATETIME NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (manager_id) REFERENCES Manager(manager_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 결제 테이블 생성
CREATE TABLE Payments (
    record_id INT,
    amount FLOAT,
    payment_date DATETIME NOT NULL,
    payment_method ENUM('온라인', '오프라인') DEFAULT '온라인' NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (record_id) REFERENCES Medical_Records(record_id)
);

-- 의사 일정 테이블 생성
CREATE TABLE Schedules (
    doctor_id INT,
    vacation_date ENUM('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday') DEFAULT 'Sunday',
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 피드백 테이블 생성
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    record_id INT NOT NULL,
    rating INT CHECK (rating > 0 AND rating <= 5),
    feedback_text TEXT,
    feedback_count TEXT NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (record_id) REFERENCES Medical_Records(record_id)
);
ALTER TABLE Feedback
DROP COLUMN feedback_count;

-- 접수 테이블 생성
CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    status ENUM('접수', '취소', '완료') DEFAULT '접수' NOT NULL,
    created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    manager_id INT NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (manager_id) REFERENCES Manager(manager_id)
);
ALTER TABLE Registrations
ADD COLUMN symptoms VARCHAR(255);

-- 대기 테이블 생성
CREATE TABLE Waiting (
    waiting_id INT PRIMARY KEY AUTO_INCREMENT,
    registration_id INT,
    patient_id INT,
    waiting_count INT,
    FOREIGN KEY (registration_id) REFERENCES Registrations(registration_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);


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
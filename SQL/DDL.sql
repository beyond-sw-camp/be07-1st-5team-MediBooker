use DOK;
-- 환자 테이블 생성
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(10),
    identity_number VARCHAR(20),
    patient_phone VARCHAR(15),
    address VARCHAR(255),
    patient_authentication ENUM('N', 'Y'),
    del_yn ENUM('N', 'Y')
);

-- 의사 테이블 생성
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(10),
    department_id INT,
    phone VARCHAR(15),
    email VARCHAR(100),
    office_number VARCHAR(10),
    del_yn ENUM('N', 'Y'),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 진료과 테이블 생성
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    department_phone_number VARCHAR(15),
    del_yn ENUM('N', 'Y')
);

-- 진료 기록 테이블 생성
CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    department_id INT,
    manager_id INT,
    diagnosis TEXT,
    treatment TEXT,
    prescription TEXT,
    visit_date DATETIME,
    del_yn ENUM('N', 'Y'),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (manager_id) REFERENCES Manager(manager_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 결제 테이블 생성
CREATE TABLE Payments (
    record_id INT,
    amount FLOAT,
    payment_date DATETIME,
    payment_method ENUM('온라인', '오프라인'),
    del_yn ENUM('N', 'Y'),
    FOREIGN KEY (record_id) REFERENCES Medical_Records(record_id)
);

-- 의사 일정 테이블 생성
CREATE TABLE Schedules (
    doctor_id INT,
    vacation_date ENUM('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'),
    del_yn ENUM('N', 'Y'),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 피드백 테이블 생성
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    record_id INT,
    rating INT,
    feedback_text TEXT,
    del_yn ENUM('N', 'Y'),
    FOREIGN KEY (record_id) REFERENCES Medical_Records(record_id)
);

-- 접수 테이블 생성
CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    status ENUM('접수', '취소', '완료'),
    created_time DATETIME,
    manager_id INT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (manager_id) REFERENCES Manager(manager_id)
);

-- 대기 테이블 생성
CREATE TABLE Waiting (
    waiting_id INT PRIMARY KEY AUTO_INCREMENT,
    registration_id INT,
    patient_id INT,
    waiting_count INT,
    FOREIGN KEY (registration_id) REFERENCES Registrations(registration_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- 관리자 테이블 생성
CREATE TABLE Manager (
    manager_id INT PRIMARY KEY AUTO_INCREMENT,
    manager_name VARCHAR(10),
    department_id INT,
    del_yn ENUM('N', 'Ydepartmentsdepartments'),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

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
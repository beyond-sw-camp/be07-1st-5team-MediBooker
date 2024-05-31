CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    department_phone_number VARCHAR(15) NOT NULL UNIQUE,
    del_yn ENUM('N', 'Y') DEFAULT 'N'
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(30) NOT NULL,
    identity_number VARCHAR(20) NOT NULL UNIQUE,
    patient_phone VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    patient_authentication ENUM('N', 'Y') DEFAULT 'N',
    del_yn ENUM('N', 'Y') DEFAULT 'N'
);

CREATE TABLE Manager (
    manager_id INT PRIMARY KEY AUTO_INCREMENT,
    department_id INT,
    manager_name VARCHAR(20) NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

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

CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    department_id INT NOT NULL,
    manager_id INT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    treatment TEXT NOT NULL,
    prescription VARCHAR(255) NOT NULL,
    visit_date DATETIME NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (manager_id) REFERENCES Manager(manager_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Payments (
    record_id INT,
    amount FLOAT,
    payment_date DATETIME NOT NULL,
    payment_method ENUM('온라인', '오프라인') DEFAULT '온라인' NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (record_id) REFERENCES Medical_Records(record_id)
);

CREATE TABLE Schedules (
    doctor_id INT,
    vacation_date ENUM('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday') DEFAULT 'Sunday',
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT,
    record_id INT NOT NULL,
    rating INT CHECK (rating > 0 AND rating <= 5),
    feedback_text VARCHAR(255),
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (record_id) REFERENCES Medical_Records(record_id)
);

CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    symptom VARCHAR(255),
    created_time DATETIME,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Waiting
(
    waiting_id      INT PRIMARY KEY AUTO_INCREMENT,
    registration_id INT,
    patient_id      INT,
    waiting_count   INT,
    created_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status          ENUM ('접수', '취소', '완료') DEFAULT '접수' NOT NULL,
    FOREIGN KEY (registration_id) REFERENCES Registrations (registration_id),
    FOREIGN KEY (patient_id) REFERENCES Patients (patient_id)
);


-- InsertRegistration 프로시저 생성
CREATE PROCEDURE InsertOrUpdateRegistration(
    IN doctor_id_param INT,
    IN symptom_param VARCHAR(255),
    IN patient_name_param VARCHAR(30),
    IN identity_number_param VARCHAR(20),
    IN patient_phone_param VARCHAR(20),
    IN address_param VARCHAR(255)
)
BEGIN
    DECLARE today_day VARCHAR(10);
    DECLARE patient_id_param INT;

    -- 현재 요일을  조회한다.
    SET today_day = DAYNAME(NOW());

    -- 기존에 방문한 환자가 있는지 확인한다.
    SELECT patient_id INTO patient_id_param
    FROM Patients
    WHERE identity_number = identity_number_param;

    -- 기존 환자가 있다면? ->  환자 정보를 입력한 정보로 업데이트
    IF patient_id_param IS NOT NULL THEN
        UPDATE Patients
        SET
            patient_name = patient_name_param,
            patient_phone = patient_phone_param,
            address = address_param
        WHERE patient_id = patient_id_param;
    ELSE
        -- 기존 환자가 없으면? -> 새로운 환자 정보를 삽입하고 마지막 순번의 환자id 부여
        INSERT INTO Patients (patient_name, identity_number, patient_phone, address)
        VALUES (patient_name_param, identity_number_param, patient_phone_param, address_param);
        SET patient_id_param = LAST_INSERT_ID();
    END IF;

    -- 의사의 휴무일과 겹치지 않는 경우에만 접수가 가능하다.
    INSERT INTO Registrations (doctor_id, symptom)
    SELECT doctor_id_param, symptom_param
    FROM Doctors AS d
    JOIN Schedules AS s ON d.doctor_id = s.doctor_id
    WHERE d.doctor_id = doctor_id_param AND s.vacation_date != today_day;

    -- 삽입된 접수의 ID를 조회한다.
    SET @last_inserted_id = LAST_INSERT_ID();

    -- 대기 상태를 추가하고 이 상태의 값은 디폴트로 접수로 지정한다.
    INSERT INTO Waiting (registration_id, patient_id, waiting_count, status, created_time)
    SELECT @last_inserted_id, patient_id_param, COALESCE(MAX(waiting_count), 0) + 1, '접수', NOW()
    FROM Waiting;
END//

DELIMITER ;

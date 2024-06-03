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
    patient_authentication ENUM('N', 'Y') DEFAULT 'Y',
    del_yn ENUM('N', 'Y') DEFAULT 'N'
);

CREATE TABLE Manager (
    manager_id INT PRIMARY KEY AUTO_INCREMENT,
    department_id INT,
    manager_name VARCHAR(20) NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (department_id) REFERENCES Departments (department_id)
);

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_name VARCHAR(10) NOT NULL,
    department_id INT NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    office_number VARCHAR(10) NOT NULL,
    avg_rating FLOAT DEFAULT 0,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (department_id) REFERENCES Departments (department_id)
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
    visit_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (patient_id) REFERENCES Patients (patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id),
    FOREIGN KEY (manager_id) REFERENCES Manager (manager_id),
    FOREIGN KEY (department_id) REFERENCES Departments (department_id)
);

CREATE TABLE Payments (
    record_id INT,
    amount FLOAT,
    payment_date DATETIME NOT NULL,
    payment_method ENUM('온라인', '오프라인') DEFAULT '온라인' NOT NULL,
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (record_id) REFERENCES Medical_Records (record_id)
);

CREATE TABLE Schedules (
    doctor_id INT,
    vacation_date ENUM(
        'Sunday',
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday'
    ) DEFAULT 'Sunday',
    del_yn ENUM('N', 'Y') DEFAULT 'N',
    FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id)
);

CREATE TABLE Feedback (
    feedback_id int AUTO_INCREMENT,
    record_id int NOT NULL,
    rating int CHECK (
        rating > 0
        and rating <= 5
    ),
    feedback_text VARCHAR(255),
    del_yn enum('N', 'Y') DEFAULT 'N',
    PRIMARY KEY (feedback_id),
    UNIQUE KEY record_id (record_id),
    FOREIGN KEY (record_id) REFERENCES Medical_Records (record_id)
);

CREATE TABLE Registrations (
    registration_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    symptom VARCHAR(255),
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id)
);

CREATE TABLE Waiting (
    waiting_id INT PRIMARY KEY AUTO_INCREMENT,
    doctor_id INT NOT NULL,
    registration_id INT,
    patient_id INT,
    waiting_count INT,
    created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (registration_id) REFERENCES Registrations (registration_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors (doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients (patient_id)
);
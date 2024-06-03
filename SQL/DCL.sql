-- admin 사용자 생성 및 모든 권한 부여
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin_password';
GRANT ALL PRIVILEGES ON MediBooker.* TO 'admin'@'localhost';
FLUSH PRIVILEGES;

-- user 사용자 생성 및 SELECT 권한만 부여
CREATE USER 'user'@'localhost' IDENTIFIED BY 'user_password';
GRANT SELECT ON MediBooker.* TO 'user'@'localhost';
FLUSH PRIVILEGES;
# 📌 Registration 프로시저


## 프로시저 실행 이전
- 환자 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_before_patients.png" alt="환자테이블" width="1000" height="300"/>

- 접수 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_before_registrations.png" alt="접수테이블" width="1000" height="150"/>

- 대기 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_before_waiting.png" alt="대기테이블" width="1000" height="150"/>

---

## 1. 기존 환자 테이블에 존재하던 환자를 접수
 - 환자 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_after_patients.png" alt="환자테이블" width="1000" height="300"/>

- 접수 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_after_registrations.png" alt="접수테이블" width="1000" height="200"/>

- 대기 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_after_waiting.png" alt="대기테이블" width="1000" height="150"/>

---

## 2. 의사의 휴무일과 겹치는 날 접수(오류메시지 출력)

- 의사 휴무 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/2_doctor_schedule.png" alt="의사휴무테이블" width="1000" height="150"/>

- 프로시저 실행
<img src=".././img/testcase/InsertOrUpdateRegistration/Registration.gif" alt="프로시저 실행" width="1000" height="400"/>

---

## 3. 환자 테이블에 존재하지 않는 새로운 환자 접수

 - 환자 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/3_after_patients.png" alt="환자테이블" width="1000" height="300"/>

- 접수 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/3_after_registrations.png" alt="접수테이블" width="1000" height="200"/>

- 대기 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/3_after_waiting.png" alt="대기테이블" width="1000" height="150"/>
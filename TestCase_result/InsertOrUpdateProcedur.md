# 📌 Registration 프로시저
## 프로시저) InsertOrUpdateRegistration: 진료 접수 정보를 입력하면 진료 테이블과 대기 테이블에 정보가 생성
- 조건1 : 의사의 휴무일과 접수요일이 달라야 한다. 만약 같다면? -> 오류메시지 출력 (휴무일입니다.)
- 접수테이블에 접수 상태로 추가, 대기 테이블 추가, 환자 테이블 업데이트 또는 추가

## 프로시저 실행 이전
- 환자 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_before_patients.png" alt="환자테이블" width="1000" height="300"/>

- 접수 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_before_registrations.png" alt="접수테이블" width="1000" height="150"/>

- 대기 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_before_waiting.png" alt="대기테이블" width="1000" height="150"/>

---

## 1. 기존 환자 테이블에 존재하던 환자를 접수 
이미 환자 테이블에 존재하는 환자를 주민번호만 제외하고 나머지 정보는 수정하여 입력한다 -> 주민번호를 제외한 나머지 정보 업데이트(식별자 : 주민번호), 접수와 대기 테이블 추가
 - 환자 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_after_patients.png" alt="환자테이블" width="1000" height="300"/>

- 접수 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_after_registrations.png" alt="접수테이블" width="1000" height="200"/>

- 대기 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/1_after_waiting.png" alt="대기테이블" width="1000" height="150"/>

---

## 2. 접수 요일이 의사의 휴무일과 일치하는 경우 접수(오류메시지 출력)

- 의사 휴무 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/2_doctor_schedule.png" alt="의사휴무테이블" width="1000" height="150"/>

- 프로시저 실행
<img src=".././img/testcase/InsertOrUpdateRegistration/Registration.gif" alt="프로시저 실행" width="1000" height="500"/>

---

## 3. 환자 테이블에 존재하지 않는 새로운 환자 접수 
환자 테이블에 새로운 데이터 추가, 접수와 대기 테이블 추가
 - 환자 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/3_after_patients.png" alt="환자테이블" width="1000" height="300"/>

- 접수 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/3_after_registrations.png" alt="접수테이블" width="1000" height="200"/>

- 대기 테이블
<img src=".././img/testcase/InsertOrUpdateRegistration/3_after_waiting.png" alt="대기테이블" width="1000" height="150"/>
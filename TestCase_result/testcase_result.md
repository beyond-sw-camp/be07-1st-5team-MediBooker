## 새로운 회원 정보 추가

![1_before_patients.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/d65fcf05-6da4-497d-8044-a42b2e6e0683/1_before_patients.png)

## 진료 접수: 접수 정보(의사, 증상)를 입력하면 접수 테이블과 대기 테이블에 정보가 생성됨

- 접수 테이블

![1_before_registrations.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/0f5c9c58-8cce-4cb2-bfc0-e09ffa205ba6/1_before_registrations.png)

- 대기 테이블(줄서기)

![1_before_waiting.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/364f55fb-b18a-4881-b3fa-14947a999b5e/1_before_waiting.png)

## 프로시저) InsertOrUpdateRegistration: 진료 접수 정보를 입력하면 진료 테이블과 대기 테이블에 정보가 생성

- 조건: 의사의 휴무일과 접수요일이 달라야 한다. 만약 같다면? -> 오류메시지 출력 (휴무일입니다.)

**테스트 1** : 이미 환자 테이블에 존재하는 환자를 주민번호를 제외하고 나머지 정보는 수정하여 입력

→ 주민번호를 제외한 나머지 정보 업데이트(식별자 : 주민번호), 접수와 대기 테이블 추가

```sql
CALL InsertOrUpdateRegistration(
    1, -- doctor_id_param (의사 ID)
    '흉통', -- symptom_param (증상)
    '김지뿡', -- patient_name_param (환자 이름)
    '123456-1234567', -- identity_number_param (환자 ID)
    '010-7712-8132', -- patient_phone_param (환자 전화번호)
    '서울특별시 종로구 오르막길..' -- address_param (환자 주소)
);
```

- before
    
    ![1_before_patients.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/d65fcf05-6da4-497d-8044-a42b2e6e0683/1_before_patients.png)
    
- after
    - 이름, 전화번호, 주소지 변경
    
    ![1_after_patients.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/03a5ddc4-ead8-492d-926d-df66acd59287/1_after_patients.png)
    
    - 접수 테이블과 대기 테이블에 정보 생성
    
    ![1_after_registrations.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/e487891f-d84e-424b-a8e7-fca1d34b38b7/1_after_registrations.png)
    
    ![1_after_waiting.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/09d3d98f-0362-416b-91a9-5a50b327a995/1_after_waiting.png)
    

**테스트 2** : 의사의 휴무일과 일치하는 경우 데이터 입력 -> 오류메시지 ‘휴무입니다’출력

```sql

CALL InsertOrUpdateRegistration(
    3, -- 휴무인 doctor_id_param (의사 ID)
    '걸으면 허리 뿡', -- symptom_param (증상)
    '김창뿡', -- patient_name_param (환자 이름)
    '000604-3101943', -- identity_number_param (환자 ID)
    '010-8765-1225', -- patient_phone_param (환자 전화번호)
    '서울특별시 구로구 고척스카이돔' -- address_param (환자 주소)
);
```

![2_doctor_schedule.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/f8c27304-faa5-490b-bf5b-1bdb5c0e6eb0/2_doctor_schedule.png)

![2.gif](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/8bcdbdff-8f30-49c3-87a9-dfd482369fb7/2.gif)

**테스트 3** : 환자 테이블에 존재하지 않는 새로운 데이터를 입력 -> 환자 테이블에 새로운 데이터 추가, 접수와 대기 테이블 추가

```sql
CALL InsertOrUpdateRegistration(
    1, -- doctor_id_param (의사 ID)
    '방구쟁이', -- symptom_param (증상)
    '정뿡기', -- patient_name_param (환자 이름)
    '980213-2912307', -- identity_number_param (환자 ID)
    '010-6442-9981', -- patient_phone_param (환자 전화번호)
    '서울특별시 신대방 제2동 sfc빌딩' -- address_param (환자 주소)
);
```

- 새로운 사용자의 정보가 환자 정보 테이블에 생성

![3_after_patients.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/5f6296a7-7b45-4a1c-8b94-fa7e190f4471/3_after_patients.png)

- 접수 테이블과 웨이팅 테이블에 정보 생성

![3_after_registrations.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/10a8d590-8a45-40b6-9b3c-09540953830d/3_after_registrations.png)

![3_after_waiting.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/8615bc8d-8bb0-4716-af61-58b3a56be04b/3_after_waiting.png)

---

## 프로시저) InsertMediRecord: 진료 기록 추가 및 대기 테이블에서 삭제

- 진료 후 진료 기록을 작성
    - 환자id, 의사id, 진단 내용, 치료 내용, 처방 내용을 입력
- 조건: 대기 테이블에 일치하는 데이터(환자id, 의사id)가 있어야 함

**테스트 1** : 의사의 휴무일이 현재의 요일과 일치하는 경우 오류 메시지’@@@선생님은 오늘 휴무입니다’를 출력한다.

```sql
CALL InsertMediRecord ( 5, 5, '콧물 질질 줄줄', '콧물 다 빼버려', '파란 물약' );
```

![4_schedule.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/b1424703-10e9-44bf-9b0a-a6d692c58a96/4_schedule.png)

![4.gif](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/8cb8d19d-d47b-4e88-9305-fe38ed79258c/4.gif)

**테스트 2** : 입력받은 데이터와 일치하는 데이터가 대기 목록에 존재하지 않는 경우 오류 메시지를 출력한다.

- 대기 테이블에 일치하는 데이터(환자id, 의사id)가 없을시 오류 메세지 ’입력한 정보가 대기 목록에 존재하지 않습니다’출력

```sql
CALL InsertMediRecord ( 2, 3, '콧물 질질 줄줄', '콧물 다 빼버려', '파란 물약' );
```

![3_after_waiting.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/8615bc8d-8bb0-4716-af61-58b3a56be04b/3_after_waiting.png)

![5 (1).gif](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/b5af6ca1-e26c-4a34-99d3-178e48ecc11b/5_(1).gif)

**테스트 3** : 진료기록 추가 및 대기 데이터 삭제

- 진료 후 진료 기록을 작성하면 대기 테이블에 있던 데이터가 삭제됨

```sql
CALL InsertMediRecord ( 1, 1, '콧물 질질 줄줄', '콧물 다 빼버려', '파란 물약' );
```

- 진료 기록 추가
    - 추가 전 진료 기록 테이블
        
        ![before_medical_records.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/afe157a1-4fb3-492f-97ad-a9913d2be647/before_medical_records.png)
        
    - 추가 후 진료 기록 테이블
        
        ![6_after_medical_records.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/4eed6def-af4d-45f6-bc66-5f3955078e82/6_after_medical_records.png)
        
- 진료 기록 추가 시 대기 테이블에서 사용자의 정보 삭제됨
    - 진료 기록 추가 전 대기 테이블
        
        ![waiting.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/bb008380-be2f-4411-81d5-acf4a69ac54d/waiting.png)
        
    - 진료 기록 추가 후 대기 테이블
        
        ![6_after_waiting.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/86af494a-e501-4309-91ad-160c91452615/6_after_waiting.png)
        

---

## 프로시저)AddFeedbackAndUpdateRating*:* 진료 기록 작성 시 피드백 작성 가능

- 조건: 동일한 진료 id가 있을 시 피드백 작성 불가(이미 피드백을 작성한 진료)오류 출력
    - feedback 테이블에 존재하지 않는 record_id를 입력해야 한다. 만약 존재하는 record_id를 입력한다면? →오류 발생
- 진료 후 환자는 진료받은 의사에 대한 피드백(평점과 리뷰)을 작성할 수 있음
- 환자가 작성한 피드백은 의사 평점에 적용됨

**테스트 4**: feedback 테이블에 존재하지 않는 record_id와 평점, 리뷰를 작성한다. (현재 record_id 1~5까지 존재)

```sql
-- 피드백 입력 전 의사 평점 출력
SELECT FORMAT(avg_rating, 2) AS average_value from Doctors where doctor_id = 1;

-- 피드백 입력
call AddFeedbackAndUpdateRating(6, 3, '평범한 진료 실력입니다.');

-- 피드백 입력 후 의사 평점 출력
SELECT FORMAT(avg_rating, 2) AS average_value from Doctors where doctor_id = 2;

```

- 피드백 입력 전 피드백 테이블
    
    ![7_before_feedback.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/d2aaf224-0d53-4414-b832-20428a5caf85/7_before_feedback.png)
    
- 피드백 입력 후 피드백 테이블
    - feedback_id=6 생성
    
    ![7_after_feedback.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/7fe12cc4-e8e8-4ee2-9eb2-8a9d96efc8f8/7_after_feedback.png)
    
- 피드백 작성전 의사 평점
    
    ![before_avg.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/d1687156-8158-4d3d-badc-7e5787abfb02/before_avg.png)
    
- 피드백 작성 후 의사 평점
    
    ![after_avg.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/6fd1ea91-6ba3-4987-a332-e6045855d9e7/after_avg.png)
    

**테스트 4-1**: 동일한 진료 id가 있을 시 피드백 작성 불가(이미 피드백을 작성한 진료)오류 출력

```sql
-- 테스트 4-1. feedback 테이블에 존재하는 record_id 사용 -> 오류 발생
call AddFeedbackAndUpdateRating(6, 3, '평범한 진료 실력입니다.');
```

![7.gif](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/d02b61b8-5a13-472c-a2bc-46429d628aa3/7.gif)

---

- 환자id와 주민번호 입력시 진료 기록 조회 (환자)
    
    ```sql
    -- 환자id와 주민번호 입력시 진료 기록 조회 (환자)
    SELECT * 
    FROM Medical_Records
    WHERE patient_id = 1;
    ```
    
    ![select_patients.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/1c068782-c2db-4243-8ca6-c60199175180/select_patients.png)
    

- 진료 기록 전체 조회 (관리자)
- 진료 기록 전체 조회 (관리자)
    
    ```sql
    -- 진료 기록 전체 조회 (관리자)
    SELECT * FROM Medical_Records;
    ```
    
    ![select_manager.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/38ed4cf7-4813-49b9-8302-b321bb35278f/d966eebd-2f37-44f0-8c54-8cb1feb203e7/select_manager.png)
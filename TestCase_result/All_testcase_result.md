## 새로운 회원 정보 추가

![1_before_patients.png](/img/testcase/InsertOrUpdateRegistration/1_before_patients.png)

## 진료 접수: 접수 정보(의사, 증상)를 입력하면 접수 테이블과 대기 테이블에 정보가 생성됨

- 접수 테이블

![1_before_registrations.png](/img/testcase/InsertOrUpdateRegistration/1_before_registrations.png)

- 대기 테이블(줄서기)

![1_before_waiting.png](/img/testcase/InsertOrUpdateRegistration/1_before_waiting.png)

---

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
    
    ![1_before_patients.png](/img/testcase/InsertOrUpdateRegistration/1_before_patients.png)
    
- after
    - 이름, 전화번호, 주소지 변경
    
    ![1_after_patients.png](/img/testcase/InsertOrUpdateRegistration/1_after_patients.png)
    
    - 접수 테이블과 대기 테이블에 정보 생성
    
    ![1_after_registrations.png](/img/testcase/InsertOrUpdateRegistration/1_after_registrations.png)
    
    ![1_after_waiting.png](/img/testcase/InsertOrUpdateRegistration/1_after_waiting.png)
    


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

![2_doctor_schedule.png](/img/testcase/InsertOrUpdateRegistration/4_new_doctor_schedule.png)

![2.gif](/img/testcase/InsertOrUpdateRegistration/2.gif)



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

![3_after_patients.png](/img/testcase/InsertOrUpdateRegistration/3_after_patients.png)

- 접수 테이블과 웨이팅 테이블에 정보 생성

![3_after_registrations.png](/img/testcase/InsertOrUpdateRegistration/3_after_registrations.png)

![3_after_waiting.png](/img/testcase/InsertOrUpdateRegistration/3_after_waiting.png)

---

## 프로시저) InsertMediRecord: 진료 기록 추가 및 대기 테이블에서 삭제

- 진료 후 진료 기록을 작성
    - 환자id, 의사id, 진단 내용, 치료 내용, 처방 내용을 입력
- 조건: 대기 테이블에 일치하는 데이터(환자id, 의사id)가 있어야 함



**테스트 1** : 의사의 휴무일이 현재의 요일과 일치하는 경우 오류 메시지’@@@선생님은 오늘 휴무입니다’를 출력한다.

```sql
CALL InsertMediRecord ( 13, 3, '콧물 질질 줄줄', '콧물 다 빼버려', '파란 물약' );
```

![4_schedule.png](/img/testcase/InsertMediRecord/4_schedule.png)

![4.gif](/img/testcase/InsertMediRecord/4.gif)

**테스트 2** : 입력받은 데이터와 일치하는 데이터가 대기 목록에 존재하지 않는 경우 오류 메시지를 출력한다.

- 대기 테이블에 일치하는 데이터(환자id, 의사id)가 없을시 오류 메세지 ’입력한 정보가 대기 목록에 존재하지 않습니다’출력

```sql
CALL InsertMediRecord ( 13, 2, '콧물 질질 줄줄', '콧물 다 빼버려', '파란 물약' );
```

![3_after_waiting.png](/img/testcase/InsertOrUpdateRegistration/3_after_waiting.png)

![5 (1).gif](/img/testcase/InsertMediRecord/5.gif)

**테스트 3** : 진료기록 추가 및 대기 데이터 삭제

- 진료 후 진료 기록을 작성하면 대기 테이블에 있던 데이터가 삭제됨

```sql
CALL InsertMediRecord ( 13, 1, '콧물 질질 줄줄', '콧물 다 빼버려', '파란 물약' );
```

- 진료 기록 추가
    - 추가 전 진료 기록 테이블
        
        ![before_medical_records.png](/img/testcase/InsertMediRecord/before_medical_records.png)
        
    - 추가 후 진료 기록 테이블
        
        ![6_after_medical_records.png](/img/testcase/InsertMediRecord/6_after_medical_records.png)
        
- 진료 기록 추가 시 대기 테이블에서 사용자의 정보 삭제됨
    - 진료 기록 추가 전 대기 테이블
        
        ![waiting.png](/img/testcase/InsertMediRecord/waiting.png)
        
    - 진료 기록 추가 후 대기 테이블
        
        ![6_after_waiting.png](/img/testcase/InsertMediRecord/6_after_waiting.png)
        

---

## 프로시저)AddFeedbackAndUpdateRating: 진료 기록 작성 시 피드백 작성 가능

- 조건: 동일한 진료 id가 있을 시 피드백 작성 불가(이미 피드백을 작성한 진료)오류 출력
    - feedback 테이블에 존재하지 않는 record_id를 입력해야 한다. 만약 존재하는 record_id를 입력한다면? →오류 발생
- 진료 후 환자는 진료받은 의사에 대한 피드백(평점과 리뷰)을 작성할 수 있음
- 환자가 작성한 피드백은 의사 평점에 적용됨


**테스트 1**: feedback 테이블에 존재하지 않는 record_id와 평점, 리뷰를 작성한다. (현재 record_id 1~5까지 존재)

```sql
-- 피드백 입력 전 의사 평점 출력
SELECT FORMAT(avg_rating, 2) AS average_value from Doctors where doctor_id = 1;

-- 피드백 입력
call AddFeedbackAndUpdateRating(6, 1, '평범한 진료 실력입니다.');

-- 피드백 입력 후 의사 평점 출력
SELECT FORMAT(avg_rating, 2) AS average_value from Doctors where doctor_id = 1;

```

- 피드백 입력 전 피드백 테이블
    
    ![7_before_feedback.png](/img/testcase/AddFeedbackAndUpdateRating/7_before_feedback.png)
    
- 피드백 입력 후 피드백 테이블
    - feedback_id=6 생성
    
    ![7_after_feedback.png](/img/testcase/AddFeedbackAndUpdateRating/7_re_after_feedback.png)
    
- 피드백 작성전 의사 평점
    
    ![before_avg.png](/img/testcase/AddFeedbackAndUpdateRating/befor_avg2.png)
    
- 피드백 작성 후 의사 평점
    
    ![after_avg.png](/img/testcase/AddFeedbackAndUpdateRating/after_avg2.png)
    

**테스트 2**: 동일한 진료 id가 있을 시 피드백 작성 불가(이미 피드백을 작성한 진료)오류 출력

```sql
-- 테스트 4-1. feedback 테이블에 존재하는 record_id 사용 -> 오류 발생
call AddFeedbackAndUpdateRating(6, 1, '평범한 진료 실력입니다.');
```

![7.gif](/img/testcase/AddFeedbackAndUpdateRating/7_re.gif)

---

- 환자id와 주민번호 입력시 진료 기록 조회 (환자)
    
    ```sql
    -- 환자id와 주민번호 입력시 진료 기록 조회 (환자)
    SELECT * 
    FROM Medical_Records
    WHERE patient_id = 13;
    ```
    
    ![select_patients.png](/img/testcase/select_patients.png)
    

- 진료 기록 전체 조회 (관리자)
    
    ```sql
    -- 진료 기록 전체 조회 (관리자)
    SELECT * FROM Medical_Records;
    ```
    
    ![select_manager.png](/img/testcase/select_manager.png)

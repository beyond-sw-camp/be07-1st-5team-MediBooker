# 📌 FeedBack 프로시저

## 프로시저)AddFeedbackAndUpdateRating: 진료 기록 작성 시 피드백 작성 가능
- 조건: 동일한 진료 id가 있을 시 피드백 작성 불가(이미 피드백을 작성한 진료)오류 출력
    - feedback 테이블에 존재하지 않는 record_id를 입력해야 한다. 만약 존재하는 record_id를 입력한다면? →오류 발생
- 진료 후 환자는 진료받은 의사에 대한 피드백(평점과 리뷰)을 작성할 수 있음
- 환자가 작성한 피드백은 의사 평점에 적용됨

## 1. feedback 테이블에 존재하지 않는 record_id와 평점, 리뷰를 작성한다. (현재 record_id 1~5까지 존재)
- 피드백 입력 전 피드백 테이블
<img src=".././img/testcase/AddFeedbackAndUpdateRating/7_before_feedback.png" alt="이전_피드백테이블" width="1000" height="200"/>

- 피드백 입력 후 피드백 테이블
<img src=".././img/testcase/AddFeedbackAndUpdateRating/7_after_feedback.png" alt="결과_피드백테이블" width="1000" height="200"/>

```sql
-- 피드백 입력
call AddFeedbackAndUpdateRating(6, 3, '평범한 진료 실력입니다.');
```

- 피드백 입력 전 의사 평점 테이블
<img src=".././img/testcase/AddFeedbackAndUpdateRating/before_avg2.png" alt="이전_의사평점테이블" width="1000" height="200"/>

- 피드백 입력 후 의사 평점 테이블
<img src=".././img/testcase/AddFeedbackAndUpdateRating/before_avg2.png" alt="결과_의사평점테이블" width="1000" height="200"/>

```sql
-- 피드백 입력 전 의사 평점 출력
SELECT FORMAT(avg_rating, 2) AS average_value from Doctors where doctor_id = 1;

-- 피드백 입력 후 의사 평점 출력
SELECT FORMAT(avg_rating, 2) AS average_value from Doctors where doctor_id = 2;
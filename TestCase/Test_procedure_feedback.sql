-- 조건: feedback 테이블에 존재하지 않는 record_id를 입력해야 한다. 만약 존재하는 record_id를 입력한다면? -> 오류 발생


-- 테스트 1: feedback 테이블에 존재하지 않는 record_id와 평점, 리뷰를 작성한다. (현재 record_id 1~5까지 존재)
-- 피드백 입력 전 의사 평점 출력
SELECT FORMAT(avg_rating, 2) AS average_value from Doctors where doctor_id = 1;

-- 피드백 입력
call AddFeedback(6, 3, '평범한 진료 실력입니다.');

-- 피드백 입력 후 의사 평점 출력
SELECT FORMAT(avg_rating, 2) AS average_value from Doctors where doctor_id = 2;



-- 테스트 2. feedback 테이블에 존재하는 record_id 사용 -> '존재하는 리뷰입니다.'
call AddFeedback(6, 3, '평범한 진료 실력입니다.');



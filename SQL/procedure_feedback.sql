DELIMITER //

CREATE PROCEDURE AddFeedbackAndUpdateRating(
    IN p_record_id INT,
    IN p_rating INT,
    IN p_feedback_text VARCHAR(255)
)
BEGIN
    -- 1. 필요한 변수 선언
    DECLARE v_doctor_id INT;
    DECLARE v_avg_rating FLOAT;

    -- 2. 새로운 피드백을 추가
    INSERT INTO Feedback (record_id, rating, feedback_text) 
    VALUES (p_record_id, p_rating, p_feedback_text);

    -- 3. 피드백이 추가된 record_id에 해당하는 doctor_id를 가져오기
    SELECT doctor_id INTO v_doctor_id
    FROM Medical_Records
    WHERE record_id = p_record_id;

    -- 4. 해당 의사의 평균 평점을 계산
    SELECT AVG(rating) INTO v_avg_rating
    FROM Feedback
    WHERE record_id IN (
        SELECT record_id
        FROM Medical_Records
        WHERE doctor_id = v_doctor_id
    );

    -- 5. 의사의 평균 평점을 업데이트
    UPDATE Doctors
    SET avg_rating = v_avg_rating
    WHERE doctor_id = v_doctor_id;
END //

DELIMITER ;

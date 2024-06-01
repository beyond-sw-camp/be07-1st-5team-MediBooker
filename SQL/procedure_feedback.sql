DELIMITER //

CREATE PROCEDURE AddFeedback (
    IN p_record_id INT,
    IN p_rating INT,
    IN p_feedback_text VARCHAR(255)
)
BEGIN
    -- 필요한 변수 선언
    DECLARE v_doctor_id INT;
    DECLARE v_avg_rating FLOAT;

    -- 피드백이 이미 존재하는지 확인
    IF EXISTS (SELECT 1 FROM Feedback WHERE record_id = p_record_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '이미 존재하는 리뷰입니다.';
    ELSE
        -- 새로운 피드백을 추가
        INSERT INTO Feedback (record_id, rating, feedback_text)
        VALUES (p_record_id, p_rating, p_feedback_text);

        -- 피드백이 추가된 record_id에 해당하는 doctor_id를 가져오기
        SELECT doctor_id INTO v_doctor_id
        FROM Medical_Records
        WHERE record_id = p_record_id;

        -- 해당 의사의 평균 평점을 계산
        SELECT AVG(rating) INTO v_avg_rating
        FROM Feedback
        WHERE record_id IN (
            SELECT record_id
            FROM Medical_Records
            WHERE doctor_id = v_doctor_id
        );

        -- 의사의 평균 평점을 업데이트
        UPDATE Doctors
        SET avg_rating = v_avg_rating
        WHERE doctor_id = v_doctor_id;
    END IF;
END //

DELIMITER ;

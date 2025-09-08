USE DataAnalytics 
GO
SELECT * FROM courses;
SELECT * FROM enrollments;
SELECT * FROM users;
-- overall course completion rate
SELECT 
    ROUND(
        100.0 * COUNT(CASE WHEN completion_status = 'Completed' THEN 1 END) 
        / COUNT(*), 2
    ) AS course_completion_rate_percent
FROM enrollments;
-- drop out status
SELECT 
    ROUND(
        100.0 * COUNT(CASE WHEN completion_status = 'Not Started' THEN 1 END) 
        / COUNT(*), 2
    ) AS dropout_rate_percent
FROM enrollments;
SELECT completion_status FROM enrollments

-- Top 5 Most Active Learners
 SELECT Top 5 u.name AS Top_5_Most_Active_Students, e.progress_percent AS Progress_percentage
 FROM users u 
 INNER JOIN enrollments e 
 ON u.user_id=e.user_id
 WHERE e.progress_percent>60
 ORDER BY e.progress_percent DESC;

-- Completion by Difficulty Level
-- Do students complete beginner courses more than advanced ones?
SELECT c.course_level AS Course_Level, COUNT(e.user_id) AS Number_Of_Completed_Courses
FROM courses c 
INNER JOIN enrollments e 
ON c.course_id=e.course_id
WHERE e.progress_percent>75
GROUP BY c.course_Level
ORDER BY Number_Of_Completed_Courses DESC;

-- Courses with Highest Dropout Rate
-- Which course has the highest dropout percentage?
SELECT TOP 5 c.course_name AS Course_Name, Count(e.user_id) AS Dropout_Count
FROM courses c
INNER JOIN enrollments e
ON c.course_id=e.course_id
WHERE e.progress_percent<30
GROUP BY c.course_name
ORDER BY Dropout_Count DESC;

-- Number Of Courses Completed

WITH completed_course_cte AS
(SELECT course_id ,user_id, completion_status
FROM enrollments 
WHERE completion_status= 'Completed')
SELECT u.name,c.course_name,cc.completion_status
FROM courses c
JOIN completed_course_cte cc ON c.course_id=cc.course_id
JOIN users u ON cc.user_id=u.user_id;

SELECT completion_status
FROM enrollments;
-- Percentage Of each completion Status
SELECT 
    completion_status,
    COUNT(*) AS status_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM enrollments
GROUP BY completion_status
ORDER BY percentage DESC;

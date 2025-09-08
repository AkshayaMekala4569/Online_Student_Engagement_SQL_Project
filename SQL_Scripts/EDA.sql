USE DataAnalytics
GO
--User Demographics
SELECT COUNT(*) AS total_users FROM Users;
-- Gender Wise Count
SELECT gender, COUNT(*) AS user_count
FROM Users
GROUP BY gender;
-- Number Of Users In Each Group
SELECT
  CASE
    WHEN age < 18 THEN 'Under 18'
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 45 THEN '36-45'
    ELSE '46+'
  END AS age_group,
  COUNT(*) AS user_count
FROM Users
GROUP BY 
  CASE
    WHEN age < 18 THEN 'Under 18'
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 45 THEN '36-45'
    ELSE '46+'
  END
ORDER BY age_group;

-- Month wise Sign Ups
SELECT
  FORMAT(signup_date, 'yyyy-MM') AS signup_month,
  COUNT(*) AS signups
FROM Users
GROUP BY FORMAT(signup_date, 'yyyy-MM')
ORDER BY signup_month;

-- Number Of Users in each Country
SELECT country, COUNT(*) AS signups
FROM users
GROUP BY country
ORDER BY signups DESC;
-- Course Catalog Analysis
SELECT category, COUNT(*) AS No_of_courses
FROM courses 
GROUP BY category
ORDER BY No_of_courses DESC;
SELECT 
    FORMAT(created_date, 'yyyy-MM') AS launch_month,
    COUNT(*) AS total_launched
FROM Courses
GROUP BY FORMAT(created_date, 'yyyy-MM')
ORDER BY launch_month;
-- Engagement and Learning Behavior
WITH popular_course_cte AS (
SELECT course_id, COUNT(*) AS No_of_enrollments
FROM enrollments
GROUP BY course_id
)
SELECT  c.course_id, c.course_name,p.No_of_enrollments
FROM popular_course_cte p
JOIN courses c ON p.course_id=c.course_id
ORDER BY No_of_enrollments DESC;

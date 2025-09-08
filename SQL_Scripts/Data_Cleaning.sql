USE DataAnalytics
GO
SELECT * FROM enrollments;
--first Query
WITH duplicate_cte AS
(SELECT user_id,course_id,COUNT(*)AS times_enrolled
FROM enrollments
GROUP BY user_id,course_id
HAVING COUNT(*)>1)
SELECT d.user_id,d.course_id,d.times_enrolled,e.enrollment_date,e.completion_status
FROM duplicate_cte d
JOIN enrollments e ON d.user_id=e.user_id 
AND d.course_id=e.course_id
ORDER BY d.user_id,d.course_id, e.enrollment_date;
--second Query
WITH ranked_enrollments AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id, course_id 
               ORDER BY 
                   CASE 
                       WHEN completion_status = 'Yes' THEN 0 
                       ELSE 1 
                   END,  -- Prioritize 'Yes'
                   enrollment_date DESC
           ) AS rn
    FROM enrollments
),
duplicates_to_delete AS (
    SELECT *
    FROM ranked_enrollments
    WHERE rn > 1  -- Keep only the best 1, delete the rest
)
SELECT *
FROM duplicates_to_delete
ORDER BY user_id, course_id, enrollment_date;
--Just a trial to see how the change of completion_status works based on the progress _percent column
SELECT 
  *,
  CASE 
    WHEN progress_percent = 100 THEN 'Completed'
    WHEN progress_percent > 85 THEN 'Almost Done'
    WHEN progress_percent > 30 THEN 'In Progress'
    WHEN progress_percent> 0 THEN 'Just Started'
    ELSE 'Not Started'
  END AS updated_status
FROM enrollments;
--DEcided to change or update the table using the above criteria
UPDATE enrollments
SET completion_status = 
  CASE 
    WHEN progress_percent = 100 THEN 'Completed'
    WHEN progress_percent  > 85 THEN 'Almost Done'
    WHEN progress_percent  > 30 THEN 'In Progress'
    WHEN progress_percent  > 0 THEN 'Just Started'
    ELSE 'Not Started'
  END;
  SELECT * FROM enrollments
  --checking which rows of the duplicates get deleted 
  WITH RankedEnrollments AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY user_id, course_id
            ORDER BY 
              CASE 
                WHEN completion_status = 'Completed' THEN 4
                WHEN completion_status = 'Almost Done' THEN 3
                WHEN completion_status = 'In Progress' THEN 2
                WHEN completion_status = 'Just Started' THEN 1
                ELSE 0
              END DESC,
              progress_percent DESC,
              enrollment_date DESC
        ) AS rn
    FROM enrollments
)
SELECT *
FROM RankedEnrollments
WHERE rn >1;
--Yes now deleting those duplicated rows from the enrollments table
WITH RankedEnrollments AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY user_id, course_id
            ORDER BY 
                CASE 
                    WHEN completion_status = 'Completed' THEN 4
                    WHEN completion_status = 'Almost Done' THEN 3
                    WHEN completion_status = 'In Progress' THEN 2
                    WHEN completion_status = 'Just Started' THEN 1
                    ELSE 0
                END DESC,
                progress_percent DESC,
                enrollment_date DESC
        ) AS rn
    FROM enrollments
)
DELETE FROM enrollments
WHERE enrollment_id IN (
    SELECT enrollment_id
    FROM RankedEnrollments
    WHERE rn > 1
);
SELECT * FROM enrollments
SELECT * FROM users
--checking for any duplicated emails in the users table
SELECT email, COUNT(*) AS email_count
FROM users
GROUP BY email
HAVING COUNT(*) > 1
--Checking if any user is having more than one email id
SELECT name,gender,age,country, COUNT(DISTINCT email) as email_count
FROM users
GROUP BY name,gender,age,country
HAVING COUNT(DISTINCT email) >1;
-- checking for duplicates in users table
SELECT *
FROM users
WHERE email IS NULL OR email NOT LIKE '%_@__%.__%';

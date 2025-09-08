# Student Engagement Analysis SQL Project

## Project Overview
This project analyzes student engagement on an online course platform using SQL.  
It covers **data cleaning, exploratory data analysis (EDA), and KPI analysis**, providing insights into student behavior, course performance, and engagement trends.  

## Dataset Overview
The dataset consists of three main tables:

1. **Users** – student information:
   - `user_id`, `name`, `email`, `gender`, `age`, `signup_date`
2. **Courses** – course information:
   - `course_id`, `course_name`, `course_level` (Beginner, Intermediate, Advanced)
3. **Enrollments** – tracks student enrollment and progress:
   - `user_id`, `course_id`, `progress_percent`

These tables were used to calculate KPIs and understand trends such as course completion, dropout rates, and active student behavior.

## Analysis Steps

### 1. Data Cleaning
- Removed duplicate records.  
- Ensured `progress_percent` is within 0–100.  
- Verified consistency across `Users`, `Courses`, and `Enrollments` tables.  
*(SQL scripts for cleaning are in `SQL_Scripts/Data_Cleaning.sql`.)*

### 2. Exploratory Data Analysis (EDA)
Key areas analyzed:
- **Completion by Difficulty Level**  
- **Country-wise Signups**  
- **Course Catalog Analysis**  
- **Top 5 Dropped Out Courses**  
- **Gender-wise Count**  
- **Month-wise Signups**  
- **Number of Completed Courses**  
- **Enrollments per Course**  
- **Users in Each Group**  
- **Overall Course Completion Rate**  
- **Completion Status Percentage**  
- **Top 5 Active Students**  
- **Total Users**  

*(SQL scripts for EDA are in `SQL_Scripts/EDA.sql`. Screenshots are in `Screenshots/`.)*

### 3. KPI Analysis
- Calculated course completion rates, dropout percentages, top-performing students, and engagement trends.  
- Identified insights like which courses need improvement and which student segments are most active.  
*(SQL scripts are in `SQL_Scripts/KPI_Analysis.sql`.)*

## Repository Structure
Student_Engagement_SQL_Project/
├── SQL_Scripts/ # SQL scripts for Data Cleaning, EDA, and KPI analysis
├── Documentation/ # Project documentation PDF
├── Screenshots/ # Screenshots of query results and charts
└── README.md # Project overview, structure, and insights

## Tools Used
- **SQL Server** – Querying and analysis  
- **MS Word / PDF** – Project documentation  
- **GitHub** – Hosting and version control  

## Key Insights
- Beginner courses have higher completion rates compared to advanced courses.  
- Some courses have significant dropout rates, highlighting areas for improvement.  
- Top 5 active students consistently progress through multiple courses.  
- Gender and country-wise analysis reveal engagement patterns among different student groups.  
- Monthly signup trends help understand peak enrollment periods.  

## Conclusion
This project demonstrates a **real-world SQL data analysis workflow**: from raw data cleaning to insights generation.  
All queries can be reproduced in SQL Server, and the screenshots show the results clearly.  
The project provides actionable insights for improving student engagement on an online learning platform.

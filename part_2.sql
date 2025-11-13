-- Q1 --
SELECT CATEGORY_TITLE FROM table_youtube_category 
GROUP BY CATEGORY_TITLE
HAVING COUNT(CATEGORY_TITLE)>1;

-- Q2 --
SELECT CATEGORY_TITLE FROM table_youtube_category 
GROUP BY CATEGORY_TITLE
HAVING COUNT(COUNTRY)=1;

-- Q3 --
SELECT CATEGORYID, COUNT(*) FROM table_youtube_final 
WHERE CATEGORY_TITLE IS NULL
GROUP BY CATEGORYID;

-- Q4 --
UPDATE table_youtube_final 
SET table_youtube_final.CATEGORY_TITLE = table_youtube_final.CATEGORYID
WHERE CATEGORY_TITLE IS NULL;

-- Q5 --
SELECT TITLE FROM table_youtube_final
WHERE CHANNELTITLE IS NULL;

-- Q6 --
DELETE FROM table_youtube_final
WHERE VIDEO_ID = '#NAME?';

-- Q7 --
CREATE OR REPLACE TABLE table_youtube_duplicates AS (
WITH t1 AS (SELECT *,ROW_NUMBER() OVER (PARTITION BY VIDEO_ID,COUNTRY,TRENDING_DATE ORDER BY VIEW_COUNT DESC)
AS ROW_NUMBER 
FROM table_youtube_final)
SELECT * EXCLUDE ROW_NUMBER FROM t1 WHERE ROW_NUMBER != 1);

-- Q8 --
DELETE FROM table_youtube_final 
USING table_youtube_duplicates WHERE table_youtube_final.ID = table_youtube_duplicates.ID;

-- Q9 --
SELECT COUNT(*) FROM table_youtube_final;

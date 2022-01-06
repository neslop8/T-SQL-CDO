IF OBJECT_ID('#tmp') IS NOT NULL DROP TABLE #tmp
CREATE TABLE #tmp ( query VARCHAR(MAX) )

INSERT INTO #tmp
SELECT  m.definition + char(13) + 'Go'
FROM sys.sql_modules as M inner join sys.objects as O
on
M.object_id=o.object_id
where O.type='Tr'

SELECT * FROM #tmp WHERE query like '%CrExamenesPendientes%'
DROP TABLE #tmp



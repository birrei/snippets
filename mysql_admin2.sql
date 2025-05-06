/*
Aus allen Tabellen einer Datenbank das letzte Einfüge-Datum (Feld ts_insert) auslesen 
*/

SELECT concat('SELECT \'', TABLE_NAME,'\' as tab,  MAX(ts_insert) max_ts_insert FROM ', TABLE_NAME, ' UNION ALL ') as query
-- SELECT concat('SELECT \'', TABLE_NAME,'\' as tab,  MAX(ts_insert) max_ts_insert FROM ', TABLE_NAME, ';') as query
FROM information_schema.TABLES 
where TABLE_TYPE ='BASE TABLE'
and TABLE_SCHEMA ='test'
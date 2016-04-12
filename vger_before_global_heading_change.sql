set echo off
set termout off

-- ignore errors if tables don't already exist
DROP TABLE tmp_heading_change;
DROP TABLE tmp_heading_change_fields;
DROP TABLE tmp_heading_change_queue;
CREATE TABLE tmp_heading_change AS SELECT * FROM heading_change;
-- Bib records only
CREATE TABLE tmp_heading_change_fields AS SELECT * FROM heading_change_fields WHERE rec_type = 'B';
CREATE TABLE tmp_heading_change_queue AS SELECT * FROM heading_change_queue;
QUIT;

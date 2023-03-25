-- Drop a table

DROP TABLE OFFENSE;

-- create table for Offense that is commited by Driver and is commited in Motor vehicle
CREATE TABLE OFFENSE (
    OFFENSE_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    OFFENSE_DATE_TIME DATE, -- type DATE contains date as well as time so offense_time ommited
 -- location of the offense split into street, city, state, zip for querying later
    OFFENSE_LOCATION_STREET VARCHAR( 100 ) NOT NULL,
    OFFENSE_LOCATION_CITY VARCHAR( 50 ) NOT NULL,
    OFFENSE_LOCATION_STATE VARCHAR( 2 ) NOT NULL DEFAULT 'CZ', -- should always be CZ
    OFFENSE_LOCATION_ZIP VARCHAR2( 5 ) CONSTRAINT OFFENSE_LOCATION_ZIP_CHECK CHECK (REGEXP_LIKE(OFFENSE_LOCATION_ZIP, '^\\d{5}\\s\\(\\d{3}\\s\\d{2}\\)$')),
    OFFENSE_TYPE VARCHAR2( 50 ),
    OFFENSE_DESCRIPTION VARCHAR2( 500 ), -- description of the offense
    OFFENSE_POINTS INT NOT NULL CONSTRAINT OFFENSE_POINTS_CHECK CHECK ( OFFENSE_POINTS >= 0 AND OFFENSE_POINTS <= 12 ),
    OFFENSE_FINE INT DEFAULT 0 NOT NULL, -- always in czech crowns
    OFFENSE_LABEL VARCHAR2( 50 )
);

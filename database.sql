-- Drop a table

-- must be dropped before DRIVER and MOTOR_VEHICLE
DROP TABLE OFFENSE;




DROP TABLE PERSON;

DROP TABLE INSURANCE;

-- create table for Insurance that Person is under
CREATE TABLE INSURANCE (
    INSURANCE_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    INSURANCE_NAME VARCHAR2( 50 ) NOT NULL,
    INSURANCE_POLICY_NUMBER VARCHAR2( 50 ) NOT NULL, -- policy number is not always a number, so it is not constrained
    INSURANCE_STREET VARCHAR2( 100 ) NOT NULL,
    INSURANCE_HOUSE_NUMBER INT NOT NULL,
    INSURANCE_CITY VARCHAR2( 50 ) NOT NULL,
    INSURANCE_STATE VARCHAR2( 2 ) DEFAULT 'CZ' NOT NULL, -- should always be CZ
    INSURANCE_ZIP VARCHAR2( 5 ) CONSTRAINT INSURANCE_ZIP_CHECK CHECK (REGEXP_LIKE(INSURANCE_ZIP, '^\\d{5}\\s\\(\\d{3}\\s\\d{2}\\)$'))
);

-- create table for Person that is either Driver (who commits an offense and is licensed to drive a Motor vehicle) or Vehicle owner
CREATE TABLE PERSON (
    PERSON_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    PERSON_NAME VARCHAR2(50) NOT NULL,
    PERSON_SURNAME VARCHAR2(50) NOT NULL,
    PERSON_AGE INT NOT NULL CONSTRAINT PERSON_AGE_CHECK CHECK (PERSON_AGE >= 0),
    PERSON_SEX VARCHAR2(1) NOT NULL CONSTRAINT PERSON_SEX_CHECK CHECK (PERSON_SEX = 'M' OR PERSON_SEX = 'F'),
    PERSON_GENDER VARCHAR2(50), -- gender is not always male or female, so it is not constrained
    PERSON_INSURANCE_ID INT, -- insurance that that Person is under, can be null
    PERSON_PERSONAL_ID VARCHAR2(10) NOT NULL CONSTRAINT PERSON_PERSONAL_ID_CHECK CHECK (REGEXP_LIKE(PERSON_PERSONAL_ID, '^(\\d{2})(\\d{2})(\\d{2})\\/?(\\d{3,4})$')), -- does not contain / or - in the middle
    PERSON_BIRTH_DATE DATE NOT NULL,
    PERSON_STREET VARCHAR2(100) NOT NULL,
    PERSON_HOUSE_NUMBER INT NOT NULL,
    PERSON_CITY VARCHAR2(50) NOT NULL,
    PERSON_STATE VARCHAR2(2) DEFAULT 'CZ' NOT NULL, -- should always be CZ
    PERSON_ZIP VARCHAR2(5) CONSTRAINT PERSON_ZIP_CHECK CHECK (REGEXP_LIKE(PERSON_ZIP, '^\\d{5}\\s\\(\\d{3}\\s\\d{2}\\)$')),
    CONSTRAINT PERSON_INSURANCE_ID_FK FOREIGN KEY (PERSON_INSURANCE_ID) REFERENCES INSURANCE (INSURANCE_ID) -- FK to Insurance
);
-- create table for Offense that is commited by Driver and is commited in a Motor vehicle
CREATE TABLE OFFENSE (
    OFFENSE_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    OFFENSE_DRIVER_ID INT NOT NULL, -- Driver that commits an offense
    OFFENSE_MOTOR_VEHICLE_ID INT NOT NULL, -- Motor vehicle that the offense was commited in
    OFFENSE_DATE_TIME DATE, -- type DATE contains date as well as time so offense_time ommited
    OFFENSE_LOCATION_STREET VARCHAR2(100) NOT NULL,
    OFFENSE_LOCATION_CITY VARCHAR2(50) NOT NULL,
    OFFENSE_LOCATION_STATE VARCHAR2(2) DEFAULT 'CZ' NOT NULL,
    OFFENSE_LOCATION_ZIP VARCHAR2(5) CONSTRAINT OFFENSE_LOCATION_ZIP_CHECK CHECK (REGEXP_LIKE(OFFENSE_LOCATION_ZIP, '^\\d{5}\\s\\(\\d{3}\\s\\d{2}\\)$')),
    OFFENSE_TYPE VARCHAR2(50),
    OFFENSE_DESCRIPTION VARCHAR2(500), -- description of the offense
    OFFENSE_POINTS INT NOT NULL CONSTRAINT OFFENSE_POINTS_CHECK CHECK (OFFENSE_POINTS >= 0 AND OFFENSE_POINTS <= 12),
    OFFENSE_FINE INT DEFAULT 0 NOT NULL, -- always in czech crowns
    OFFENSE_LABEL VARCHAR2(50) DEFAULT NULL,
    CONSTRAINT OFFENSE_DRIVER_ID_FK FOREIGN KEY (OFFENSE_DRIVER_ID) REFERENCES DRIVER (DRIVER_ID), -- FK to Driver
    CONSTRAINT OFFENSE_MOTOR_VEHICLE_ID_FK FOREIGN KEY (OFFENSE_MOTOR_VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID) -- FK to Motor vehicle
);

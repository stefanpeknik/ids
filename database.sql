-- Drop a table

-- must be dropped before DRIVER and MOTOR_VEHICLE
DROP TABLE OFFENSE;

-- must be dropped before DRIVER and MOTOR_VEHICLE
DROP TABLE DRIVER_VEHICLE;

-- must be dropped before PERSON
DROP TABLE DRIVER;

-- must be dropped before MOTOR_VEHICLE
DROP TABLE STOLEN_VEHICLE;

-- must be dropped before MOTOR_VEHICLE
DROP TABLE PERSONAL_VEHICLE;

-- must be dropped before MOTOR_VEHICLE
DROP TABLE CARGO_VEHICLE;

-- must be dropped before MOTOR_VEHICLE
DROP TABLE MOTORCYCLE;

-- must be dropped before MOTOR_VEHICLE
DROP TABLE BUS;

-- must be dropped before MOTOR_VEHICLE
DROP TABLE CARAVAN;

-- must be dropped before MOTOR_VEHICLE
DROP TABLE OTHER;

-- must be dropped before VEHICLE_OWNER and INSURANCE
-- cascade constraints to drop all foreign keys
DROP TABLE MOTOR_VEHICLE CASCADE CONSTRAINTS;

-- must be dropped before PERSON
DROP TABLE VEHICLE_OWNER;

-- must be dropped before INSURANCE
DROP TABLE PERSON;

DROP TABLE INSURANCE;

-- create table for Insurance that Person is under
CREATE TABLE INSURANCE (
    INSURANCE_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    INSURANCE_NAME VARCHAR2(50) NOT NULL,
    INSURANCE_POLICY_NUMBER VARCHAR2(50) NOT NULL, -- policy number is not always a number, so it is not constrained
    INSURANCE_STREET VARCHAR2(100) NOT NULL,
    INSURANCE_HOUSE_NUMBER INT NOT NULL,
    INSURANCE_CITY VARCHAR2(50) NOT NULL,
    INSURANCE_STATE VARCHAR2(2) DEFAULT 'CZ' NOT NULL, -- should always be CZ
    INSURANCE_ZIP VARCHAR2(5) CONSTRAINT INSURANCE_ZIP_CHECK CHECK (REGEXP_LIKE(INSURANCE_ZIP, '^\d{3}\s?\d{2}$'))
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
    PERSON_PERSONAL_ID VARCHAR2(10) NOT NULL CHECK(REGEXP_LIKE(PERSON_PERSONAL_ID, '^\d{2}(0[1-9]|1[0-2]|5[1-9]|6[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])\/\d{3,4}$')), -- must contain /
    PERSON_BIRTH_DATE DATE NOT NULL,
    PERSON_STREET VARCHAR2(100) NOT NULL,
    PERSON_HOUSE_NUMBER INT NOT NULL,
    PERSON_CITY VARCHAR2(50) NOT NULL,
    PERSON_STATE VARCHAR2(2) DEFAULT 'CZ' NOT NULL, -- should always be CZ
    PERSON_ZIP VARCHAR2(5) CONSTRAINT PERSON_ZIP_CHECK CHECK (REGEXP_LIKE(PERSON_ZIP, '^\d{3}\s?\d{2}$')),
    CONSTRAINT PERSON_INSURANCE_ID_FK FOREIGN KEY (PERSON_INSURANCE_ID) REFERENCES INSURANCE (INSURANCE_ID) -- FK to Insurance
);

-- create table for Vehicle owner that owns a Motor vehicle
CREATE TABLE VEHICLE_OWNER (
    VEHICLE_OWNER_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    VEHICLE_OWNER_PERSON_ID INT NOT NULL, -- Person that is a Vehicle owner
    CONSTRAINT VEHICLE_OWNER_PERSON_ID_FK FOREIGN KEY (VEHICLE_OWNER_PERSON_ID) REFERENCES PERSON (PERSON_ID) -- FK to Person
);

-- create table for Driver that commits an offense and is licensed to drive a Motor vehicle
CREATE TABLE DRIVER (
    DRIVER_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    DRIVER_LICENSE_NUMBER VARCHAR2(50) NOT NULL, -- license number is not always a number, so it is not constrained
    DRIVER_CAN_DRIVE CHAR(1) NOT NULL CONSTRAINT DRIVER_CAN_DRIVE_CHECK CHECK (DRIVER_CAN_DRIVE = 'Y' OR DRIVER_CAN_DRIVE = 'N'), -- should always be Y or N
    DRIVER_PERSON_ID INT NOT NULL, -- Person that is a Driver
    CONSTRAINT DRIVER_PERSON_ID_FK FOREIGN KEY (DRIVER_PERSON_ID) REFERENCES PERSON (PERSON_ID) -- FK to Person
);

-- gen/spec
-- create table for Motor vehicle that is owned by Vehicle owner
CREATE TABLE MOTOR_VEHICLE(
    MOTOR_VEHICLE_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    MOTOR_VEHICLE_VIN VARCHAR2(17),
    MOTOR_VEHICLE_MAKE VARCHAR2(50),
    MOTOR_VEHICLE_MODEL VARCHAR2(50),
    MOTOR_VEHICLE_YEAR INT CONSTRAINT MOTOR_VEHICLE_YEAR_CHECK CHECK (MOTOR_VEHICLE_YEAR >= 1900),
    MOTOR_VEHICLE_LICENSE_PLATE VARCHAR2(50) NOT NULL, -- license plate is not always a number, so it is not constrained
    MOTOR_VEHICLE_COLOR VARCHAR2(50),
    MOTOR_VEHICLE_INSURANCE_ID INT NOT NULL, -- insurance that Motor vehicle is under
    MOTOR_VEHICLE_VEHICLE_OWNER_ID INT NOT NULL, -- Vehicle owner that owns the Motor vehicle
    MOTOR_VEHICLE_WEIGHT INT CONSTRAINT MOTOR_VEHICLE_WEIGHT_CHECK CHECK (MOTOR_VEHICLE_WEIGHT >= 0),
    MOTOR_VEHICLE_HEIGHT INT CONSTRAINT MOTOR_VEHICLE_HEIGHT_CHECK CHECK (MOTOR_VEHICLE_HEIGHT >= 0),
    MOTOR_VEHICLE_WIDTH INT CONSTRAINT MOTOR_VEHICLE_WIDTH_CHECK CHECK (MOTOR_VEHICLE_WIDTH >= 0),
    MOTOR_VEHICLE_LENGTH INT CONSTRAINT MOTOR_VEHICLE_LENGTH_CHECK CHECK (MOTOR_VEHICLE_LENGTH >= 0),
    MOTOR_VEHICLE_TRANSMISSION VARCHAR2(50),
    MOTOR_VEHICLE_FUEL_TYPE VARCHAR2(50),
    MOTOR_VEHICLE_EMISION_CLASS VARCHAR2(50),
    MOTOR_VEHICLE_TIRE_BRAND VARCHAR2(50),
    MOTOR_VEHICLE_BODY_TYPE VARCHAR2(50),
    CONSTRAINT MOTOR_VEHICLE_INSURANCE_ID_FK FOREIGN KEY (MOTOR_VEHICLE_INSURANCE_ID) REFERENCES INSURANCE (INSURANCE_ID), -- FK to Insurance
    CONSTRAINT MOTOR_VEHICLE_VEHICLE_OWNER_ID_FK FOREIGN KEY (MOTOR_VEHICLE_VEHICLE_OWNER_ID) REFERENCES VEHICLE_OWNER (VEHICLE_OWNER_ID) -- FK to Vehicle owner
);

-- create joint table for Driver and Motor vehicle
CREATE TABLE DRIVER_VEHICLE (
    DRIVER_ID INT NOT NULL,
    VEHICLE_ID INT NOT NULL,
    PRIMARY KEY (DRIVER_ID, VEHICLE_ID),
    FOREIGN KEY (DRIVER_ID) REFERENCES DRIVER (DRIVER_ID),
    FOREIGN KEY (VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID)
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
    OFFENSE_LOCATION_ZIP VARCHAR2(5) CONSTRAINT OFFENSE_LOCATION_ZIP_CHECK CHECK (REGEXP_LIKE(OFFENSE_LOCATION_ZIP, '^\d{3}\s?\d{2}$')),
    OFFENSE_TYPE VARCHAR2(50),
    OFFENSE_DESCRIPTION VARCHAR2(500), -- description of the offense
    OFFENSE_POINTS INT NOT NULL CONSTRAINT OFFENSE_POINTS_CHECK CHECK (OFFENSE_POINTS >= 0 AND OFFENSE_POINTS <= 12),
    OFFENSE_FINE INT DEFAULT 0 NOT NULL, -- always in czech crowns
    OFFENSE_LABEL VARCHAR2(50) DEFAULT NULL,
    CONSTRAINT OFFENSE_DRIVER_ID_FK FOREIGN KEY (OFFENSE_DRIVER_ID) REFERENCES DRIVER (DRIVER_ID), -- FK to Driver
    CONSTRAINT OFFENSE_MOTOR_VEHICLE_ID_FK FOREIGN KEY (OFFENSE_MOTOR_VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID) -- FK to Motor vehicle
);

-- create table for Stolen vehicle that is stolen
CREATE TABLE STOLEN_VEHICLE (
    STOLEN_VEHICLE_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    STOLEN_VEHICLE_DATE DATE NOT NULL,
    STOLEN_VEHICLE_STREET VARCHAR2(100) NOT NULL,
    STOLEN_VEHICLE_HOUSE_NUMBER INT,
    STOLEN_VEHICLE_CITY VARCHAR2(50) NOT NULL,
    STOLEN_VEHICLE_STATE VARCHAR2(2) DEFAULT 'CZ' NOT NULL, -- should always be CZ
    STOLEN_VEHICLE_ZIP VARCHAR2(5) CONSTRAINT STOLEN_VEHICLE_ZIP_CHECK CHECK (REGEXP_LIKE(STOLEN_VEHICLE_ZIP, '^\d{3}\s?\d{2}$')),
    STOLEN_VEHICLE_FOUND CHAR(1) NOT NULL CONSTRAINT STOLEN_VEHICLE_FOUND_CHECK CHECK (STOLEN_VEHICLE_FOUND IN ('Y', 'N')), -- Y if vehicle is found, N if not
    STOLEN_VEHICLE_MOTOR_VEHICLE_ID INT NOT NULL, -- Motor vehicle that is stolen
    CONSTRAINT STOLEN_VEHICLE_MOTOR_VEHICLE_ID_FK FOREIGN KEY (STOLEN_VEHICLE_MOTOR_VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID) -- FK to Motor vehicle
);

CREATE TABLE PERSONAL_VEHICLE(
    PERSONAL_VEHICLE_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    PERSONAL_VEHICLE_MOTOR_VEHICLE_ID INT NOT NULL,
    PERSONAL_VEHICLE_DOOR_COUNT INT CONSTRAINT PERSONAL_VEHICLE_DOOR_COUNT_CHECK CHECK (PERSONAL_VEHICLE_DOOR_COUNT >= 0),
    PERSONAL_VEHICLE_SEAT_COUNT INT CONSTRAINT PERSONAL_VEHICLE_SEAT_COUNT_CHECK CHECK (PERSONAL_VEHICLE_SEAT_COUNT >= 0),
    CONSTRAINT PERSONAL_VEHICLE_MOTOR_VEHICLE_ID_FK FOREIGN KEY (PERSONAL_VEHICLE_MOTOR_VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID)
);

CREATE TABLE CARGO_VEHICLE(
    CARGO_VEHICLE_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    CARGO_VEHICLE_MOTOR_VEHICLE_ID INT NOT NULL,
    CARGO_VEHICLE_MAX_LOAD INT CONSTRAINT CARGO_VEHICLE_MAX_LOAD_CHECK CHECK (CARGO_VEHICLE_MAX_LOAD >= 0),
    CARGO_VEHICLE_TRAILER_LENGTH INT CONSTRAINT CARGO_VEHICLE_TRAILER_LENGTH_CHECK CHECK (CARGO_VEHICLE_TRAILER_LENGTH >= 0),
    CARGO_VEHICLE_TRAILER_TYPE VARCHAR2(50),
    CARGO_VEHICLE_CABIN_TYPE VARCHAR2(50),
    CARGO_VEHICLE_DEVICE_TYPE VARCHAR2(50),
    CONSTRAINT CARGO_VEHICLE_MOTOR_VEHICLE_ID_FK FOREIGN KEY (CARGO_VEHICLE_MOTOR_VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID)
);

CREATE TABLE MOTORCYCLE(
    MOTORCYCLE_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    MOTORCYCLE_MOTOR_VEHICLE_ID INT NOT NULL,
    MOTORCYCLE_TYPE VARCHAR2(50),
    CONSTRAINT MOTORCYCLE_MOTOR_VEHICLE_ID_FK FOREIGN KEY (MOTORCYCLE_MOTOR_VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID)
);

CREATE TABLE BUS(
    BUS_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    BUS_MOTOR_VEHICLE_ID INT NOT NULL,
    BUS_SEAT_COUNT INT CONSTRAINT BUS_SEAT_COUNT_CHECK CHECK (BUS_SEAT_COUNT >= 0),
    BUS_MAX_NUMBER_OF_PASSENGERS INT CONSTRAINT BUS_MAX_NUMBER_OF_PASSENGERS_CHECK CHECK (BUS_MAX_NUMBER_OF_PASSENGERS >= 0),
    CONSTRAINT BUS_MOTOR_VEHICLE_ID_FK FOREIGN KEY (BUS_MOTOR_VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID)
);

CREATE TABLE CARAVAN(
    CARAVAN_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    CARAVAN_MOTOR_VEHICLE_ID INT NOT NULL,
    CARAVAN_TYPE VARCHAR2(50),
    CARAVAN_NUMBER_OF_BEDS INT CONSTRAINT CARAVAN_NUMBER_OF_BEDS_CHECK CHECK (CARAVAN_NUMBER_OF_BEDS >= 0),
    CONSTRAINT CARAVAN_MOTOR_VEHICLE_ID_FK FOREIGN KEY (CARAVAN_MOTOR_VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID)
);

CREATE TABLE OTHER(
    OTHER_ID INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    OTHER_MOTOR_VEHICLE_ID INT NOT NULL,
    OTHER_DESCRIPTION VARCHAR2(50),
    CONSTRAINT OTHER_MOTOR_VEHICLE_ID_FK FOREIGN KEY (OTHER_MOTOR_VEHICLE_ID) REFERENCES MOTOR_VEHICLE (MOTOR_VEHICLE_ID)
);
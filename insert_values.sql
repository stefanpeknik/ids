INSERT INTO INSURANCE (
    INSURANCE_NAME,
    INSURANCE_POLICY_NUMBER,
    INSURANCE_STREET,
    INSURANCE_HOUSE_NUMBER,
    INSURANCE_CITY,
    INSURANCE_STATE,
    INSURANCE_ZIP
) VALUES (
    'ABC Insurance',
    '12345',
    'Main Street',
    10,
    'Prague',
    'CZ',
    '12345'
);

INSERT INTO INSURANCE (
    INSURANCE_NAME,
    INSURANCE_POLICY_NUMBER,
    INSURANCE_STREET,
    INSURANCE_HOUSE_NUMBER,
    INSURANCE_CITY,
    INSURANCE_ZIP
) VALUES (
    'kocotom',
    'A123C456',
    'Main Rtreet',
    133,
    'Brno',
    '12245'
);

INSERT INTO PERSON (
    PERSON_NAME,
    PERSON_SURNAME,
    PERSON_AGE,
    PERSON_SEX,
    PERSON_GENDER,
    PERSON_INSURANCE_ID,
    PERSON_PERSONAL_ID,
    PERSON_BIRTH_DATE,
    PERSON_STREET,
    PERSON_HOUSE_NUMBER,
    PERSON_CITY,
    PERSON_ZIP
) VALUES (
    'Alice',
    'Smith',
    30,
    'F',
    'Female',
    1,
    '921231/5678',
    TO_DATE('1992-12-31', 'YYYY-MM-DD'),
    'Main Street',
    456,
    'Prague',
    '12345'
);

INSERT INTO PERSON (
    PERSON_NAME,
    PERSON_SURNAME,
    PERSON_AGE,
    PERSON_SEX,
    PERSON_GENDER,
    PERSON_INSURANCE_ID,
    PERSON_PERSONAL_ID,
    PERSON_BIRTH_DATE,
    PERSON_STREET,
    PERSON_HOUSE_NUMBER,
    PERSON_CITY,
    PERSON_ZIP
) VALUES (
    'Bob',
    'Johnson',
    40,
    'M',
    NULL,
    NULL,
    '830630/1234',
    TO_DATE('1983-06-30', 'YYYY-MM-DD'),
    'High Street',
    789,
    'Brno',
    '67890'
);

INSERT INTO PERSON (
    PERSON_NAME,
    PERSON_SURNAME,
    PERSON_AGE,
    PERSON_SEX,
    PERSON_GENDER,
    PERSON_INSURANCE_ID,
    PERSON_PERSONAL_ID,
    PERSON_BIRTH_DATE,
    PERSON_STREET,
    PERSON_HOUSE_NUMBER,
    PERSON_CITY,
    PERSON_ZIP
) VALUES (
    'Sam',
    'Taylor',
    25,
    'F',
    'Non-binary',
    NULL,
    '950630/5678',
    TO_DATE('1995-06-30', 'YYYY-MM-DD'),
    'Low Street',
    111,
    'Ostrava',
    '54321'
);

INSERT INTO VEHICLE_OWNER (
    VEHICLE_OWNER_PERSON_ID
) VALUES (
    1
);

INSERT INTO VEHICLE_OWNER (
    VEHICLE_OWNER_PERSON_ID
) VALUES (
    2
);

INSERT INTO VEHICLE_OWNER (
    VEHICLE_OWNER_PERSON_ID
) VALUES (
    3
);

INSERT INTO DRIVER (
    DRIVER_LICENSE_NUMBER,
    DRIVER_CAN_DRIVE,
    DRIVER_PERSON_ID
) VALUES (
    'ABC123',
    'Y',
    1
);

INSERT INTO DRIVER (
    DRIVER_LICENSE_NUMBER,
    DRIVER_CAN_DRIVE,
    DRIVER_PERSON_ID
) VALUES (
    'XYZ789',
    'N',
    2
);

INSERT INTO DRIVER (
    DRIVER_LICENSE_NUMBER,
    DRIVER_CAN_DRIVE,
    DRIVER_PERSON_ID
) VALUES (
    'ABCD-1234-EFGH-5678',
    'Y',
    3
);

INSERT INTO MOTOR_VEHICLE (
    MOTOR_VEHICLE_ID,
    MOTOR_VEHICLE_VIN,
    MOTOR_VEHICLE_MAKE,
    MOTOR_VEHICLE_MODEL,
    MOTOR_VEHICLE_YEAR,
    MOTOR_VEHICLE_LICENSE_PLATE,
    MOTOR_VEHICLE_COLOR,
    MOTOR_VEHICLE_INSURANCE_ID,
    MOTOR_VEHICLE_VEHICLE_OWNER_ID,
    MOTOR_VEHICLE_WEIGHT,
    MOTOR_VEHICLE_HEIGHT,
    MOTOR_VEHICLE_WIDTH,
    MOTOR_VEHICLE_LENGTH,
    MOTOR_VEHICLE_TRANSMISSION,
    MOTOR_VEHICLE_FUEL_TYPE,
    MOTOR_VEHICLE_EMISION_CLASS,
    MOTOR_VEHICLE_TIRE_BRAND,
    MOTOR_VEHICLE_BODY_TYPE
) VALUES (
    1,
    '1G1JC124717202000',
    'Chevrolet',
    'Cavalier',
    2001,
    'ABC123',
    'Silver',
    1,
    1,
    2500,
    150,
    70,
    180,
    'Automatic',
    'Gasoline',
    'Euro 4',
    'Michelin',
    'Sedan'
);

INSERT INTO MOTOR_VEHICLE (
    MOTOR_VEHICLE_ID,
    MOTOR_VEHICLE_VIN,
    MOTOR_VEHICLE_MAKE,
    MOTOR_VEHICLE_MODEL,
    MOTOR_VEHICLE_YEAR,
    MOTOR_VEHICLE_LICENSE_PLATE,
    MOTOR_VEHICLE_COLOR,
    MOTOR_VEHICLE_INSURANCE_ID,
    MOTOR_VEHICLE_VEHICLE_OWNER_ID,
    MOTOR_VEHICLE_WEIGHT,
    MOTOR_VEHICLE_HEIGHT,
    MOTOR_VEHICLE_WIDTH,
    MOTOR_VEHICLE_LENGTH,
    MOTOR_VEHICLE_TRANSMISSION,
    MOTOR_VEHICLE_FUEL_TYPE,
    MOTOR_VEHICLE_EMISION_CLASS,
    MOTOR_VEHICLE_TIRE_BRAND,
    MOTOR_VEHICLE_BODY_TYPE
) VALUES (
    2,
    '5UXFA13595LY08295',
    'BMW',
    'X5',
    2005,
    'DEF456',
    'Black',
    2,
    3,
    3000,
    170,
    80,
    200,
    'Manual',
    'Diesel',
    'Euro 6',
    'Bridgestone',
    'SUV'
);

INSERT INTO MOTOR_VEHICLE (
    MOTOR_VEHICLE_ID,
    MOTOR_VEHICLE_VIN,
    MOTOR_VEHICLE_MAKE,
    MOTOR_VEHICLE_MODEL,
    MOTOR_VEHICLE_YEAR,
    MOTOR_VEHICLE_LICENSE_PLATE,
    MOTOR_VEHICLE_COLOR,
    MOTOR_VEHICLE_INSURANCE_ID,
    MOTOR_VEHICLE_VEHICLE_OWNER_ID,
    MOTOR_VEHICLE_WEIGHT,
    MOTOR_VEHICLE_HEIGHT,
    MOTOR_VEHICLE_WIDTH,
    MOTOR_VEHICLE_LENGTH,
    MOTOR_VEHICLE_TRANSMISSION,
    MOTOR_VEHICLE_FUEL_TYPE,
    MOTOR_VEHICLE_EMISION_CLASS,
    MOTOR_VEHICLE_TIRE_BRAND,
    MOTOR_VEHICLE_BODY_TYPE
) VALUES (
    3,
    '3FA6P0HD6HR238013',
    'Ford',
    'Fusion',
    2017,
    'GHI789',
    'Red',
    2,
    2,
    2700,
    160,
    75,
    190,
    'Automatic',
    'Hybrid',
    'Euro 5',
    'Goodyear',
    'Sedan'
);

INSERT INTO DRIVER_VEHICLE (
    DRIVER_ID,
    VEHICLE_ID
) VALUES (
    1,
    3
);

INSERT INTO DRIVER_VEHICLE (
    DRIVER_ID,
    VEHICLE_ID
) VALUES (
    2,
    2
);

INSERT INTO DRIVER_VEHICLE (
    DRIVER_ID,
    VEHICLE_ID
) VALUES (
    3,
    1
);

INSERT INTO OFFENSE (
    OFFENSE_DRIVER_ID,
    OFFENSE_MOTOR_VEHICLE_ID,
    OFFENSE_DATE_TIME,
    OFFENSE_LOCATION_STREET,
    OFFENSE_LOCATION_CITY,
    OFFENSE_LOCATION_STATE,
    OFFENSE_LOCATION_ZIP,
    OFFENSE_TYPE,
    OFFENSE_DESCRIPTION,
    OFFENSE_POINTS,
    OFFENSE_FINE,
    OFFENSE_LABEL
) VALUES (
    1,
    3,
    TO_DATE('2023-03-25 14:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    'Main St',
    'Prague',
    'CZ',
    '11000',
    'Speeding',
    'Exceeded the speed limit by 20 km/h',
    2,
    2000,
    'Excessive Speed'
);

INSERT INTO OFFENSE (
    OFFENSE_DRIVER_ID,
    OFFENSE_MOTOR_VEHICLE_ID,
    OFFENSE_DATE_TIME,
    OFFENSE_LOCATION_STREET,
    OFFENSE_LOCATION_CITY,
    OFFENSE_LOCATION_STATE,
    OFFENSE_LOCATION_ZIP,
    OFFENSE_TYPE,
    OFFENSE_DESCRIPTION,
    OFFENSE_POINTS,
    OFFENSE_FINE,
    OFFENSE_LABEL
) VALUES (
    2,
    1,
    TO_DATE('2023-03-24 10:15:00', 'YYYY-MM-DD HH24:MI:SS'),
    'Oak St',
    'Brno',
    'CZ',
    '60200',
    'Running a red light',
    'Failed to stop at a red light',
    4,
    4000,
    'Red Light Violation'
);

INSERT INTO OFFENSE (
    OFFENSE_DRIVER_ID,
    OFFENSE_MOTOR_VEHICLE_ID,
    OFFENSE_DATE_TIME,
    OFFENSE_LOCATION_STREET,
    OFFENSE_LOCATION_CITY,
    OFFENSE_LOCATION_STATE,
    OFFENSE_LOCATION_ZIP,
    OFFENSE_TYPE,
    OFFENSE_DESCRIPTION,
    OFFENSE_POINTS,
    OFFENSE_FINE,
    OFFENSE_LABEL
) VALUES (
    3,
    2,
    TO_DATE('2023-03-23 16:45:00', 'YYYY-MM-DD HH24:MI:SS'),
    'Market St',
    'Ostrava',
    'CZ',
    '70030',
    'Seat Belt Violation',
    'Driver was not wearing a seat belt',
    1,
    1000,
    NULL
);

INSERT INTO STOLEN_VEHICLE (
    STOLEN_VEHICLE_DATE,
    STOLEN_VEHICLE_STREET,
    STOLEN_VEHICLE_CITY,
    STOLEN_VEHICLE_MOTOR_VEHICLE_ID,
    STOLEN_VEHICLE_FOUND
) VALUES (
    TO_DATE('2022-05-10', 'YYYY-MM-DD'),
    'Main Street',
    'Prague',
    1,
    'N'
);

INSERT INTO STOLEN_VEHICLE (
    STOLEN_VEHICLE_DATE,
    STOLEN_VEHICLE_STREET,
    STOLEN_VEHICLE_HOUSE_NUMBER,
    STOLEN_VEHICLE_CITY,
    STOLEN_VEHICLE_STATE,
    STOLEN_VEHICLE_ZIP,
    STOLEN_VEHICLE_MOTOR_VEHICLE_ID,
    STOLEN_VEHICLE_FOUND
) VALUES (
    TO_DATE('2022-05-10', 'YYYY-MM-DD'),
    'Oak Street',
    123,
    'Brno',
    'CZ',
    '12345',
    1,
    'Y'
);

INSERT INTO STOLEN_VEHICLE (
    STOLEN_VEHICLE_DATE,
    STOLEN_VEHICLE_STREET,
    STOLEN_VEHICLE_CITY,
    STOLEN_VEHICLE_STATE,
    STOLEN_VEHICLE_ZIP,
    STOLEN_VEHICLE_MOTOR_VEHICLE_ID,
    STOLEN_VEHICLE_FOUND
) VALUES (
    TO_DATE('2022-05-10', 'YYYY-MM-DD'),
    'Broadway',
    'Ostrava',
    'CZ',
    '67890',
    2,
    'N'
);

INSERT INTO PERSONAL_VEHICLE (
    PERSONAL_VEHICLE_ID,
    PERSONAL_VEHICLE_DOOR_COUNT,
    PERSONAL_VEHICLE_SEAT_COUNT
) VALUES (
    1,
    4,
    5
);

INSERT INTO PERSONAL_VEHICLE (
    PERSONAL_VEHICLE_ID,
    PERSONAL_VEHICLE_DOOR_COUNT,
    PERSONAL_VEHICLE_SEAT_COUNT
) VALUES (
    2,
    2,
    2
);

INSERT INTO PERSONAL_VEHICLE (
    PERSONAL_VEHICLE_ID,
    PERSONAL_VEHICLE_DOOR_COUNT,
    PERSONAL_VEHICLE_SEAT_COUNT
) VALUES (
    3,
    4,
    7
);

INSERT INTO CARGO_VEHICLE (
    CARGO_VEHICLE_ID,
    CARGO_VEHICLE_MAX_LOAD,
    CARGO_VEHICLE_TRAILER_LENGTH,
    CARGO_VEHICLE_TRAILER_TYPE,
    CARGO_VEHICLE_CABIN_TYPE,
    CARGO_VEHICLE_DEVICE_TYPE
) VALUES (
    1,
    5000,
    30,
    'Flatbed',
    'Standard',
    'GPS Tracking'
);

INSERT INTO CARGO_VEHICLE (
    CARGO_VEHICLE_ID,
    CARGO_VEHICLE_MAX_LOAD,
    CARGO_VEHICLE_TRAILER_LENGTH,
    CARGO_VEHICLE_TRAILER_TYPE,
    CARGO_VEHICLE_CABIN_TYPE,
    CARGO_VEHICLE_DEVICE_TYPE
) VALUES (
    2,
    10000,
    40,
    'Refrigerated',
    'Sleeper',
    'Bluetooth Radio'
);

INSERT INTO CARGO_VEHICLE (
    CARGO_VEHICLE_ID,
    CARGO_VEHICLE_MAX_LOAD,
    CARGO_VEHICLE_TRAILER_LENGTH,
    CARGO_VEHICLE_TRAILER_TYPE,
    CARGO_VEHICLE_CABIN_TYPE,
    CARGO_VEHICLE_DEVICE_TYPE
) VALUES (
    3,
    8000,
    35,
    'Flatbed',
    'Standard',
    'Climate Control'
);

INSERT INTO MOTORCYCLE (
    MOTORCYCLE_ID,
    MOTORCYCLE_TYPE
) VALUES (
    1,
    'Sport'
);

INSERT INTO MOTORCYCLE (
    MOTORCYCLE_ID,
    MOTORCYCLE_TYPE
) VALUES (
    2,
    'Touring'
);

INSERT INTO MOTORCYCLE (
    MOTORCYCLE_ID,
    MOTORCYCLE_TYPE
) VALUES (
    3,
    'Cruiser'
);

INSERT INTO BUS (
    BUS_ID,
    BUS_SEAT_COUNT,
    BUS_MAX_NUMBER_OF_PASSENGERS
) VALUES (
    1,
    50,
    100
);

INSERT INTO BUS (
    BUS_ID,
    BUS_SEAT_COUNT,
    BUS_MAX_NUMBER_OF_PASSENGERS
) VALUES (
    2,
    30,
    80
);

INSERT INTO BUS (
    BUS_ID,
    BUS_SEAT_COUNT,
    BUS_MAX_NUMBER_OF_PASSENGERS
) VALUES (
    3,
    40,
    90
);

INSERT INTO CARAVAN (
    CARAVAN_ID,
    CARAVAN_TYPE,
    CARAVAN_NUMBER_OF_BEDS
) VALUES (
    1,
    'Travel Trailer',
    4
);

INSERT INTO CARAVAN (
    CARAVAN_ID,
    CARAVAN_TYPE,
    CARAVAN_NUMBER_OF_BEDS
) VALUES (
    2,
    'Fifth Wheel',
    6
);

INSERT INTO CARAVAN (
    CARAVAN_ID,
    CARAVAN_TYPE,
    CARAVAN_NUMBER_OF_BEDS
) VALUES (
    3,
    'Pop-up Camper',
    2
);

INSERT INTO OTHER (
    OTHER_ID,
    OTHER_DESCRIPTION
) VALUES (
    1,
    'Customized pick-up truck'
);

INSERT INTO OTHER (
    OTHER_ID,
    OTHER_DESCRIPTION
) VALUES (
    2,
    'Experimental electric car'
);

INSERT INTO OTHER (
    OTHER_ID,
    OTHER_DESCRIPTION
) VALUES (
    3,
    'Special purpose vehicle for film production'
);
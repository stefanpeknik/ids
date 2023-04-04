-- list every person's insurance (person_name, person_surname, person_personal_id, insurance_name, insurance_policy_number)
SELECT
    P.PERSON_NAME,
    P.PERSON_SURNAME,
    P.PERSON_PERSONAL_ID,
    I.INSURANCE_NAME,
    I.INSURANCE_POLICY_NUMBER
FROM
    PERSON    P
    INNER JOIN INSURANCE I
    ON P.PERSON_INSURANCE_ID = I.INSURANCE_ID;

-- list every vehicles' insurance (motor_vehicle_license_plate, motor_vehicle_make, motor_vehicle_model, motor_vehicle_year, insurance_name, insurance_policy_number)
SELECT
    V.MOTOR_VEHICLE_LICENSE_PLATE,
    V.MOTOR_VEHICLE_MAKE,
    V.MOTOR_VEHICLE_MODEL,
    V.MOTOR_VEHICLE_YEAR,
    I.INSURANCE_NAME,
    I.INSURANCE_POLICY_NUMBER
FROM
    MOTOR_VEHICLE V
    INNER JOIN INSURANCE I
    ON V.MOTOR_VEHICLE_INSURANCE_ID = I.INSURANCE_ID;

-- list every vehicle's owner and their motor vehicle (person_name, person_surname, person_personal_id, motor_vehicle_license_plate, motor_vehicle_make, motor_vehicle_model, motor_vehicle_year)
SELECT
    P.PERSON_NAME,
    P.PERSON_SURNAME,
    P.PERSON_PERSONAL_ID,
    V.MOTOR_VEHICLE_LICENSE_PLATE,
    V.MOTOR_VEHICLE_MAKE,
    V.MOTOR_VEHICLE_MODEL,
    V.MOTOR_VEHICLE_YEAR
FROM
    PERSON        P
    INNER JOIN VEHICLE_OWNER V_O
    ON P.PERSON_ID = V_O.VEHICLE_OWNER_PERSON_ID
    INNER JOIN MOTOR_VEHICLE V
    ON V_O.VEHICLE_OWNER_ID = V.MOTOR_VEHICLE_VEHICLE_OWNER_ID;
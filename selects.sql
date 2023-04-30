-- Tento skript vytvoří základní objekty schéma databáze
-- a naplní tabulky ukázkovými daty, a poté provede několik dotazů SELECT
-- s následujícími podmínkami:
--   - Alespoň dva dotazy využívající spojení dvou tabulek.
--   - Jeden dotaz využívající spojení tří tabulek.
--   - Dva dotazy s klauzulí GROUP BY a agregační funkcí.
--   - Jeden dotaz obsahující predikát EXISTS.
--   - Jeden dotaz s predikátem IN s vnořeným selectem (nikoliv IN s množinou konstantních dat).
--
-- Každý dotaz bude mít v komentáři SQL kódu popsáno, jaká data hledá daný dotaz a jaká je jeho funkce v aplikaci.


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

-- list every vehicle owner and number of vehicles they own (person_name, person_surname, num_vehicles_owned)
SELECT
    P.PERSON_NAME,
    P.PERSON_SURNAME,
    COUNT(MV.MOTOR_VEHICLE_ID) AS NUM_VEHICLES_OWNED
FROM
    PERSON        P
    JOIN VEHICLE_OWNER VO
    ON VO.VEHICLE_OWNER_PERSON_ID = P.PERSON_ID JOIN MOTOR_VEHICLE MV
    ON MV.MOTOR_VEHICLE_ID = VO.VEHICLE_OWNER_ID
GROUP BY
    P.PERSON_NAME,
    P.PERSON_SURNAME;

-- list all insurances and number of people under each
SELECT
    INSURANCE.INSURANCE_NAME,
    COUNT(PERSON.PERSON_ID) AS NUMBER_OF_PEOPLE
FROM
    INSURANCE
    LEFT JOIN PERSON
    ON INSURANCE.INSURANCE_ID = PERSON.PERSON_INSURANCE_ID
GROUP BY
    INSURANCE.INSURANCE_ID,
    INSURANCE.INSURANCE_NAME;

-- list every vehicle owner whose car was stolen (person_name, person_surname)
SELECT
    DISTINCT P.PERSON_NAME,
    P.PERSON_SURNAME
FROM
    PERSON         P
WHERE
    EXISTS (
        SELECT
            1
        FROM
            VEHICLE_OWNER  VO
            JOIN MOTOR_VEHICLE MV
            ON VO.VEHICLE_OWNER_ID = MV.MOTOR_VEHICLE_ID JOIN STOLEN_VEHICLE SV
            ON MV.MOTOR_VEHICLE_ID = SV.STOLEN_VEHICLE_ID
        WHERE
            VO.VEHICLE_OWNER_PERSON_ID = P.PERSON_ID
    );

-- list every motor_vehicle that was used in an offense on date from 23.3.2023 to 24.5.2023 (motor_vehicle_*)
SELECT
    DISTINCT MV.*
FROM
    MOTOR_VEHICLE MV
    INNER JOIN OFFENSE OFF
    ON MV.MOTOR_VEHICLE_ID = OFF.OFFENSE_MOTOR_VEHICLE_ID
WHERE
    MV.MOTOR_VEHICLE_ID IN (
        SELECT
            OFFENSE_MOTOR_VEHICLE_ID
        FROM
            OFFENSE
        WHERE
            OFFENSE_DATE_TIME BETWEEN TO_DATE('2023-03-23',
            'YYYY-MM-DD')
            AND TO_DATE('2023-05-24',
            'YYYY-MM-DD')
    );

WITH CITY_SUMMARY AS (
    SELECT
        OFFENSE_LOCATION_CITY,
        SUM(OFFENSE_FINE)  AS TOTAL_FINE,
        COUNT(*)           AS OFFENSE_COUNT
    FROM
        OFFENSE
    GROUP BY
        OFFENSE_LOCATION_CITY
)
SELECT
    OFFENSE_LOCATION_CITY,
    SUM(CASE
        WHEN TOTAL_FINE > 2000 THEN
            1
        ELSE
            0
    END)               AS HIGH_FINE_COUNT,
    SUM(CASE
        WHEN TOTAL_FINE <= 2000 THEN
            1
        ELSE
            0
    END)               AS LOW_FINE_COUNT,
    SUM(OFFENSE_COUNT) AS TOTAL_OFFENSES,
    SUM(TOTAL_FINE)    AS TOTAL_FINE
FROM
    CITY_SUMMARY
GROUP BY
    OFFENSE_LOCATION_CITY;
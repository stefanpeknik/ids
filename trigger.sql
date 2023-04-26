--Tento trigger zkontroluje, zda je věk osoby v tabulce PERSON starší nebo roven 18 let a zda má povinnost mít řidičský průkaz podle zákona.
--Pokud některá z těchto podmínek není splněna, trigger zabrání vložení dalšího záznamu
CREATE OR REPLACE TRIGGER PERSON_AGE_LICENSE_TRIGGER BEFORE
    INSERT ON PERSON FOR EACH ROW
DECLARE
    MIN_DRIVING_AGE CONSTANT INT := 18;
BEGIN
    IF :NEW.PERSON_AGE < MIN_DRIVING_AGE AND :NEW.PERSON_INSURANCE_ID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Person must be at least 18 years old or have a valid driver''s license.');
    END IF;
END;
 --Tento trigger počítá počet vozidel, které jsou pojištěny u každé pojistné smlouvy v tabulce INSURANCE
 --a aktualizuje sloupec INSURANCE_VEHICLE_COUNT v této tabulce
 CREATE OR REPLACE TRIGGER PERSON_INSURANCE_COUNT_TRIGGER AFTER INSERT OR DELETE OR UPDATE OF PERSON_INSURANCE_ID ON PERSON FOR EACH ROW DECLARE P_INSURANCE_ID INT;
P_COUNT INT;
BEGIN
    P_INSURANCE_ID := :NEW.PERSON_INSURANCE_ID;
    SELECT
        COUNT(*) INTO P_COUNT
    FROM
        PERSON
    WHERE
        PERSON_INSURANCE_ID = P_INSURANCE_ID;
    UPDATE INSURANCE
    SET
        INSURANCE_PERSON_COUNT = P_COUNT
    WHERE
        INSURANCE_ID = P_INSURANCE_ID;
END;
 --Tento trigger počítá počet vozidel, které jsou pojištěny u každé pojistné smlouvy v tabulce INSURANCE
 --a aktualizuje sloupec INSURANCE_VEHICLE_COUNT v této tabulce
 CREATE OR REPLACE TRIGGER MOTOR_VEHICLE_INSURANCE_COUNT_TRIGGER AFTER INSERT OR DELETE OR UPDATE OF MOTOR_VEHICLE_INSURANCE_ID ON MOTOR_VEHICLE FOR EACH ROW DECLARE V_INSURANCE_ID INT;
V_COUNT INT;
BEGIN
    V_INSURANCE_ID := :NEW.MOTOR_VEHICLE_INSURANCE_ID;
    SELECT
        COUNT(*) INTO V_COUNT
    FROM
        MOTOR_VEHICLE
    WHERE
        MOTOR_VEHICLE_INSURANCE_ID = V_INSURANCE_ID;
    UPDATE INSURANCE
    SET
        INSURANCE_VEHICLE_COUNT = V_COUNT
    WHERE
        INSURANCE_ID = V_INSURANCE_ID;
END;
SELECT
    *
FROM
    INSURANCE;
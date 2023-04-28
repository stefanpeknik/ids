-- procedure that deletes a driver and all their offenses from the database
CREATE OR REPLACE PROCEDURE DELETE_DRIVER(
    P_DRIVER_ID IN DRIVER.DRIVER_ID%TYPE
) IS
BEGIN
 -- delete driver's offenses
    DELETE FROM OFFENSE
    WHERE
        OFFENSE_DRIVER_ID = P_DRIVER_ID;
 -- delete driver
    DELETE FROM DRIVER
    WHERE
        DRIVER_ID = P_DRIVER_ID;
    DBMS_OUTPUT.PUT_LINE('Driver '
        || P_DRIVER_ID
        || ' and all their offenses have been deleted.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: '
            || SQLERRM);
END;
/
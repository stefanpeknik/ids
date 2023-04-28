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

CREATE OR REPLACE PROCEDURE get_driver_vehicle_info(
    driver_id_in IN INT,
    vehicle_make_out OUT VARCHAR2,
    vehicle_model_out OUT VARCHAR2,
    vehicle_year_out OUT INT,
    vehicle_license_plate_out OUT VARCHAR2
)
IS
    -- Declare the cursor
    CURSOR driver_vehicle_cursor IS
        SELECT MV.MOTOR_VEHICLE_MAKE, MV.MOTOR_VEHICLE_MODEL, MV.MOTOR_VEHICLE_YEAR, MV.MOTOR_VEHICLE_LICENSE_PLATE
        FROM MOTOR_VEHICLE MV
        INNER JOIN DRIVER D ON MV.MOTOR_VEHICLE_ID = D.DRIVER_ID
        WHERE D.DRIVER_ID = driver_id_in;

BEGIN
    -- Open the cursor
    OPEN driver_vehicle_cursor;
    
    -- Fetch the results into the output variables
    FETCH driver_vehicle_cursor INTO vehicle_make_out, vehicle_model_out, vehicle_year_out, vehicle_license_plate_out;

    -- Close the cursor
    CLOSE driver_vehicle_cursor;
END;
/

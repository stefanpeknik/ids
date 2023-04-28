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

-- procedure that will get informations about a driver's vehicle based on the driver's ID
CREATE OR REPLACE PROCEDURE get_driver_vehicle_info(
    driver_person_id_in IN DRIVER.DRIVER_PERSON_ID%TYPE, -- driver's ID

    vehicle_vin_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_VIN%TYPE, -- vehicle's VIN
    vehicle_make_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_MAKE%TYPE, -- vehicle's make
    vehicle_model_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_MODEL%TYPE, -- vehicle's model
    vehicle_year_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_YEAR%TYPE, -- vehicle's year
    vehicle_license_plate_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_LICENSE_PLATE%TYPE -- vehicle's license plate
)
IS
    -- Declare the cursor
    CURSOR driver_vehicle_cursor IS
        SELECT MV.MOTOR_VEHICLE_MAKE, MV.MOTOR_VEHICLE_MODEL, MV.MOTOR_VEHICLE_YEAR, MV.MOTOR_VEHICLE_LICENSE_PLATE, MV.MOTOR_VEHICLE_VIN
        FROM MOTOR_VEHICLE MV
        INNER JOIN DRIVER D ON MV.MOTOR_VEHICLE_ID = D.DRIVER_ID
        WHERE D.DRIVER_ID = driver_person_id_in;

BEGIN
    -- Open the cursor
    OPEN driver_vehicle_cursor;
    
    -- Fetch the results into the output variables
    FETCH driver_vehicle_cursor INTO vehicle_vin_out, vehicle_make_out, vehicle_model_out, vehicle_year_out, vehicle_license_plate_out;

    -- Close the cursor
    CLOSE driver_vehicle_cursor;
END;
/
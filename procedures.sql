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

-- procedure that will get informations about a driver's vehicle based on the vehicle owner's ID
CREATE OR REPLACE PROCEDURE get_vehicle_info(
    vehicle_owner_person_id_in IN VEHICLE_OWNER.VEHICLE_OWNER_PERSON_ID%TYPE, -- vehicle owner's ID

    vehicle_vin_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_VIN%TYPE, -- vehicle's VIN
    vehicle_make_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_MAKE%TYPE, -- vehicle's make
    vehicle_model_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_MODEL%TYPE, -- vehicle's model
    vehicle_year_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_YEAR%TYPE, -- vehicle's year
    vehicle_license_plate_out OUT MOTOR_VEHICLE.MOTOR_VEHICLE_LICENSE_PLATE%TYPE -- vehicle's license plate
)
IS
    -- Declare the cursor
    CURSOR vehicle_owner_cursor IS
        SELECT MV.MOTOR_VEHICLE_VIN, MV.MOTOR_VEHICLE_MAKE, MV.MOTOR_VEHICLE_MODEL, MV.MOTOR_VEHICLE_YEAR, MV.MOTOR_VEHICLE_LICENSE_PLATE
        FROM MOTOR_VEHICLE MV
        INNER JOIN VEHICLE_OWNER VO ON MV.MOTOR_VEHICLE_VEHICLE_OWNER_ID = VO.VEHICLE_OWNER_PERSON_ID
        WHERE VO.VEHICLE_OWNER_PERSON_ID = vehicle_owner_person_id_in;

BEGIN
    -- Open the cursor
    OPEN vehicle_owner_cursor;
    
    -- Fetch the results into the output variables
    FETCH vehicle_owner_cursor INTO vehicle_vin_out, vehicle_make_out, vehicle_model_out, vehicle_year_out, vehicle_license_plate_out;

    -- Close the cursor
    CLOSE vehicle_owner_cursor;
END;
/

DECLARE
    -- Declare variables to store output values
    vehicle_vin MOTOR_VEHICLE.MOTOR_VEHICLE_VIN%TYPE;
    vehicle_make MOTOR_VEHICLE.MOTOR_VEHICLE_MAKE%TYPE;
    vehicle_model MOTOR_VEHICLE.MOTOR_VEHICLE_MODEL%TYPE;
    vehicle_year MOTOR_VEHICLE.MOTOR_VEHICLE_YEAR%TYPE;
    vehicle_license_plate MOTOR_VEHICLE.MOTOR_VEHICLE_LICENSE_PLATE%TYPE;
BEGIN
    -- Call the procedure and pass the input parameter
    get_vehicle_info(2, vehicle_vin, vehicle_make, vehicle_model, vehicle_year, vehicle_license_plate);
    
    -- Display the output values
    DBMS_OUTPUT.PUT_LINE('Vehicle VIN: ' || vehicle_vin);
    DBMS_OUTPUT.PUT_LINE('Vehicle make: ' || vehicle_make);
    DBMS_OUTPUT.PUT_LINE('Vehicle model: ' || vehicle_model);
    DBMS_OUTPUT.PUT_LINE('Vehicle year: ' || vehicle_year);
    DBMS_OUTPUT.PUT_LINE('Vehicle license plate: ' || vehicle_license_plate);
END;

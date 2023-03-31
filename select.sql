-- list every person's insurance (person_name, person_surname, person_personal_id, insurance_name, insurance_policy_number)
SELECT p.person_name, p.person_surname, p.person_personal_id, i.insurance_name, i.insurance_policy_number
FROM person p
INNER JOIN insurance i
    ON p.person_id = i.person_id;

-- list every vehicles' insurance (motor_vehicle_license_plate, motor_vehicle_make, motor_vehicle_model, motor_vehicle_year, insurance_name, insurance_policy_number)
SELECT v.motor_vehicle_license_plate, v.motor_vehicle_make, v.motor_vehicle_model, v.motor_vehicle_year, i.insurance_name, i.insurance_policy_number
FROM motor_vehicle v
INNER JOIN insurance i
    ON v.motor_vehicle_insurance_id = i.insurance_id;

-- list every vehicle's owner and their motor vehicle (person_name, person_surname, person_personal_id, motor_vehicle_license_plate, motor_vehicle_make, motor_vehicle_model, motor_vehicle_year)
SELECT p.person_name, p.person_surname, p.person_personal_id, v.motor_vehicle_license_plate, v.motor_vehicle_make, v.motor_vehicle_model, v.motor_vehicle_year
FROM person p
INNER JOIN vehicle_owner v_o
    ON p.person_id = v_o.person_id
INNER JOIN motor_vehicle v
    ON v_o.motor_vehicle_id = v.motor_vehicle_id;
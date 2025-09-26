CREATE DATABASE PetSpa;
USE PetSpa;

CREATE TABLE Owner (
    owner_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20)
);
INSERT INTO Owner(owner_id, first_name,last_name, phone) 
Values(1,'Bob','Matthew',88),
(2,'Simmy','Samson',4865),
(3,'Emma','Strt',9999);
ALTER TABLE Owner MODIFY phone VARCHAR(20) DEFAULT NULL;
INSERT INTO Owner (owner_id, first_name, last_name)
VALUES (4, 'John', 'Doe');
INSERT INTO Owner(owner_id, first_name,last_name, phone) 
Values(5,'Tom','Maww',913456),(6,'Alex','Bud',9122224);

UPDATE Owner SET phone = '1234567890' WHERE owner_id = '1';
SELECT * FROM Owner WHERE first_name = 'Emma';

DELETE FROM Owner
WHERE owner_id = 4;
SELECT * FROM Owner;
SELECT first_name, phone FROM Owner;
SELECT * FROM Owner
WHERE last_name = 'Strt';
SELECT * FROM Owner WHERE first_name LIKE 'S%';
SELECT owner_id, COUNT(*) AS number_of_pets FROM Pet GROUP BY owner_id;


CREATE TABLE Pet (
    pet_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    species VARCHAR(30),
    breed VARCHAR(50),
    owner_id INT,
    FOREIGN KEY (owner_id) REFERENCES Owner(owner_id)
);
INSERT INTO Pet(pet_id,name,species, breed,owner_id) 
Values(23,'Tuffy','Dog','Labrador',2),
	  (12,'Almond','Dog','Labrador',3),
	  (11,'Maxy','Cat','Persian',1);
INSERT INTO Pet(pet_id,name,species, breed,owner_id) 
Values(1,'Tom','Dog','German Shephard',5),
	  (2,'Ally','Dog','Poodle',6);
INSERT INTO Pet(pet_id,name,species, breed,owner_id) 
Values(3,'Ted','Dog','German Shephard',5),
	  (4,'Olle','Cat','Persian',6);
SELECT * FROM Pet WHERE species = 'Dog';
SELECT * FROM Pet ORDER BY name ASC;
SELECT owner_id, COUNT(*) AS per_count FROM Pet GROUP BY owner_id HAVING COUNT(*) > 1;


CREATE TABLE Employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    role VARCHAR(50)
);
INSERT INTO Employee(employee_id,first_name,role) 
Values (1,'Jack','Stylist'),
(2,'Sam','Grommer');
INSERT INTO Employee(employee_id,first_name,role) VALUES(3,'JIM','TRAINER'),(4,'ROCKY','PLAYER');
INSERT INTO Employee(employee_id,first_name,role) VALUES(5,'WOX','CLEANER');

UPDATE Employee SET role = 'Cashier' WHERE employee_id = 5;
SELECT * FROM Employee WHERE role = 'Stylist' OR role = 'TRAINER';
SELECT * FROM Employee ORDER BY role DESC;

CREATE TABLE Service (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    service_name VARCHAR(100),
    price DECIMAL(8,2)
);
INSERT INTO Service(service_id,service_name,price) 
Values (1,'Bath',20),(2,'Hair Cut',10),(3,'Day Boarding',50),(4,'Styling',30);
UPDATE Service SET price = price + 5 where service_id = '1'; 
SELECT * FROM Service WHERE price BETWEEN 15 AND 40;
SELECT * FROM Service WHERE service_name LIKE '%Cut%';
SELECT service_name, AVG(price) AS average_price FROM Service GROUP BY service_name;


CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    pet_id INT,
    employee_id INT,
    appointment_date DATETIME,
    FOREIGN KEY (pet_id) REFERENCES Pet(pet_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);
INSERT INTO Appointment (appointment_id, pet_id, employee_id, appointment_date) VALUES
(1, 11, 1, '2025-09-20 10:00:00'),
(2, 12, 2, '2025-09-21 14:30:00'),
(3, 23, 2, '2025-09-22 09:00:00');
ALTER TABLE Appointment MODIFY employee_id INT DEFAULT NULL;
INSERT INTO Appointment (appointment_id, pet_id, appointment_date) VALUES
(4, 11,'2025-09-20 10:00:00');
SELECT * FROM Appointment WHERE appointment_date > '2025-09-20';
SELECT * FROM Appointment WHERE pet_id = 11 AND employee_id IS NOT NULL;
SELECT employee_id, COUNT(*) AS total_appointments FROM Appointment WHERE employee_id IS NOT NULL GROUP BY employee_id;
SELECT COUNT(*) AS total_appointments FROM Appointment;




CREATE TABLE Appointment_Service (
    appointment_id INT,
    service_id INT,
    PRIMARY KEY (appointment_id, service_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);
INSERT INTO Appointment_Service(appointment_id,service_id) VALUES(1,2),(2,1),(3,4);
SELECT appointment_id, SUM(amount) AS total_amount_paid FROM Payment GROUP BY appointment_id;
SELECT appointment_id, COUNT(service_id) AS service_count FROM Appointment_Service GROUP BY appointment_id;
SELECT AVG(service_count) AS avg_services_per_appointment FROM (SELECT appointment_id, COUNT(service_id) AS service_count FROM Appointment_Service GROUP BY appointment_id
) AS service_summary;



CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT,
    amount DECIMAL(8,2),
    payment_date DATETIME,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);
INSERT INTO Payment(payment_id,appointment_id,amount,payment_date)VALUES(1,1,10,'2025-09-20 10:00:00'),(2,1,20,'2025-09-21 14:00:00'),(3,3,50,'2025-09-22 09:00:00');
DELETE FROM Payment WHERE payment_id = 2;
SELECT * FROM Payment ORDER BY payment_date DESC LIMIT 2;
SELECT SUM(amount) AS total_revenue FROM Payment;
SELECT DATE(payment_date) AS payment_day, SUM(amount) AS daily_revenue FROM Payment GROUP BY DATE(payment_date) ORDER BY payment_day;



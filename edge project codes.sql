CREATE TABLE Flight (
  id INT PRIMARY KEY,
  flight_number VARCHAR(50) UNIQUE,
  departure_airport VARCHAR(100),
  arrival_airport VARCHAR(100),
  departure_date DATETIME,
  arrival_date DATETIME,
  aircraft_type VARCHAR(50),
  capacity INT,
  status VARCHAR(50)
);

INSERT INTO Flight (id, flight_no, departure_airport, arrival_airport, departure_date, arrival_date, aircraft_type, capacity, status)
VALUES 
(1, 'UA101', 'KJFK', 'KLAX', '2024-06-02 08:00:00', '2024-06-02 11:00:00', 'Boeing 737', 150, 'Scheduled'),
(2, 'AA202', 'KLAX', 'KMIA', '2024-06-02 12:00:00', '2024-06-02 19:00:00', 'Airbus A320', 180, 'On Time'),
(3, 'DL303', 'KMIA', 'KJFK', '2024-06-02 20:00:00', '2024-06-03 00:00:00', 'Boeing 757', 200, 'Delayed'),
(4, 'WN404', 'KORD', 'KLAS', '2024-06-02 14:00:00', '2024-06-02 16:00:00', 'Boeing 737', 120, 'Scheduled'),
(5, 'UA505', 'KLAX', 'KSFO', '2024-06-02 18:00:00', '2024-06-02 19:30:00', 'Airbus A319', 140, 'On Time');


CREATE TABLE Fare (
  id INT PRIMARY KEY,
  flight_id INT,
  fare_class VARCHAR(50),
  base_price DECIMAL(10, 2),
  currency VARCHAR(10),
  taxes_and_fees DECIMAL(10, 2),
  availability INT,
  FOREIGN KEY (flight_id) REFERENCES Flights(id)
);

INSERT INTO Fare (id, flight_id, fare_class, base_price, currency, taxes_and_fees, availability)
VALUES 
(1, 1, 'Economy', 200.00, 'USD', 20.00, 100),
(2, 1, 'Business', 500.00, 'USD', 30.00, 20),
(3, 2, 'Economy', 250.00, 'USD', 25.00, 120),
(4, 3, 'First Class', 1000.00, 'USD', 50.00, 10),
(5, 4, 'Economy', 180.00, 'USD', 20.00, 90);

CREATE TABLE Passenger (
  id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(50) UNIQUE,
  phone_number VARCHAR(20),
  passport_number VARCHAR(50)
);

INSERT INTO Passenger (id, first_name, last_name, email, phone_number, passport_number)
VALUES 
(1, 'John', 'Doe', 'johndoe@example.com', '123-456-7890', 'AB123456'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '098-765-4321', 'CD789012'),
(3, 'Michael', 'Brown', 'michaelbrown@example.com', '555-123-4567', 'EF901234'),
(4, 'Emily', 'Johnson', 'emilyjohnson@example.com', '876-543-2109', 'GH567890'),
(5, 'David', 'Lee', 'davidlee@example.com', '345-678-9012', 'IJ234567');


CREATE TABLE Reservation (
  id INT PRIMARY KEY,
  passenger_id INT,
  flight_id INT,
  fare_id INT,
  booking_date DATETIME,
  confirmation_code VARCHAR(50),
  number_of_passengers INT,
  special_requests VARCHAR(255),
  FOREIGN KEY (id) REFERENCES Passenger(id),
  FOREIGN KEY (id) REFERENCES Flight(id),
  FOREIGN KEY (id) REFERENCES Fare(id)
);

INSERT INTO Reservation (id, passenger_id, flight_id, fare_id, booking_date, confirmation_code, number_of_passengers, special_requests)
VALUES 
(1, 1, 1, 1, '2022-01-01 12:00:00', 'RESV001', 1, 'Window seat'),
(2, 2, 2, 2, '2022-01-05 14:00:00', 'RESV002', 2, 'Vegetarian meal'),
(3, 3, 3, 3, '2022-01-10 10:00:00', 'RESV003', 1, 'Aisle seat'),
(4, 4, 4, 4, '2022-01-15 16:00:00', 'RESV004', 3, 'Extra legroom'),
(5, 5, 1, 1, '2022-01-20 18:00:00', 'RESV005', 1, 'No special requests');

CREATE TABLE Payment (
  id INT PRIMARY KEY,
  reservation_id INT,
  payment_method VARCHAR(50),
  payment_reference VARCHAR(50),
  amount_paid DECIMAL(10, 2),
  payment_date DATETIME,
  currency VARCHAR(10),
  FOREIGN KEY (id) REFERENCES Reservation(id)
);

INSERT INTO Payment (id, reservation_id, payment_method, payment_reference, amount_paid, payment_date, currency)
VALUES 
(1, 1, 'Credit Card', 'CC001', 200.00, '2022-01-01 12:00:00', 'USD'),
(2, 2, 'Debit Card', 'DC002', 400.00, '2022-01-05 14:00:00', 'EUR'),
(3, 3, 'Cash', 'CA003', 150.00, '2022-01-10 10:00:00', 'TAKA'),
(4, 4, 'Credit Card', 'CC004', 600.00, '2022-01-15 16:00:00', 'USD'),
(5, 5, 'Debit Card', 'DC005', 250.00, '2022-01-20 18:00:00', 'EUR');

CREATE TABLE Cancellation (
  id INT PRIMARY KEY,
  reservation_id INT,
  cancellation_date DATETIME,
  cancellation_reason VARCHAR(255),
  cancellation_fee DECIMAL(10, 2),
  FOREIGN KEY (id) REFERENCES Reservation(id)
);

INSERT INTO Cancellation (id, reservation_id, cancellation_date, cancellation_reason, cancellation_fee)
VALUES 
(1, 1, '2022-01-02 12:00:00', 'Flight changed', 50.00),
(2, 2, '2022-01-06 14:00:00', 'Personal reasons', 100.00),
(3, 3, '2022-01-11 10:00:00', 'Double booking', 0.00),
(4, 4, '2022-01-16 16:00:00', 'Company policy', 200.00),
(5, 5, '2022-01-21 18:00:00', 'Health issues', 150.00);

CREATE TABLE Airport (
  id INT PRIMARY KEY,
  iata_code VARCHAR(3) UNIQUE,
  icao_code VARCHAR(4) UNIQUE,
  name VARCHAR(255),
  city VARCHAR(255),
  country VARCHAR(255),
  terminals INT
);

INSERT INTO Airport (id, iata_code, icao_code, name, city, country, terminals)
VALUES 
(1, 'JFK', 'KJFK', 'John F. Kennedy International Airport', 'New York City', 'United States', 6),
(2, 'LHR', 'EGLL', 'London Heathrow Airport', 'London', 'United Kingdom', 4),
(3, 'DXB', 'OMDB', 'Dubai International Airport', 'Dubai', 'United Arab Emirates', 3),
(4, 'FRA', 'EDDF', 'Frankfurt Airport', 'Frankfurt', 'Germany', 2),
(5, 'SYD', 'YSSY', 'Sydney Kingsford Smith Airport', 'Sydney', 'Australia', 3);

CREATE TABLE Crew_Member (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  job_title VARCHAR(50),
  license_number VARCHAR(50),
  contact_information VARCHAR(255)
);


INSERT INTO Crew_Member (id, name, job_title, license_number, contact_information)
VALUES 
(1, 'John Smith', 'Pilot', 'PL123456', 'john.smith@email.com, 123-456-7890'),
(2, 'Jane Doe', 'Copilot', 'CP789012', 'jane.doe@email.com, 098-765-4321'),
(3, 'Michael Brown', 'Flight Attendant', 'FA345678', 'ichael.brown@email.com, 555-123-4567'),
(4, 'Emily Johnson', 'Pilot', 'PL901234', 'emily.johnson@email.com, 777-888-9999'),
(5, 'David Lee', 'Flight Attendant', 'FA567890', 'david.lee@email.com, 333-444-5555'); 

CREATE TABLE Crew_Scheduling (
  id INT PRIMARY KEY,
  flight_id INT,
  crew_member_id INT,
  role VARCHAR(50),
  FOREIGN KEY (id) REFERENCES Flight(id),
  FOREIGN KEY (id) REFERENCES Crew_Member(id)
);

INSERT INTO Crew_Scheduling (id, flight_id, crew_member_id, role)
VALUES 
(1, 1, 1, 'Captain'),
(2, 1, 2, 'First Officer'),
(3, 2, 3, 'Flight Attendant'),
(4, 3, 4, 'Captain'),
(5, 4, 5, 'Flight Attendant');


CREATE TABLE Baggage_Handling (
  id INT PRIMARY KEY,
  reservation_id INT,
  passenger_id INT,
  tag_number VARCHAR(50) UNIQUE,
  weight DECIMAL,
  status VARCHAR(50),
  last_known_location VARCHAR(255),
  FOREIGN KEY (id) REFERENCES Reservation(id),
  FOREIGN KEY (id) REFERENCES Passenger(id)
);

INSERT INTO Baggage_Handling (id, reservation_id, passenger_id, tag_number, weight, status, last_known_location)
VALUES 
(1, 1, 1, 'BAG001', 25.5, 'Checked in', 'Departure airport'),
(2, 1, 1, 'BAG002', 30.0, 'In transit', 'En route'),
(3, 2, 2, 'BAG003', 20.0, 'Delivered', 'Arrival airport'),
(4, 3, 3, 'BAG004', 35.0, 'Checked in', 'Departure airport'),
(5, 4, 4, 'BAG005', 28.0, 'In transit', 'En route');

CREATE TABLE Frequent_Flyer_Program (
  id INT PRIMARY KEY,
  passenger_id INT,
  membership_tier VARCHAR(50),
  miles_balance INT,
  status_expiry_date DATETIME,
  FOREIGN KEY (id) REFERENCES Passenger(id)
);

INSERT INTO Frequent_Flyer_Program (id, passenger_id, membership_tier, miles_balance, status_expiry_date)
VALUES 
(1, 1, 'Silver', 10000, '2025-02-28 00:00:00'),
(2, 2, 'Gold', 50000, '2026-03-31 00:00:00'),
(3, 3, 'Platinum', 100000, '2027-04-30 00:00:00'),
(4, 4, 'Silver', 5000, '2025-01-31 00:00:00'),
(5, 5, 'Gold', 75000, '2026-06-30 00:00:00');

CREATE TABLE Route_Network (
  id INT PRIMARY KEY,
  origin_airport_id INT,
  destination_airport_id INT,
  distance DECIMAL,
  travel_time DECIMAL,
  frequency VARCHAR(50),
  FOREIGN KEY (origin_airport_id) REFERENCES Airport(id),
  FOREIGN KEY (destination_airport_id) REFERENCES Airport(id)
);

INSERT INTO Route_Network (id, origin_airport_id, destination_airport_id, distance, travel_time, frequency)
VALUES 
(1, 1, 2, 500.0, 1.5, 'Daily'),
(2, 2, 3, 800.0, 2.0, 'Weekly'),
(3, 3, 1, 700.0, 1.8, 'Seasonal'),
(4, 4, 5, 300.0, 0.8, 'Daily'),
(5, 5, 4, 400.0, 1.2, 'Bi-Weekly');

CREATE TABLE Audit_Logs (
  id INT PRIMARY KEY,
  action VARCHAR(255),
  timestamp DATETIME,
  data_affected TEXT
  
);

INSERT INTO Audit_Logs (id, user_id, action, timestamp, data_affected)
VALUES 
(1,  'Reservation created', '2023-01-01 10:00:00', 'Flight from JFK to LAX on 2023-02-01 for 1 passenger'),
(2,  'Flight cancelled', '2023-01-02 15:30:00', 'Flight from LAX to JFK on 2023-02-01 for 1 passenger'),
(3,  'Mileage balance updated', '2023-01-03 09:45:00', 'Added 1000 miles to passenger 1'),
(4,  'Membership tier upgraded', '2023-01-04 11:15:00', 'Upgraded passenger 2 from Silver to Gold'),
(5,  'Route added', '2023-01-05 16:30:00', 'Added new route from JFK to LHR with distance 5500 km');


CREATE TABLE CUSTOMER_RELATIONSHIP_MANAGEMENT (
  customer_id INT PRIMARY KEY,
  contact_information TEXT,
  communication_preferences VARCHAR(50),
  booking_history VARCHAR(255),
  frequent_flyer_id INT,
  FOREIGN KEY (frequent_flyer_id) REFERENCES Frequent_Flyer_Program(id)
);

INSERT INTO CUSTOMER_RELATIONSHIP_MANAGEMENT (customer_id, contact_information, communication_preferences, booking_history, frequent_flyer_id)
VALUES 
(1, 'John Doe, johndoe@example.com, 123-456-7890', 'Email', 'Flight 101, Flight 202, Flight 303', 1),
(2, 'Jane Smith, janesmith@example.com, 987-654-3210', 'Phone', 'Flight 404, Flight 505, Flight 606', 2),
(3, 'Bob Johnson, bobjohnson@example.com, 555-123-4567', 'Both', 'Flight 707, Flight 808, Flight 909', 3),
(4, 'Alice Brown, alicebrwn@example.com, 777-888-9999', 'Email', 'Flight 1010, Flight 1111, Flight 1212', 4),
(5, 'Mike Davis, mikedavis@example.com, 333-444-5555', 'Phone', 'Flight 1313, Flight 1414, Flight 1515', 5);


CREATE TABLE In_Flight_Services (
  id INT PRIMARY KEY,
  service_type VARCHAR(50),
  description TEXT,
  price DECIMAL,
  availability INT
);

INSERT INTO In_Flight_Services (id, service_type, description, price, availability)
VALUES 
(1, 'Meals', 'In-flight meal service offering a selection of snacks and beverages', 10.99, 50),
(2, 'Beverages', 'Complimentary soft drinks, juice, and water', 0.00, 100),
(3, 'Entertainment', 'In-flight entertainment system featuring movies, TV shows, and music', 0.00, 200),
(4, 'Premium Meals', 'Upgraded meal service featuring gourmet cuisine', 24.99, 20),
(5, 'Wi-Fi', 'In-flight internet access for a fee', 9.99, 50);

CREATE TABLE Passenger_Feedback (
  id INT PRIMARY KEY,
  reservation_id INT,
  passenger_id INT,
  feedback_type VARCHAR(50),
  feedback_text TEXT,
  rating INT,
  FOREIGN KEY (id) REFERENCES Reservation(id),
  FOREIGN KEY (id) REFERENCES Passenger(id)
);

INSERT INTO Passenger_Feedback (id, reservation_id, passenger_id, feedback_type, feedback_text, rating)
VALUES 
(1, 1, 1, 'Praise', 'The flight attendants were very friendly and helpful!', 5),
(2, 2, 2, 'Complaint', 'The in-flight meal was cold and tasteless.', 2),
(3, 3, 3, 'Suggestion', 'It would be great if you could offer more vegetarian meal options.', 4),
(4, 4, 4, 'Praise', 'The pilot did an excellent job navigating through turbulence!', 5),
(5, 5, NULL, 'Complaint', 'The flight was delayed by 2 hours without any explanation.', 1);

CREATE TABLE Mechanic (
  id INT PRIMARY KEY,
  name VARCHAR(50),
  designation VARCHAR(50),
  salary DECIMAL(10, 2)
);

INSERT INTO Mechanic (id, name, designation, salary)
VALUES 
(1, 'John Doe', 'Senior Mechanic', 50000.00),
(2, 'Jane Smith', 'Junior Mechanic', 35000.00),
(3, 'Bob Johnson', 'Lead Mechanic', 60000.00),
(4, 'Alice Brown', 'Apprentice Mechanic', 25000.00),
(5, 'Mike Davis', 'Mechanic Supervisor', 70000.00);

CREATE TABLE MaintenanceLogs (
  id INT PRIMARY KEY,
  aircraft_id INT,
  date DATETIME,
  work_performed TEXT,
  mechanic_id INT,
  next_maintenance_due DATETIME,
  FOREIGN KEY (mechanic_id) REFERENCES Mechanic(id)
);

INSERT INTO MaintenanceLogs (id, date, work_performed, mechanic_id, next_maintenance_due)
VALUES 
(1,  '2022-01-01 10:00:00', 'Oil change and tire rotation', 1, '2022-03-01 10:00:00'),
(2,  '2022-01-15 14:00:00', 'Engine inspection and repair', 2, '2022-06-01 14:00:00'),
(3,  '2022-02-01 08:00:00', 'Brake pad replacement', 3, '2022-08-01 08:00:00'),
(4,  '2022-03-01 12:00:00', 'Fuel system cleaning', 1, '2022-09-01 12:00:00'),
(5,  '2022-04-01 16:00:00', 'Avionics system upgrade', 4, '2022-12-01 16:00:00');



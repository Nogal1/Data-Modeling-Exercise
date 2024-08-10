-- Drop and create the database
DROP DATABASE IF EXISTS air_traffic;
CREATE DATABASE air_traffic;
\c air_traffic

-- Create table for airlines
CREATE TABLE airlines (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

-- Create table for locations (cities and countries)
CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    city TEXT NOT NULL,
    country TEXT NOT NULL,
    UNIQUE(city, country)
);

-- Create table for passengers
CREATE TABLE passengers (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    UNIQUE(first_name, last_name)
);

-- Create table for flights
CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    airline_id INTEGER REFERENCES airlines(id) ON DELETE CASCADE,
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    from_location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    to_location_id INTEGER REFERENCES locations(id) ON DELETE CASCADE,
    CHECK(departure_time < arrival_time)
);

-- Create table for tickets
CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    passenger_id INTEGER REFERENCES passengers(id) ON DELETE CASCADE,
    flight_id INTEGER REFERENCES flights(id) ON DELETE CASCADE,
    seat TEXT NOT NULL,
    UNIQUE(passenger_id, flight_id)
);

-- Insert data into airlines
INSERT INTO airlines (name) VALUES
  ('United'),
  ('British Airways'),
  ('Delta'),
  ('TUI Fly Belgium'),
  ('Air China'),
  ('American Airlines'),
  ('Avianca Brasil');

-- Insert data into locations
INSERT INTO locations (city, country) VALUES
  ('Washington DC', 'United States'),
  ('Seattle', 'United States'),
  ('Tokyo', 'Japan'),
  ('London', 'United Kingdom'),
  ('Los Angeles', 'United States'),
  ('Las Vegas', 'United States'),
  ('Mexico City', 'Mexico'),
  ('Paris', 'France'),
  ('Casablanca', 'Morocco'),
  ('Dubai', 'UAE'),
  ('Beijing', 'China'),
  ('New York', 'United States'),
  ('Charlotte', 'United States'),
  ('Cedar Rapids', 'United States'),
  ('Chicago', 'United States'),
  ('New Orleans', 'United States'),
  ('Sao Paolo', 'Brazil'),
  ('Santiago', 'Chile');

-- Insert data into passengers
INSERT INTO passengers (first_name, last_name) VALUES
  ('Jennifer', 'Finch'),
  ('Thadeus', 'Gathercoal'),
  ('Sonja', 'Pauley'),
  ('Waneta', 'Skeleton'),
  ('Berkie', 'Wycliff'),
  ('Alvin', 'Leathes'),
  ('Cory', 'Squibbes');

-- Insert data into flights
INSERT INTO flights (airline_id, departure_time, arrival_time, from_location_id, to_location_id) VALUES
  (1, '2018-04-08 09:00:00', '2018-04-08 12:00:00', 1, 2), -- United: Washington DC -> Seattle
  (2, '2018-12-19 12:45:00', '2018-12-19 16:15:00', 3, 4), -- British Airways: Tokyo -> London
  (3, '2018-01-02 07:00:00', '2018-01-02 08:03:00', 5, 6), -- Delta: Los Angeles -> Las Vegas
  (3, '2018-04-15 16:50:00', '2018-04-15 21:00:00', 2, 7), -- Delta: Seattle -> Mexico City
  (4, '2018-08-01 18:30:00', '2018-08-01 21:50:00', 8, 9), -- TUI Fly Belgium: Paris -> Casablanca
  (5, '2018-10-31 01:15:00', '2018-10-31 12:55:00', 10, 11), -- Air China: Dubai -> Beijing
  (1, '2019-02-06 06:00:00', '2019-02-06 07:47:00', 12, 13), -- United: New York -> Charlotte
  (6, '2018-12-22 14:42:00', '2018-12-22 15:56:00', 14, 15), -- American Airlines: Cedar Rapids -> Chicago
  (6, '2019-02-06 16:28:00', '2019-02-06 19:18:00', 13, 16), -- American Airlines: Charlotte -> New Orleans
  (7, '2019-01-20 19:30:00', '2019-01-20 22:45:00', 17, 18); -- Avianca Brasil: Sao Paolo -> Santiago

-- Insert data into tickets
INSERT INTO tickets (passenger_id, flight_id, seat) VALUES
  (1, 1, '33B'), -- Jennifer Finch on United: Washington DC -> Seattle
  (2, 2, '8A'), -- Thadeus Gathercoal on British Airways: Tokyo -> London
  (3, 3, '12F'), -- Sonja Pauley on Delta: Los Angeles -> Las Vegas
  (1, 4, '20A'), -- Jennifer Finch on Delta: Seattle -> Mexico City
  (4, 5, '23D'), -- Waneta Skeleton on TUI Fly Belgium: Paris -> Casablanca
  (2, 6, '18C'), -- Thadeus Gathercoal on Air China: Dubai -> Beijing
  (5, 7, '9E'), -- Berkie Wycliff on United: New York -> Charlotte
  (6, 8, '1A'), -- Alvin Leathes on American Airlines: Cedar Rapids -> Chicago
  (5, 9, '32B'), -- Berkie Wycliff on American Airlines: Charlotte -> New Orleans
  (7, 10, '10D'); -- Cory Squibbes on Avianca Brasil: Sao Paolo -> Santiago

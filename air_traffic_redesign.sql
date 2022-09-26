-- from the terminal run:
-- psql < air_traffic.sql

DROP DATABASE IF EXISTS air_traffic_redesign;

CREATE DATABASE air_traffic_redesign;

\c air_traffic_redesign

CREATE TABLE countries
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE cities
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  country INTEGER REFERENCES countries ON DELETE CASCADE
);

CREATE TABLE airlines
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE flights
(
  id SERIAL PRIMARY KEY,
  departure TIMESTAMP NOT NULL,
  arrival TIMESTAMP NOT NULL,
  airline INTEGER REFERENCES airlines ON DELETE CASCADE,
  from_city INTEGER REFERENCES cities ON DELETE CASCADE,
  from_country INTEGER REFERENCES countries ON DELETE CASCADE,
  to_city INTEGER REFERENCES cities ON DELETE CASCADE,
  to_country INTEGER REFERENCES countries ON DELETE CASCADE
);

CREATE TABLE passengers
(
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL
);

CREATE TABLE passengers_flight
(
  id SERIAL PRIMARY KEY,
  passenger_id INTEGER REFERENCES passengers ON DELETE CASCADE,
  flight_id INTEGER REFERENCES flights ON DELETE CASCADE,
  seat TEXT NOT NULL
);

INSERT INTO countries (name)
VALUES ('United States'), ('Japan'), ('United Kingdom'), ('Mexico');

INSERT INTO cities (name, country)
VALUES ('Washington DC', 1), ('Seattle', 1), ('Tokyo', 2), ('London', 3), ('Mexico City', 4);

INSERT INTO airlines (name)
VALUES ('United'), ('British Airways'), ('Delta');

INSERT INTO flights (departure, arrival, airline, from_city, from_country, to_city, to_country)
VALUES ('2018-04-08 09:00:00', '2018-04-08 12:00:00',1, 1, 1, 2, 1), ('2018-12-19 12:45:00', '2018-12-19 16:15:00', 2, 3, 2, 4, 3), ('2018-04-15 16:50:00', '2018-04-15 21:00:00',3,2,1,5,4);

INSERT INTO passengers (first_name, last_name)
VALUES ('Jennifer', 'Finch'), ('Thadeus', 'Gathercoal');

INSERT INTO passengers_flight (passenger_id, flight_id, seat)
VALUES (1, 1, '33B'), (2, 2, '8A'), (1, 3, '20A');
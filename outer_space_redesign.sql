-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space_redesign;

CREATE DATABASE outer_space_redesign;

\c outer_space_redesign

CREATE TABLE orbits_around
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE galaxy 
(
  id SERIAL PRIMARY KEY,
  galaxy_name TEXT NOT NULL
);

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around INTEGER REFERENCES orbits_around ON DELETE CASCADE,
  galaxy INTEGER REFERENCES galaxy ON DELETE CASCADE
);

CREATE TABLE moons
(
  id SERIAL PRIMARY KEY,
  moon_name TEXT NOT NULL,
  orbit_planet INTEGER REFERENCES planets ON DELETE CASCADE
);

INSERT INTO orbits_around (name)
VALUES ('The Sun'), ('Proxima Centauri'), ('Gliese 876');

INSERT INTO galaxy (galaxy_name)
VALUES ('Milky Way');

INSERT INTO planets(name, orbital_period_in_years, orbits_around, galaxy)
VALUES ('Earth', 1.00, 1, 1),
  ('Mars', 1.88, 1, 1),
  ('Venus', 0.62, 1, 1),
  ('Neptune', 164.8, 1, 1),
  ('Proxima Centauri b', 0.03, 2, 1),
  ('Gliese 876 b', 0.23, 3, 1);

INSERT INTO moons (moon_name, orbit_planet)
VALUES ('The Moon', 1), ('Phobos', 2), ('Deimos', 2), ('Naiad', 4)

/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' and date_of_birth < '2019-12-31';
SELECT name FROM animals WHERE neutered is TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered is TRUE;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;

-- TRANSCATIONS ACTIONS
UPDATE animals SET species = 'unspecified';
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon%';
UPDATE animals SET species = 'pokemon' WHERE species != 'digimon';
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
UPDATE animals SET weight_kg = weight_kg * -1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- ANSWERS USING QUERIES
-- Total Number of animals
SELECT COUNT(*) FROM animals;

-- Total number of animals with escape attempts
SELECT COUNT(*) FROM animals WHERE escape_attempts > 0;

-- Average Weight of animals
SELECT SUM(weight_kg) / COUNT(*) as average FROM animals;
SELECT AVG(weight_kg) FROM animals;

-- Most escape_attempts
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;

-- Minimum and maximum weight of each type of animal
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

-- Average number of escape attempts
SELECT species, SUM(escape_attempts) / COUNT(*) as average FROM animals WHERE date_of_birth >= '1990-01-01' and date_of_birth < '2000-12-31' GROUP BY species;

-- Animals that belong to Melody Pond
SELECT owner_id, name, full_name FROM owners INNER JOIN animals ON owners.id = animals.owner_id WHERE owners.full_name = 'Melody Pond';

-- Animals That are Pokemon
SELECT * FROM animals INNER JOIN species on species.id = animals.species_id WHERE species.name = 'Pokemon';

-- List Of Owners and animals
SELECT * FROM owners FULL OUTER JOIN animals ON owners.id = animals.owner_id;

-- List animals per species
SELECT species.name, COUNT(*) FROM species INNER JOIN animals ON species.id = animals.species_id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT * FROM animals INNER JOIN owners ON animals.owner_id = owners.id INNER JOIN species ON species.id = animals.species_id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- Animals owned by Dean Winchester that havent tried to escape
SELECT * FROM animals INNER JOIN owners ON owners.id = animals.owner_id WHERE owners.full_name = 'Dean Winchester' and animals.escape_attempts = 0;

-- Owner with the most animals
SELECT owners.full_name, COUNT(*) FROM animals INNER JOIN owners ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT DESC LIMIT 1;

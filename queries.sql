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

-- Join Tables queries
-- Last animal seen by William Tatcher
SELECT vets.name AS vet_name, animals.name AS animal_name, visits.date_of_visit AS last_visit FROM animals INNER JOIN visits ON animals.id = visits.animal_id INNER JOIN vets ON vets.id = visits.vet_id where vets.name='William Tatcher' ORDER BY  date_of_visit DESC LIMIT 1 ; 

-- Different animals seen by Stephanie Mendez
SELECT vets.name AS vet_name , COUNT(visits.date_of_visit) AS number_of_visits FROM visits INNER JOIN vets ON vets.id = visits.vet_id WHERE vets.name='Stephanie Mendez' GROUP BY vets.name;

-- All Vets and specialities including doctors with no specialities
SELECT specializations.species_id, specializations.vet_id, vets.name AS vet_name, species.name AS species_name FROM specializations FULL OUTER JOIN species ON species.id = specializations.species_id FULL OUTER JOIN vets ON vets.id = specializations.vet_id;

-- Animals visited Stephanie Mendez between april 1stand August 30th 2020
SELECT vets.name AS vet_name, animals.name AS animal_name, visits.date_of_visit as visit_date FROM animals INNER JOIN visits ON animals.id = visits.animal_id INNER JOIN vets ON vets.id = visits.vet_id WHERE vets.name='Stephanie Mendez' AND  date_of_visit BETWEEN '2020-04-01' And '2020-08-30'; 

-- Animal with the most visit to the vet
SELECT animals.name AS animal_name, COUNT(visits.date_of_visit) AS number_of_visits from visits INNER JOIN animals ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY COUNT(visits.date_of_visit) DESC LIMIT 1 ;

-- Maisy SmithFirst visit
SELECT vets.name AS vet_name, animals.name as animal_name, visits.date_of_visit AS first_visit FROM animals INNER JOIN visits ON animals.id = visits.animal_id INNER JOIN vets ON vets.id = visits.vet_id WHERE vets.name='Maisy Smith' ORDER BY  date_of_visit ASC limit 1;   

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.id AS animal_id, animals.name AS animal_name, animals.date_of_birth, vets.id AS vet_id,  vets.name AS vet_name, vets.age AS vet_age, date_of_visit FROM visits INNER JOIN animals ON animals.id = visits.animal_id INNER JOIN vets ON vets.id = visits.vet_id;

-- Visits with a vet and did not specialize in animal species
SELECT vets.name AS vet_name, COUNT(*) FROM visits INNER JOIN vets ON vets.id = visits.vet_id INNER JOIN specializations ON specializations.vet_id = visits.vet_id WHERE specializations.species_id IS NULL GROUP BY vets.name;

-- speciality maisy smith consider getting
SELECT vets.name AS vet_name, species.name AS species_name, COUNT(species.name) FROM visits LEFT JOIN animals ON animals.id = visits.animal_id INNER JOIN vets ON vets.id = visits.vet_id INNER JOIN species ON species.id = animals.species_id WHERE vets.name = 'Maisy Smith' GROUP BY vets.name, species.name ORDER BY COUNT DESC LIMIT 1;

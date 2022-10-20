/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', date '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', date '2018-11-15', 2, TRUE, 8.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', date '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', date '2017-05-12', 5, TRUE, 11.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', date '2020-02-08', 0, FALSE, -11.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', date '2021-11-15', 2, TRUE, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', date '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', date '2005-06-12', 1, TRUE, -45.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', date '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', date '1998-10-13', 3, TRUE, 17.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', date '2022-05-14', 4, TRUE, 22.0);

-- Insert data into the owners table
INSERT INTO owners(full_name, age) VALUES('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

-- Insert data into the species table
INSERT INTO species(name) VALUES('Pokemon'), ('Digimon');

-- Modify your inserted animals so it includes the species_id value if the name ends in mon it will be Digimon
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon%';

-- Modify your inserted animals so it includes the species_id value if the name does not end in mon it will be Pokemon
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Pokemon') WHERE name NOT LIKE '%mon%';

-- Update owner_id: Sam Smith owns Agumon
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';

-- Update owner_id: Jennifer Orwell owns Gabumon and Pikachu
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');

-- Update owner_id: Bob owns Devimon and Plantmon
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');

-- Update owner_id: Melody Pond owns Charmander, Squirtle, and Blossom
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

-- Update owner_id: Dean Winchester owns Angemon and Boarmon
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

-- Insert data in the vets table
INSERT INTO vets(name, age, date_of_graduation) VALUES('William Tatcher', 45, date '2000-04-23'), ('Maisy Smith', 26, date '2019-01-17'), ('Stephanie Mendez', 64, date '1981-05-04'), ('Jack Harkness', 38, date '2008-06-08');

-- Insert data in the specializations table
INSERT INTO specializations(species_id, vet_id) VALUES((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher'));
INSERT INTO specializations(species_id, vet_id) VALUES((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')), ((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'));
INSERT INTO specializations(species_id, vet_id) VALUES((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'));


-- Insert data in the visits table
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), date '2020-05-24'), ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),  date '2020-07-22');
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), date '2021-02-02');
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2020-01-05'), ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'),  date '2020-03-08'), ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'),  date '2020-05-14');
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), date '2021-05-04');
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), date '2021-02-24');
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2019-12-21'), ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'),  date '2020-08-10'), ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'),  date '2021-04-07');
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), date '2019-09-29');
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), date '2020-10-03'), ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'),  date '2020-11-04');
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), date '2019-01-24'), ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'),  date '2019-05-15'), ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'),  date '2020-02-27'), ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'),  date '2020-08-03');
INSERT INTO visits(animal_id, vet_id, date_of_visit) VALUES((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), date '2020-05-24'), ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'),  date '2021-01-11');

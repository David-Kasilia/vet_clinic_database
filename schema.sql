/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE NOT NULL,
    escape_attempts INT,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    species VARCHAR(250),
    PRIMARY KEY(id)
);

-- Owners table
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(id)
);

-- Species Table
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250) NOT NULL,
    PRIMARY KEY(id)
);

-- Remove species column
ALTER TABLE animals DROP COLUMN  species;

-- Add species_id Column which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT references species(id);

-- Add owner_id Column which is a foreign key referencing owners table
ALTER TABLE animals ADD COLUMN owner_id INT references owners(id);

-- vets Table
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL,
    PRIMARY KEY(id)
);

-- "join table" specializations Table to handle relationship
CREATE TABLE specializations (
    id INT GENERATED ALWAYS AS IDENTITY,
    species_id INT NOT NULL,
    vet_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (species_id) REFERENCES species (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id)
);

-- "join table" visits Table to handle relationship
CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    animal_id INT NOT NULL,
    vet_id INT NOT NULL,
    date_of_visit DATE NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY (animal_id) REFERENCES animals (id),
    FOREIGN KEY (vet_id) REFERENCES vets (id)

);

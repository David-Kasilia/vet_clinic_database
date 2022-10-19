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

